//
//  GifViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import <Parse/Parse.h>
#import "GifViewController.h"
#import "AnimatedGif.h"
#import "UIImageView+AnimatedGif.h"
#import "Workout.h"
#import "AddToWorkoutViewController.h"
#import "WorkoutViewController.h"

@interface GifViewController ()

@property (nonatomic, assign) BOOL isLiked;
@property (nonatomic, strong) PFQuery *workoutQuery;

@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.workoutQuery = [Workout query];
    self.title = self.detailExercise.name;
    [self.workoutQuery whereKey:@"title" equalTo:@"Liked Exercises"];
    [self.workoutQuery whereKey:@"author" equalTo:PFUser.currentUser];
    [self.workoutQuery findObjectsInBackgroundWithBlock:^(NSArray<Workout *> * _Nullable workouts, NSError * _Nullable error) {
        if (workouts) {
            if ([workouts[0].exercises containsObject:self.detailExercise.exerciseID]) {
                [self setIsLiked:YES];
            } else {
                [self setIsLiked:NO];
            }
            
        }
        [self setExerciseProperties:self.detailExercise];
    }];
    
}

- (void) setExerciseProperties:(Exercise *)exercise {
    AnimatedGif *newGif = [AnimatedGif getAnimationForGifAtUrl:exercise.gifUrl];
    [self.gifImageView setAnimatedGif:newGif startImmediately:YES];
    self.nameLabel.text = [exercise.name capitalizedString];
    self.nameLabel.animationCurve = UIViewAnimationCurveEaseIn;
    self.nameLabel.fadeLength = 10.0;
    self.nameLabel.scrollDuration = 3.0;
    self.equipmentLabel.text = [NSString stringWithFormat:@"Equipment: %@", [exercise.equipment capitalizedString]];
    self.bodyPartLabel.text = [NSString stringWithFormat:@"Body Part: %@", [exercise.bodyPart capitalizedString]];
    self.targetMuscleLabel.text =  [NSString stringWithFormat:@"Target Muscle: %@", [exercise.target capitalizedString]];
    UIImage *likedHeart = [[UIImage systemImageNamed:@"heart.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage *unlikedHeart = [[UIImage systemImageNamed:@"heart"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    if (self.isLiked) {
        [self.likeButtonLabel setImage:likedHeart forState:UIControlStateNormal];
        self.likeButtonLabel.tintColor = [UIColor colorWithRed:30.0f/255.0f
                                                    green:215.0f/255.0f
                                                     blue:96.0f/255.0f
                                                    alpha:1.0f];
    } else {
        [self.likeButtonLabel setImage:unlikedHeart forState:UIControlStateNormal];
        self.likeButtonLabel.tintColor = [UIColor whiteColor];
    }
    [self.view addSubview:self.gifImageView];
}

- (IBAction)didTapLikeButton:(id)sender {
    if (!self.isLiked) {
        [self.workoutQuery findObjectsInBackgroundWithBlock:^(NSArray<Workout *> * _Nullable workouts, NSError * _Nullable error) {
            if (workouts) {
                [Workout updateUserWorkout:workouts[0] withExercise:self.detailExercise withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                    [self setIsLiked:YES];
                    [self setExerciseProperties:self.detailExercise];
                }];
            }
        }];
    } else {
        [self.workoutQuery findObjectsInBackgroundWithBlock:^(NSArray<Workout *> * _Nullable workouts, NSError * _Nullable error) {
            if (workouts) {
                [Workout deleteExerciseFromWorkout:workouts[0] withExercise:self.detailExercise withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                    [self setIsLiked:NO];
                    [self setExerciseProperties:self.detailExercise];
                }];
            }
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailViewToAddToWorkoutSegue"]) {
        Exercise *exerciseToSend = self.detailExercise;
        UINavigationController *navigationController = [segue destinationViewController];
        AddToWorkoutViewController *addToWorkoutVC = (AddToWorkoutViewController*) navigationController.topViewController;
        addToWorkoutVC.selectedExercise = exerciseToSend;
    }
}

@end

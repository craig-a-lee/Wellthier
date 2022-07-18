//
//  GifViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//


#import "AFNetworking.h"
#import "GifViewController.h"
#import "AnimatedGif.h"
#import "UIImageView+AnimatedGif.h"
#import "Parse/Parse.h"
#import "Workout.h"

@interface GifViewController ()

@property (nonatomic, assign) BOOL isLiked;
@property (strong, nonatomic) PFQuery *workoutQuery;

@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.workoutQuery = [Workout query];
    [self.workoutQuery whereKey:@"title" equalTo:@"Liked Exercises"];
    [self.workoutQuery whereKey:@"author" equalTo:PFUser.currentUser];
    [self.workoutQuery findObjectsInBackgroundWithBlock:^(NSArray<Workout *> * _Nullable workouts, NSError * _Nullable error) {
        if (workouts) {
            // do something with the data fetched
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
    self.name.text = [exercise.name capitalizedString];
    self.name.animationCurve = UIViewAnimationCurveEaseIn;
    self.name.fadeLength = 10.0;
    self.name.scrollDuration = 3.0;
    self.equipment.text = [exercise.equipment capitalizedString];
    self.bodyPart.text = [exercise.bodyPart capitalizedString];
    self.targetMuscle.text = [exercise.target capitalizedString];
    if (self.isLiked) {
        [self.likeButton setImage: [UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage: [UIImage imageNamed:@"heart.fill"] forState:UIControlStateNormal];
    }
    [self.view addSubview:self.gifImageView];
}

- (IBAction)didTapLikeButton:(id)sender {
    if (!self.isLiked) {
        [self.workoutQuery findObjectsInBackgroundWithBlock:^(NSArray<Workout *> * _Nullable workouts, NSError * _Nullable error) {
            if (workouts) {
                // do something with the data fetched
                [Workout updateUserWorkout:workouts[0] withExercise:self.detailExercise withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                    [self setIsLiked:YES];
                    [self setExerciseProperties:self.detailExercise];
                }];
            }
        }];
    } else {
        [self.workoutQuery findObjectsInBackgroundWithBlock:^(NSArray<Workout *> * _Nullable workouts, NSError * _Nullable error) {
            if (workouts) {
                // do something with the data fetched
                [Workout deleteExerciseFromWorkout:workouts[0] withExercise:self.detailExercise withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                    [self setIsLiked:NO];
                    [self setExerciseProperties:self.detailExercise];
                }];
            }
        }];
    }
}

@end

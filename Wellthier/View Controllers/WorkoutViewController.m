//
//  WorkoutViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/14/22.
//

#import <Parse/Parse.h>
#import "WorkoutViewController.h"
#import "Exercise.h"
#import "GifViewController.h"
#import "ExerciseCell.h"
#import "ExerciseAPIManager.h"
#import "ExerciseSharedManager.h"
#import "AddToWorkoutViewController.h"

@interface WorkoutViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, AddToWorkoutViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) AddToWorkoutViewController *addToWorkoutController;

@end

@implementation WorkoutViewController

- (id) init {
    self = [super init];
    if (self) {
        self.addToWorkoutController = [AddToWorkoutViewController new];
        self.addToWorkoutController.delegate = self;
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    self.workoutTitle.text = self.detailWorkout.title;
    self.workoutImageView.file = self.detailWorkout[@"image"];
    PFUser *user = self.detailWorkout[@"author"];
    self.author.text = user[@"displayName"];
}

- (void) viewWillAppear:(BOOL)animated {
    [self getExercises];
}

- (void) getExercises {
    self.arrayOfExercises = [NSArray new];
    self.filteredExercises = [NSArray new];
    NSArray *allExercises = [[ExerciseSharedManager sharedManager] allExercises];
    for (NSString *currentID in self.detailWorkout.exercises) {
        NSPredicate *idPredicate = [NSPredicate predicateWithBlock:^BOOL(Exercise *evaluatedObject, NSDictionary *bindings) {
            return ([evaluatedObject.exerciseID isEqualToString:currentID]);
        }];
        self.arrayOfExercises = [self.arrayOfExercises arrayByAddingObjectsFromArray:[allExercises filteredArrayUsingPredicate:idPredicate]];
    }
    self.filteredExercises = self.arrayOfExercises;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredExercises.count;
}

- (void) didAddToWorkout {
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExerciseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExerciseCell"];
    Exercise *ex = self.filteredExercises[indexPath.row];
    cell.tintColor = [UIColor greenColor];
    cell.name.text = [ex.name capitalizedString];
    cell.name.animationCurve = UIViewAnimationCurveEaseIn;
    cell.name.fadeLength = 10.0;
    cell.name.scrollDuration = 3.0;
    cell.bodyPart.text = [ex.bodyPart capitalizedString];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"gifSegueFromWorkout"]) {
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:sender];
        Exercise *dataToPass = self.filteredExercises[myIndexPath.row];
        GifViewController *gVC = [segue destinationViewController];
        gVC.detailExercise = dataToPass;
    }
}

@end

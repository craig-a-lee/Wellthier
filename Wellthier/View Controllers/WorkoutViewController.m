//
//  WorkoutViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/14/22.
//

#import <Parse/Parse.h>
#import "WorkoutViewController.h"
#import "Exercise.h"
#import "ExerciseDetailViewController.h"
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

- (id)init {
    self = [super init];
    if (self) {
        self.arrayOfExercises = [NSArray new];
        self.filteredExercises = [NSArray new];
        self.addToWorkoutController = [AddToWorkoutViewController new];
        self.addToWorkoutController.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    self.workoutTitleLabel.text = self.detailWorkout.title;
    self.workoutImageView.file = self.detailWorkout[@"image"];
    PFUser *user = self.detailWorkout[@"author"];
    self.authorLabel.text = user[@"displayName"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getExercises];
}

- (void)getExercises {
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
    cell.nameLabel.text = [ex.name capitalizedString];
    cell.nameLabel.animationCurve = UIViewAnimationCurveEaseIn;
    cell.nameLabel.fadeLength = 10.0;
    cell.nameLabel.scrollDuration = 3.0;
    cell.bodyPartLabel.text = [ex.bodyPart capitalizedString];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"gifSegueFromWorkout"]) {
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:sender];
        Exercise *dataToPass = self.filteredExercises[myIndexPath.row];
        ExerciseDetailViewController *gVC = [segue destinationViewController];
        gVC.detailExercise = dataToPass;
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchText = [searchText lowercaseString];
    if (searchText.length != 0) {
        NSPredicate *searchPredicate = [NSPredicate predicateWithBlock:^BOOL(Exercise *evaluatedObject, NSDictionary *bindings) {
            return ([evaluatedObject.name containsString:searchText] ||
                    [evaluatedObject.target containsString:searchText] ||
                    [evaluatedObject.equipment containsString:searchText] ||
                    [evaluatedObject.bodyPart containsString:searchText]);
        }];
        
        self.filteredExercises = [self.arrayOfExercises filteredArrayUsingPredicate:searchPredicate];
    }
    else {
        self.filteredExercises = self.arrayOfExercises;
    }
    [self.tableView reloadData];
}

@end

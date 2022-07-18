//
//  WorkoutViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/14/22.
//

#import "WorkoutViewController.h"
#import "Exercise.h"
#import "GifViewController.h"
#import "ExerciseCell.h"
#import "ExerciseAPIManager.h"
#import "Parse/Parse.h"
#import "ExerciseCommonManager.h"

@interface WorkoutViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation WorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    self.workoutTitle.text = self.detailWorkout.title;
    // Do any additional setup after loading the view.
    self.workoutImageView.file = self.detailWorkout[@"image"];
    PFUser *user = self.detailWorkout[@"author"];
    self.author.text = user[@"displayName"];
    [self getExercises];
}

- (void) getExercises {
    self.arrayOfExercises = [NSMutableArray new];
    self.filteredExercises = [NSMutableArray new];
    NSArray *allExercises = [[ExerciseCommonManager sharedManager] allExercises];
    for (NSString *currentID in self.detailWorkout.exercises) {
        NSPredicate *idPredicate = [NSPredicate predicateWithBlock:^BOOL(Exercise *evaluatedObject, NSDictionary *bindings) {
            return ([evaluatedObject.exerciseID isEqualToString:currentID]);
        }];
        self.arrayOfExercises = [self.arrayOfExercises arrayByAddingObjectsFromArray:[allExercises filteredArrayUsingPredicate:idPredicate]];
    }
    self.filteredExercises = self.arrayOfExercises;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.filteredExercises.count;
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"gifSegueFromWorkout"]) {
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:sender];
        Exercise *dataToPass = self.filteredExercises[myIndexPath.row];
        GifViewController *gVC = [segue destinationViewController];
        gVC.detailExercise = dataToPass;
    }
}

@end

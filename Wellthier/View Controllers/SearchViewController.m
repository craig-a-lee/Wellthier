//
//  SearchViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/7/22.
//

#import "SearchViewController.h"
#import "ExerciseAPIManager.h"
#import "ExerciseCell.h"
#import "Exercise.h"
#import "SearchCell.h"
#import "GifViewController.h"
#import "ExerciseSharedManager.h"


@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) BOOL buttonPressed;
@property (nonatomic, assign) BOOL searchBarPressed;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
    self.title = @"Search";
//    [self.navigationController.navigationBar setTitleTextAttributes:
//       @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self getAllExercises];
    [self getBodyParts];
    [self setButtonPressed:NO];
    [self setSearchBarPressed:NO];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.delegate = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.searchBar.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void) getAllExercises {
    self.arrayOfExercises = [[ExerciseSharedManager sharedManager] allExercises];
    self.filteredExercises = self.arrayOfExercises;
    [self.tableView reloadData];
}

- (void) getBodyParts {
    self.bodyParts = @[@"back", @"cardio", @"chest", @"lower arms", @"lower legs", @"neck", @"shoulders", @"upper arms", @"upper legs", @"waist"];
}

- (IBAction)buttonPressed:(id)sender {
    if (!self.searchBarPressed) {
        if ([self.selectedButtonString isEqualToString:[sender currentTitle]]) {
            self.selectedButtonString = @"";
            self.filteredExercises = self.arrayOfExercises;
            [self setButtonPressed:NO];
        } else {
            self.selectedButtonString = [sender currentTitle];
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Exercise *evaluatedObject, NSDictionary *bindings) {
                return ([evaluatedObject.bodyPart containsString:[self.selectedButtonString lowercaseString]]);
            }];
            
            self.filteredExercises = (NSMutableArray *) [self.arrayOfExercises filteredArrayUsingPredicate:predicate];
            
        }
        [self.collectionView reloadData];
        [self.tableView reloadData];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.bodyParts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCell" forIndexPath:indexPath];
    NSString *partName = self.bodyParts[indexPath.row];
    [cell.filterButton setTitle:[partName capitalizedString] forState:UIControlStateNormal];
    cell.contentView.layer.cornerRadius = 10.0;
    cell.contentView.layer.borderWidth = 1.0f;
    cell.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    if ([[partName capitalizedString] isEqualToString:self.selectedButtonString]) {
        cell.filterButton.backgroundColor = [UIColor greenColor];
        [cell.filterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        cell.filterButton.backgroundColor = [UIColor blackColor];
        [cell.filterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    cell.contentView.layer.masksToBounds = true;
    return cell;
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

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchText = [searchText lowercaseString];
    if (searchText.length != 0) {
        [self setSearchBarPressed:YES];
        NSPredicate *searchPredicate = [NSPredicate predicateWithBlock:^BOOL(Exercise *evaluatedObject, NSDictionary *bindings) {
            return ([evaluatedObject.name containsString:searchText] ||
                    [evaluatedObject.target containsString:searchText] ||
                    [evaluatedObject.equipment containsString:searchText] ||
                    [evaluatedObject.bodyPart containsString:searchText]);
        }];
        
        self.filteredExercises = [self.arrayOfExercises filteredArrayUsingPredicate:searchPredicate];
        
        if (self.selectedButtonString.length > 0) {
            NSPredicate *filterPredicate = [NSPredicate predicateWithBlock:^BOOL(Exercise *evaluatedObject, NSDictionary *bindings) {
                return ([evaluatedObject.bodyPart containsString:[self.selectedButtonString lowercaseString]]);
            }];
            self.filteredExercises = [self.filteredExercises filteredArrayUsingPredicate:filterPredicate];
        }
    }
    else {
        [self setSearchBarPressed:NO];
        if (self.selectedButtonString.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Exercise *evaluatedObject, NSDictionary *bindings) {
                return ([evaluatedObject.bodyPart containsString:[self.selectedButtonString lowercaseString]]);
            }];
            
            self.filteredExercises = [self.arrayOfExercises filteredArrayUsingPredicate:predicate];
        } else {
            self.filteredExercises = self.arrayOfExercises;
        }
    }

    [self.tableView reloadData];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"gifSegueFromSearch"]) {
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:sender];
        Exercise *dataToPass = self.filteredExercises[myIndexPath.row];
        GifViewController *gVC = [segue destinationViewController];
        gVC.detailExercise = dataToPass;
    }
}

@end

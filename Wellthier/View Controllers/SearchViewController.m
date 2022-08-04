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
#import "AnimatedGif.h"
#import "UIImageView+AnimatedGif.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) BOOL buttonPressed;
@property (nonatomic, assign) BOOL searchBarPressed;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) UIView *mySubview;
@property (nonatomic, weak) IBOutlet UIImageView *temporaryGifImageView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
      initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //seconds
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
    self.title = @"Search";
    self.temporaryGifImageView.hidden = YES;
    [self getAllExercises];
    [self getBodyParts];
    [self setButtonPressed:NO];
    [self setSearchBarPressed:NO];
    self.tableView.dataSource = self;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tableView.delegate = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.searchBar.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void) hideElements:(BOOL) shouldHide {
    self.tableView.hidden = shouldHide;
    self.temporaryGifImageView.hidden = !shouldHide;
    self.collectionView.hidden = shouldHide;
    self.searchBar.hidden = shouldHide;
    self.navigationController.navigationBarHidden = shouldHide;
    self.tabBarController.tabBar.hidden = shouldHide;
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
    if (indexPath == nil) {
    } else if (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == 2) {
        Exercise *ex = self.filteredExercises[indexPath.row];
        [self hideElements:YES];
        AnimatedGif *newGif = [AnimatedGif getAnimationForGifAtUrl:ex.gifUrl];
        [self.temporaryGifImageView setAnimatedGif:newGif startImmediately:YES];
    } else {
        [self hideElements:NO];
    }
}

- (void)getAllExercises {
    self.arrayOfExercises = [[ExerciseSharedManager sharedManager] allExercises];
    self.filteredExercises = self.arrayOfExercises;
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];
}

- (void)getBodyParts {
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
    cell.nameLabel.text = [ex.name capitalizedString];
    cell.nameLabel.animationCurve = UIViewAnimationCurveEaseIn;
    cell.nameLabel.fadeLength = 10.0;
    cell.nameLabel.scrollDuration = 3.0;
    cell.bodyPartLabel.text = [ex.bodyPart capitalizedString];
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
    if ([segue.identifier isEqualToString:@"gifSegueFromSearch"]) {
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:sender];
        Exercise *dataToPass = self.filteredExercises[myIndexPath.row];
        GifViewController *gVC = [segue destinationViewController];
        gVC.detailExercise = dataToPass;
    }
}

@end

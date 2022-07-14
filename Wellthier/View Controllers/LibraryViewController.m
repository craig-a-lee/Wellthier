//
//  LibraryViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import "LibraryViewController.h"
#import "Parse/Parse.h"
#import "Workout.h"
#import "WorkoutCell.h"

@interface LibraryViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation LibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.currentUser = PFUser.currentUser;
    self.profilePic.file = self.currentUser[@"profilePic"];
    [self.profilePic loadInBackground];
    [self getWorkouts];
}

-(void) getWorkouts {
    PFQuery *workoutQuery = [Workout query];
    [workoutQuery includeKey:@"author"];
    [workoutQuery whereKey:@"author" equalTo:PFUser.currentUser];
    [workoutQuery findObjectsInBackgroundWithBlock:^(NSArray<Workout *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.arrayOfWorkouts = (NSMutableArray *) posts;
            [self.collectionView reloadData];
        }
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayOfWorkouts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    WorkoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WorkoutCell" forIndexPath:indexPath];
    Workout *workout = self.arrayOfWorkouts[indexPath.row];
    cell.workoutImageView.file = workout[@"image"];
    [cell.workoutImageView loadInBackground];
    cell.workoutAuthorInfo.text = self.currentUser[@"displayName"];
    cell.workoutTitle.text = workout.title;
    return cell;
}

@end

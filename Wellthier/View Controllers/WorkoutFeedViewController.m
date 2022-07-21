//
//  FeedViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/19/22.
//

#import "WorkoutFeedViewController.h"
#import "HealthKitSharedManager.h"

@interface WorkoutFeedViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WorkoutFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[HealthKitSharedManager sharedManager] requestAuthorization];
    
}

@end

//
//  FeedViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/19/22.
//

#import "FeedViewController.h"
#import "HealthKitSharedManager.h"

@interface FeedViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[HealthKitSharedManager sharedManager] requestAuthorization];
}

@end

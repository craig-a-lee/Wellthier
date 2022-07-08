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
#import "GifViewController.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (strong, nonatomic) NSMutableArray *exercises;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self resetButtonColors];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self getAllExercises];
}

- (void) getAllExercises {
//    NSDictionary *headers = @{ @"X-RapidAPI-Key": @"59155f3b42msh4c970b09e3798d7p149cb3jsnd367e6d28891",
//                               @"X-RapidAPI-Host": @"exercisedb.p.rapidapi.com" };
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://exercisedb.p.rapidapi.com/exercises"]
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:10.0];
//    [request setHTTPMethod:@"GET"];
//    [request setAllHTTPHeaderFields:headers];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
//                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                                    if (error) {
//                                                        NSLog(@"%@", error);
//                                                    } else {
//                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
//                                                        //NSLog(@"%@", httpResponse);
//                                                        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                                                        NSLog(@"%@", dataDictionary[@"results"]);
////                                                        self.exercises = [Exercise exercisesWithDictionaries:dataDictionary[@"results"]];
////                                                        NSLog(@"%@", self.exercises);
//                                                    }
//                                                }];
//    [dataTask resume];
    ExerciseAPIManager *manager = [ExerciseAPIManager new];
    [manager fetchAllExercises:^(NSArray *exercises, NSError *error) {
        self.arrayOfExercises = (NSMutableArray *) exercises;
        self.filteredExercises = (NSMutableArray *) exercises;
        //NSLog(exercises[0]);
        
    }];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (self.searchBar.searchResultsButtonSelected) {
//        return self.filteredExercises.count;
//    }
    return 1300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.searchBar.searchResultsButtonSelected) {
//        ExerciseCel *cell = [tableView dequeueReusableCellWithIdentifier:@"ExerciseCell"];
//        Exercise *ex = self.arrayOfExercises[indexPath.row];
//        cell.textLabel.text = self.filteredExercises[indexPath.row].name;
//    }
        ExerciseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExerciseCell"];
        Exercise *ex = self.filteredExercises[indexPath.row];
        //cell.textLabel.text = self.filteredExercises[indexPath.row].name;
        cell.name.text = ex.name;
//
        return cell;
}

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//
//    if (searchText.length != 0) {
//
//        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Exercise *evaluatedObject, NSDictionary *bindings) {
//            return ([evaluatedObject.name containsString:searchText] ||
//                    [evaluatedObject.target containsString:searchText] ||
//                    [evaluatedObject.equipment containsString:searchText] ||
//                    [evaluatedObject.bodyPart containsString:searchText]);
//        }];
//        self.filteredExercises = [self.arrayOfExercises filteredArrayUsingPredicate:predicate];
//
//        NSLog(@"%@", self.filteredExercises);
//
//    }
//    else {
//        self.filteredExercises = self.arrayOfExercises;
//    }
//
//    [self.tableView reloadData];
//
//}

- (void) resetButtonColors {
    self.nameButton.backgroundColor = [UIColor blackColor];
    self.nameButton.selected = false;
    self.targetMuscleButton.backgroundColor = [UIColor blackColor];
    self.targetMuscleButton.selected = false;
    self.bodyPartButton.backgroundColor = [UIColor blackColor];
    self.bodyPartButton.selected = false;
    self.equipmentButton.backgroundColor = [UIColor blackColor];
    self.equipmentButton.selected = false;
}

- (IBAction)didTapName:(id)sender {
    [self resetButtonColors];
    self.nameButton.selected = true;
    self.nameButton.backgroundColor = [UIColor greenColor];
    self.nameButton.layer.backgroundColor = [UIColor greenColor].CGColor;
    self.nameButton.tintColor = [UIColor greenColor];
}
- (IBAction)didTapMuscle:(id)sender {
    [self resetButtonColors];
    self.targetMuscleButton.selected = true;
    self.targetMuscleButton.backgroundColor = [UIColor greenColor];
    self.targetMuscleButton.layer.backgroundColor = [UIColor greenColor].CGColor;
    self.targetMuscleButton.tintColor = [UIColor greenColor];
}
- (IBAction)didTapBodyPart:(id)sender {
    [self resetButtonColors];
    self.bodyPartButton.selected = true;
    self.bodyPartButton.backgroundColor = [UIColor greenColor];
    self.bodyPartButton.layer.backgroundColor = [UIColor greenColor].CGColor;
    self.bodyPartButton.tintColor = [UIColor greenColor];
}
- (IBAction)didTapEquipment:(id)sender {
    [self resetButtonColors];
    self.equipmentButton.selected = true;
    self.equipmentButton.backgroundColor = [UIColor greenColor];
    self.equipmentButton.layer.backgroundColor = [UIColor greenColor].CGColor;
    self.equipmentButton.tintColor = [UIColor greenColor];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"gifSegue1"]) {
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:sender];
        Exercise *dataToPass = self.arrayOfExercises[myIndexPath.row];
        GifViewController *gVC = [segue destinationViewController];
        gVC.detailExercise = dataToPass;
        
    }
}


@end

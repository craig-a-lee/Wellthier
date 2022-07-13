//
//  SearchViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/7/22.
//

#import "ViewController.h"
#import "Exercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : ViewController

@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@property (weak, nonatomic) IBOutlet UIButton *targetMuscleButton;
@property (weak, nonatomic) IBOutlet UIButton *bodyPartButton;
@property (weak, nonatomic) IBOutlet UIButton *equipmentButton;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray <Exercise *> *arrayOfExercises;
@property (nonatomic, strong) NSMutableArray <Exercise *> *filteredExercises;
@property (nonatomic, strong) NSArray <NSString *> *bodyParts;
@property (nonatomic, strong) NSString *selectedButtonString;


@end

NS_ASSUME_NONNULL_END

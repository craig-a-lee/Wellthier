//
//  SearchViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/7/22.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : ViewController
@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@property (weak, nonatomic) IBOutlet UIButton *targetMuscleButton;
@property (weak, nonatomic) IBOutlet UIButton *bodyPartButton;
@property (weak, nonatomic) IBOutlet UIButton *equipmentButton;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *arrayOfExercises;
@property (nonatomic, strong) NSMutableArray *filteredExercises;
@end

NS_ASSUME_NONNULL_END

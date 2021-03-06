//
//  SearchViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/7/22.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UIViewController

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray <Exercise *> *arrayOfExercises;
@property (nonatomic, strong) NSArray <Exercise *> *filteredExercises;
@property (nonatomic, strong) NSArray <NSString *> *bodyParts;
@property (nonatomic, strong) NSString *selectedButtonString;

@end

NS_ASSUME_NONNULL_END

//
//  GifViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"
#import "MarqueeLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExerciseDetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *gifImageView;
@property (nonatomic, weak) IBOutlet UILabel *equipmentLabel;
@property (nonatomic, weak) IBOutlet UILabel *targetMuscleLabel;
@property (nonatomic, weak) IBOutlet UILabel *bodyPartLabel;
@property (nonatomic, weak) IBOutlet MarqueeLabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIButton *likeButtonLabel;
@property (nonatomic, weak) Exercise *detailExercise;

@end

NS_ASSUME_NONNULL_END

//
//  GifViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import "ViewController.h"
#import "Exercise.h"
#import "MarqueeLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GifViewController : ViewController

@property (nonatomic, weak) IBOutlet UIImageView *gifImageView;
@property (nonatomic, weak) Exercise *detailExercise;
@property (nonatomic, weak) IBOutlet MarqueeLabel *name;
@property (nonatomic, weak) IBOutlet UILabel *equipment;
@property (nonatomic, weak) IBOutlet UILabel *targetMuscle;
@property (nonatomic, weak) IBOutlet UILabel *bodyPart;
@property (nonatomic, weak) IBOutlet UIButton *likeButton;

@end

NS_ASSUME_NONNULL_END

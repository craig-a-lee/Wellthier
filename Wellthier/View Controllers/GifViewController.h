//
//  GifViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/8/22.
//

#import "ViewController.h"
#import "Exercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface GifViewController : ViewController

@property (weak, nonatomic) IBOutlet UIImageView *gif;
@property(nonatomic, weak) Exercise *detailExercise;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *equipment;
@property (weak, nonatomic) IBOutlet UILabel *targetMuscle;
@property (weak, nonatomic) IBOutlet UILabel *bodyPart;

@end

NS_ASSUME_NONNULL_END

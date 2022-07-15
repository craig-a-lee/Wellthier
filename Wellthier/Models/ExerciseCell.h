//
//  ExerciseCell.h
//  Wellthier
//
//  Created by Craig Lee on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExerciseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet MarqueeLabel *name;
@property (weak, nonatomic) IBOutlet UILabel *bodyPart;

@end

NS_ASSUME_NONNULL_END

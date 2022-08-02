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

@property (nonatomic, weak) IBOutlet MarqueeLabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *bodyPartLabel;

@end

NS_ASSUME_NONNULL_END

//
//  HealthKitWorkoutTableViewCell.h
//  Wellthier
//
//  Created by Craig Lee on 7/25/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HealthKitWorkoutTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *workoutType;
@property (nonatomic, weak) IBOutlet UILabel *startDate;
@property (nonatomic, weak) IBOutlet UILabel *endDate;
@property (nonatomic, weak) IBOutlet UILabel *duration;
@property (nonatomic, weak) IBOutlet UILabel *energyBurned;

@end

NS_ASSUME_NONNULL_END

//
//  GifViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/8/22.
//

#import "GifViewController.h"

@interface GifViewController ()

@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setParams:self.detailExercise];
}

- (void) setParams:(Exercise *)exercise {
    self.name.text = exercise.name;
    self.equipment.text = exercise.equipment;
    self.bodyPart.text = exercise.bodyPart;
    self.targetMuscle.text = exercise.target;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

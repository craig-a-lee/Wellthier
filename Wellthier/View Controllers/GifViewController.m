//
//  GifViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//


#import "AFNetworking.h"
#import "GifViewController.h"
#import "AnimatedGif.h"
#import "UIImageView+AnimatedGif.h"

@interface GifViewController ()

@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setParams:self.detailExercise];
}

- (void) setParams:(Exercise *)exercise {
    AnimatedGif *newGif = [AnimatedGif getAnimationForGifAtUrl:exercise.gifUrl];
    [self.gifImageView setAnimatedGif:newGif startImmediately:YES];
    NSLog(@"here: %@", exercise.gifUrl);
    self.name.text = [exercise.name capitalizedString];
    self.name.animationCurve = UIViewAnimationCurveEaseIn;
    self.name.fadeLength = 10.0;
    self.name.scrollDuration = 3.0;
    self.equipment.text = [exercise.equipment capitalizedString];
    self.bodyPart.text = [exercise.bodyPart capitalizedString];
    self.targetMuscle.text = [exercise.target capitalizedString];
    [self.view addSubview:self.gifImageView];
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

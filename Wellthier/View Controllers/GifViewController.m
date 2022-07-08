//
//  GifViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/8/22.
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
    [self.gif setAnimatedGif:newGif startImmediately:YES];
    NSLog(@"here: %@", exercise.gifUrl);
    self.name.text = exercise.name;
    self.equipment.text = exercise.equipment;
    self.bodyPart.text = exercise.bodyPart;
    self.targetMuscle.text = exercise.target;
//    [newGif setLoadingProgressBlock:^(AnimatedGif *obj, CGFloat progress) {
//        progressView.progress = progress;
//    }];
//    [newGif setWillShowFrameBlock:^(AnimatedGif *obj, UIImage *img) {
//        progressView.hidden = YES;
//        //... Do stuff
//    }];
    
    [self.view addSubview:self.gif];
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

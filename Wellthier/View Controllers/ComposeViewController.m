//
//  ComposeViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/19/22.
//

#import "ComposeViewController.h"
#import "Parse/Parse.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.textView layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[self.textView layer] setBorderWidth:1.0];
    [self setParams];
}

- (void) setParams {
    self.currentUser = PFUser.currentUser;
    self.profilePic.file = self.currentUser[@"profilePic"];
    [self.profilePic loadInBackground];
}
- (IBAction)didTapUploadPic:(id)sender {
}

- (IBAction)didTapFetchData:(id)sender {
}

- (IBAction)didTapPost:(id)sender {
}

- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


@end

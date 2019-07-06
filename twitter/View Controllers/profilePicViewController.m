//
//  profilePicViewController.m
//  twitter
//
//  Created by rhaypapenfuzz on 7/5/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "profilePicViewController.h"
#import "UIImageview+AFNetworking.h"

@interface profilePicViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
- (IBAction)cancelButtonAction:(id)sender;

@end

@implementation profilePicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

  //  Tweet *tweet  = self.tweets[indexPath.row];
    NSLog(@"%@", self.tweet);
    
    NSString *profileURL = self.tweet.user.imageURL;
    NSURL *URL = [NSURL URLWithString:profileURL];
    [self.profilePicture setImageWithURL:URL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */
- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end

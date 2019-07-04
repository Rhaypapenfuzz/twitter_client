//
//  ComposeViewController.m
//  twitter
//
//  Created by rhaypapenfuzz on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *ComposeTextView;

- (IBAction)CancelButtonAction:(id)sender;
- (IBAction)TweetButtonAction:(id)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)CancelButtonAction:(id)sender {
       [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)TweetButtonAction:(id)sender {
    NSString *ComposedText = self.ComposeTextView.text;

    [[APIManager shared] postStatusWithText:ComposedText completion:^(Tweet *tweet, NSError *error) {
          if(error){
             NSLog(@"Error composing Tweet: %@", error.localizedDescription);
          }
          else{
             [self.delegate didTweet:tweet];
             [self dismissViewControllerAnimated:YES completion:nil];
             NSLog(@"Compose Tweet Success!");
          }
    }];
}


@end

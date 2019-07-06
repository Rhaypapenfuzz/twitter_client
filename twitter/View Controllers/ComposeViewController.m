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
    //self.textView.delegate = self;
    self.ComposeTextView.delegate = self;
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // TODO: Check the proposed new text character count
    // Allow or disallow the new text
    // Set the max character limit
    int characterLimit = 140;
    
    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.ComposeTextView.text stringByReplacingCharactersInRange:range withString:text];
    self.characterCount.text = [NSString stringWithFormat:@"%lu characters typed", (unsigned long)newText.length];
    
    // TODO: Update Character Count Label
    
    // The new text should be allowed? True/False
    return newText.length < characterLimit;
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

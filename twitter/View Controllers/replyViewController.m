//
//  replyViewController.m
//  twitter
//
//  Created by rhaypapenfuzz on 7/5/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "replyViewController.h"
#import "APIManager.h"


@interface replyViewController ()

@property (weak, nonatomic) IBOutlet UITextView *ReplyTextView;
//@property (nonatomic, strong) NSString *tweetID;
- (IBAction)replyButtonAction:(id)sender;

@end
@implementation replyViewController
- (IBAction)cancelButtonAction:(id)sender {
     [self dismissViewControllerAnimated:true completion:nil];
}

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

//replies should be prefixed with the username and the reply_id should be set when posting the tweet
- (IBAction)replyButtonAction:(id)sender {
    
    NSString *repliedText = self.ReplyTextView.text; // text + @screenname
    NSString *tweetID = self.replyToTweet.idStr;
    [[APIManager shared] replyWithText:repliedText andTweetID:(NSString *)tweetID completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error replying to Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didReply:tweet];
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"Reply Tweet Success!");
        }
    }];
}
@end

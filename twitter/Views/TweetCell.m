//
//  TweetCell.m
//  twitter
//
//  Created by rhaypapenfuzz on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)didTapFavorite:(id)sender {
    if(self.tweet.favorited){
        self.favoriteButton.selected = NO;
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else{
        self.favoriteButton.selected = YES;
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
        
    }
    [self refreshData];
}
-(void) refreshData{
    
  
    //self.tweet = _tweet;
    self.authorLabel.text = self.tweet.user.name; //user name
    self.AuthorNicknameLabel.text = self.tweet.user.screenName; // user nickname
    self.dateLabel.text = self.tweet.createdAtString;
    
    NSString *profileURL = self.tweet.user.imageURL;
    NSURL *URL = [NSURL URLWithString:profileURL];
    
    self.profilePicture.image = nil;
    [self.profilePicture setImageWithURL:URL];
    self.tweetTextLabel.text = [NSString stringWithFormat:@"%@", self.tweet.text]; //tweet text
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount]; //retweet count
    self.likesCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount]; // likes count
   
}

    
@end

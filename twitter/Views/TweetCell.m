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
    
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profilePicture addGestureRecognizer:profileTapGestureRecognizer];
    [self.profilePicture setUserInteractionEnabled:YES];
    
    // Initialization code
    [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
    
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    [self.delegate tweetCell:self didTap:self.tweet.user];
}

- (IBAction)tapFavoriteAction:(id)sender {
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

- (IBAction)tapRetweetAction:(id)sender {
    if(self.tweet.retweeted){
        self.retweetButton.selected = NO;
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    else{
        self.retweetButton.selected = YES;
        self.tweet.retweeted= YES;
        self.tweet.retweetCount += 1;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
        
    }
    [self refreshData];
    
}

-(void) refreshData{
    

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
- (IBAction)tapReplyAction:(id)sender {
    NSString *tweedID = self.tweet.idStr;
    
}
@end

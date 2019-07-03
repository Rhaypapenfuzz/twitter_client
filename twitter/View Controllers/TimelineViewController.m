//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "UIImageview+AFNetworking.h"

@interface TimelineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tweetView;
@property (nonatomic, strong) NSArray *tweets; //Add a property for the array of tweets and set it when the network call succeeds.
//Similar to the Flixster app, implement the UITableViewDataSource methods.
//@property(nonatomic,strong) N
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     //UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    
    self.tweetView.dataSource = self; //view controller becomes its own dataSource
    self.tweetView.delegate = self;  //view controller becomes its own delegate
    self.tweetView.rowHeight = 180;
    // self.Tweet =[[NSMutableArray alloc] init];
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {//make an API request
        if (tweets) {
            //stored the tweet data and display it
            self.tweets = tweets;
            [self.tweetView reloadData]; //reload tableView
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text; //dictionary[@"text"];
                NSLog(@"%@", text);
            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
//- (void)beginRefresh:(UIRefreshControl *)refreshControl {
//
//    // Create NSURL and NSURLRequest
//
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
//                delegate:nil
//                delegateQueue:[NSOperationQueue mainQueue]];
//    session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
//            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//
//            // ... Use the new data to update the data source ...
//
//            // Reload the tableView now that there is new data
//            [self.tableView reloadData];
//
//            // Tell the refreshControl to stop spinning
//            [refreshControl endRefreshing];
//
//        }];
//
//    [task resume];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- ( UITableViewCell *)tableView:( UITableView *)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath {
    TweetCell *cell = [self.tweetView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet  = self.tweets[indexPath.row];
    
    cell.authorLabel.text = tweet.user.name; //user name
    cell.AuthorNicknameLabel.text = tweet.user.screenName; // user nickname

    NSString *profileURL = tweet.user.imageURL;
    NSURL *URL = [NSURL URLWithString:profileURL];
    [cell.profilePicture setImageWithURL:URL];

    cell.tweetTextLabel.text = [NSString stringWithFormat:@"%@", tweet.text]; //tweet text
    cell.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount]; //retweet count
    cell.likesCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount]; // likes count
    cell.dateLabel.text = tweet.createdAtString;
    // cell.commentCountLabel.text = tweet.    commentCount;
    return cell;
    }

- (NSInteger)tableView:( nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}




@end

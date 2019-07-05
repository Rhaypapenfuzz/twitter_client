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
#import "ComposeViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tweetView;
@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) UIRefreshControl *refreshcontrol;
- (IBAction)logOutButton:(id)sender;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tweetView insertSubview:refreshControl atIndex:0];

    //[refreshControl beginRefreshing];
    self.tweetView.dataSource = self; //view controller becomes its own dataSource
    self.tweetView.delegate = self;  //view controller becomes its own delegate
    self.tweetView.rowHeight = 180;
 
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {//make an API request
        if (tweets) {
            //stored the tweet data and display it
            self.tweets = (NSMutableArray *) tweets;
            [self.tweetView reloadData]; //reload tableView
            NSLog(@"😎😎😎 Successfully loaded home timeline");
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)makeAPIRequest {

    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {//make an API request
        if (tweets) {
            //stored the tweet data and display it
            self.tweets = (NSMutableArray *)tweets;
            [self.tweetView reloadData]; //reload tableView
            NSLog(@"😎😎😎 Successfully loaded home timeline");
//           for (Tweet *tweet in tweets) {
//                NSString *text = tweet.text; //dictionary[@"text"];
//                NSLog(@"%@", text);
//            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tweetView reloadData]; // Updates the tableView with the new data
        
        [self.refreshcontrol endRefreshing]; // Tell the refreshControl to stop spinning
    }];
}

// Makes a network request to get updated data
- (void)beginRefresh:(UIRefreshControl *)refreshControl {

    // Create NSURL and NSURLRequest
        [self makeAPIRequest] ;
    
}
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

    cell.tweet = tweet;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}
- (void)didTweet:(Tweet *)tweet{
    [self.tweets insertObject:tweet atIndex:0];
    [self.tweetView reloadData];

}

- (IBAction)logOutButton:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}
@end

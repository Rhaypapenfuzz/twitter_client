//
//  replyViewController.h
//  twitter
//
//  Created by rhaypapenfuzz on 7/5/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ReplyViewControllerDelegate
- (void)didReply:(Tweet *)tweet;
@end

@interface replyViewController : UIViewController
@property (nonatomic, weak) id<ReplyViewControllerDelegate> delegate;
@property (nonatomic, strong) Tweet *replyToTweet;
@end

NS_ASSUME_NONNULL_END

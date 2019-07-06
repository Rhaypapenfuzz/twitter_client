//
//  profilePicViewController.h
//  twitter
//
//  Created by rhaypapenfuzz on 7/5/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface profilePicViewController : UIViewController
@property (nonatomic, strong) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END

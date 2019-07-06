//
//  ComposeViewController.h
//  twitter
//
//  Created by rhaypapenfuzz on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ComposeViewControllerDelegate
- (void)didTweet:(Tweet *)tweet;
@end
@interface ComposeViewController : UIViewController
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *characterCount;
@end

NS_ASSUME_NONNULL_END

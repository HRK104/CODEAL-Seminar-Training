//
//  WebViewController.h
//  TwitterClient01
//
//  Created by 鈴木みゆき on 2019/05/17.
//  Copyright © 2019 鈴木みゆき. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController <UIWebViewDelegate>
@property NSURL *openURL;
@end

NS_ASSUME_NONNULL_END

//
//  DetailViewController.h
//  TwitterClient01
//
//  Created by 鈴木みゆき on 2019/05/17.
//  Copyright © 2019 鈴木みゆき. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property NSString *name;
@property NSString *text;
@property UIImage *image;

@property NSString *identifier;
@property NSString *idStr;
@end

NS_ASSUME_NONNULL_END

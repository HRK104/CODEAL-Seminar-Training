//
//  TimeLineCell.h
//  TwitterClient01
//
//  Created by 鈴木みゆき on 2019/05/16.
//  Copyright © 2019 鈴木みゆき. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeLineCell : UITableViewCell

@property UILabel *tweetTextLabel;
@property UILabel *nameLabel;
@property UIImageView *profileImageView;
@property UIImage *image;
@property int tweetTextLabelheight;

@end

NS_ASSUME_NONNULL_END

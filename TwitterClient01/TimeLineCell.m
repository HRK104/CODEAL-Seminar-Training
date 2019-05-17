//
//  TimeLineCell.m
//  TwitterClient01
//
//  Created by 鈴木みゆき on 2019/05/16.
//  Copyright © 2019 鈴木みゆき. All rights reserved.
//

#import "TimeLineCell.h"

@implementation TimeLineCell

-(id) initWithStyle:(UITableViewCellStyle) style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        self.tweetTextLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.tweetTextLabel.font = [UIFont systemFontOfSize:14.0f];
        self.tweetTextLabel.textColor = [UIColor blackColor];
        self.tweetTextLabel.numberOfLines = 0;
        //self.tweetTextLabel.highlightedTextColor = [UIColor blueColor];
        [self.contentView addSubview:self.tweetTextLabel];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.nameLabel.font = [UIFont systemFontOfSize:12.0f];
        self.nameLabel.textColor = [UIColor blackColor];
        //nameLabel = [UIColor blueColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.profileImageView = self.image;
        [self.contentView addSubview:self.profileImageView];
    }
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    self.profileImageView.frame = CGRectMake(5, 5, 48, 48);
    self.nameLabel.frame = CGRectMake(58, 5, 257, self.tweetTextLabelheight);
    self.nameLabel.frame = CGRectMake(58, self.tweetTextLabelheight + 15, 257, 12);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

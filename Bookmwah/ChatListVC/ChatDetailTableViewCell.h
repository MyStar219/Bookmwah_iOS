//
//  MenuTableViewCell.h
//  Bookmwah
//
//  Created by admin on 24/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgLeft;
@property (weak, nonatomic) IBOutlet UIImageView *imgRight;

@property (weak, nonatomic) IBOutlet UILabel * lblLeftMsg;

@property (weak, nonatomic) IBOutlet UILabel * lblRightMsg;

@property (weak, nonatomic) IBOutlet UIView *chatView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatViewWidth;

@end

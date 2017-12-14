//
//  MenuTableViewCell.m
//  Bookmwah
//
//  Created by admin on 24/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _lblWallet.layer.cornerRadius = _lblWallet.layer.frame.size.width/2;
    _lblWallet.clipsToBounds = YES;
    
    _lblNotification.layer.cornerRadius  = _lblNotification.layer.frame.size.width/2;
    _lblNotification.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
    [super setSelected:selected animated:animated];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];

    // Configure the view for the selected state
}

@end

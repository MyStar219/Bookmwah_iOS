//
//  NotificationsTVCell.m
//  Bookmwah
//
//  Created by admin on 04/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "NotificationsTVCell.h"

@implementation NotificationsTVCell

@synthesize lbl_Name,lbl_BookingTime,lbl_ServiceType,img;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //Round Image
    
    img.layer.cornerRadius = img.frame.size.height/2;
    img.layer.cornerRadius = img.frame.size.width/2;
    img.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  BookingForYouCell.h
//  Bookmwah
//
//  Created by admin on 10/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingForYouCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image_View;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Servicetype;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Bookingtime;
@property (weak, nonatomic) IBOutlet UIButton *btn_Accept;
@property (weak, nonatomic) IBOutlet UIButton *btn_reject;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancle;

@property (weak, nonatomic) IBOutlet UIButton *btn_chat;

@end

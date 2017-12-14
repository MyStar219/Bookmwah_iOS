//
//  NotificationsTVCell.h
//  Bookmwah
//
//  Created by admin on 04/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationsTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_Name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_ServiceType;
@property (weak, nonatomic) IBOutlet UILabel *lbl_BookingTime;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@end

//
//  bookingDetailVC.h
//  Bookmwah
//
//  Created by admin on 16/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingDetailVC : UIViewController

@property NSMutableArray *arrayDetail;
@property NSIndexPath *index;
@property (weak, nonatomic) IBOutlet UIImageView *image_Profile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_gender;
@property (weak, nonatomic) IBOutlet UILabel *lbl_serviceType;
@property (weak, nonatomic) IBOutlet UILabel *lbl_BookingTime;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Email;
@property (weak, nonatomic) IBOutlet UILabel *lbl_MobileNumber;
@property (weak, nonatomic) IBOutlet UIButton *btn_Accept;
@property (weak, nonatomic) IBOutlet UIButton *btn_Reject;

@end

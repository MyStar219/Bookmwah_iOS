//
//  CustomerBookingVC.h
//  Bookmwah
//
//  Created by admin on 24/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface CustomerBookingVC : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *arrayData ;
    NSString *date,*time;
    MBProgressHUD *HUD;
    NSUserDefaults *defaults;
    IBOutlet UIButton *btnRadio_Sercice;
    IBOutlet UIButton *btnRadio_Home;
    UITapGestureRecognizer *tap;
}
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblServiceType;
@property (weak, nonatomic) IBOutlet UILabel *lblCharges;
@property (weak, nonatomic) IBOutlet UIView *viewDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIButton *timepicker;
@property (weak, nonatomic) IBOutlet UIButton *datepicker;
//@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UILabel *datePickerTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtAddress;


@property (weak, nonatomic) IBOutlet UIButton *btnDone;
- (IBAction)Done:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
- (IBAction)Cancel:(id)sender;

- (IBAction)btnDatePicker:(id)sender;
- (IBAction)btnTimePicker:(id)sender;

- (IBAction)btnBack:(id)sender;

- (IBAction)btnPayment:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *shView;

@end

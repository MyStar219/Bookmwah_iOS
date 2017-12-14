//
//  PaymentVC.h
//  Bookmwah
//
//  Created by admin on 03/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "PaymentCell.h"
#import "MBProgressHUD.h"


@interface PaymentVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource, UIPickerViewDelegate>{
    NSMutableArray *arrayWalletBal,*arrayRegisteredCard,*arrayAddNewCard;
    MBProgressHUD *HUD;
    NSUserDefaults *defaults;
    NSMutableDictionary *cardDetails;
    BOOL isCreateNewCard;
}

@property NSMutableDictionary *booking_details;

@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (weak, nonatomic) IBOutlet UITextField *txt_card_holder_name;

@property (weak, nonatomic) IBOutlet UITextField *txt_card_number;
@property (weak, nonatomic) IBOutlet UIButton *btnExpiry;
@property (weak, nonatomic) IBOutlet UITextField *txt_expiry_date;

@property (weak, nonatomic) IBOutlet UITextField *txt_cavv;

@property (weak, nonatomic) IBOutlet UIView *background_view;
- (IBAction)confirm_booking:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view_picker;
@property (weak, nonatomic) IBOutlet UIPickerView *datePicker;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)back:(id)sender;

@end

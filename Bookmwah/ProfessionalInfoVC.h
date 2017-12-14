//
//  ProfessionalInfoVC.h
//  Bookmwah
//
//  Created by admin on 19/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MKAnnotation.h"
#import "Constant.h"
@interface ProfessionalInfoVC : UIViewController<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>{
    NSMutableArray *arrayData;
    NSString *time;

    MBProgressHUD *HUD;
    NSUserDefaults *defaults;
}

@property (weak, nonatomic) IBOutlet UIScrollView *sv;
@property (weak, nonatomic) IBOutlet UIScrollView *svBtn;

@property (weak, nonatomic) IBOutlet UITextField *txtName;

@property (weak, nonatomic) IBOutlet UITextField *txtBusinessName;
@property (weak, nonatomic) IBOutlet UITextField *txtRole;
@property (weak, nonatomic) IBOutlet UITextField *txtBusinessAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtZipcode;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNo;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtWebsite;
@property (weak, nonatomic) IBOutlet UITextField *txtCacellationPolicy;
@property (weak, nonatomic) IBOutlet UITextView *txtViewOtherNotes;
@property (weak, nonatomic) IBOutlet UITextView *txtDirection;
- (IBAction)houseCall:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_houseCall;

@property (weak, nonatomic) IBOutlet UIView *vw_Search;
@property (weak, nonatomic) IBOutlet UITextField *txt_Search;
@property (weak, nonatomic) IBOutlet UITableView *tbl_Search;
- (IBAction)on_cancel_search:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *shView;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)Done:(id)sender;
- (IBAction)CancelPicker:(id)sender;
- (IBAction)From:(id)sender;
- (IBAction)To:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;
- (IBAction)Recommendation:(id)sender;
- (IBAction)Info:(id)sender;
- (IBAction)Portfolio:(id)sender;
- (IBAction)BankDetails:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnRecommendation;
@property (weak, nonatomic) IBOutlet UIButton *btnPortfolio;
@property (weak, nonatomic) IBOutlet UIButton *btnBankDetails;
@property (weak, nonatomic) IBOutlet UIButton *btnServices;
- (IBAction)Services:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnfrom;
@property (weak, nonatomic) IBOutlet UIButton *btnto;


@property (weak, nonatomic) IBOutlet UILabel *lbl_DateTimeHeader;



- (IBAction)Save:(id)sender;


@end

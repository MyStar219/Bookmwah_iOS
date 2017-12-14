//
//  AccountInfo.h
//  Bookmwah
//
//  Created by admin on 21/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

//Mobile Number Constant

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface AccountInfo : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{
    NSMutableArray *stateArray;
    UIActionSheet *actionSheet2;
    MBProgressHUD *HUD;
    NSMutableDictionary *user_dic;
    int gender;
    UIImage *image;
    NSString *password;
    BOOL isChangePassword;

}
@property (weak, nonatomic) IBOutlet UIImageView *img;
- (IBAction)Camera:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *txtName;

@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtGender;
@property (weak, nonatomic) IBOutlet UITextField *txtMobNo;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;

@property (weak, nonatomic) IBOutlet UITextField *txtOldPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtRePassword;
- (IBAction)saveAction:(id)sender;

- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *house_call_switch;

//State View
@property (weak, nonatomic) IBOutlet UIView *tvView;
- (IBAction)btnHide:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *stateTV;
- (IBAction)showState:(id)sender;
- (IBAction)showGenderView:(id)sender;

//Gender View
@property (weak, nonatomic) IBOutlet UIView *genderView;
- (IBAction)closeGenderView:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFemale;

@property (weak, nonatomic) IBOutlet UIButton *btnMale;

@end

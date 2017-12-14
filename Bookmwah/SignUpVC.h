//
//  SignUpVC.h
//  Bookmwah
//
//  Created by admin on 16/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface SignUpVC : UIViewController
{
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtRePassword;
@property (weak, nonatomic) IBOutlet UITextField *txtPhoneNumber;

- (IBAction)SignUp:(id)sender;
- (IBAction)SignIn:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end

//
//  SignInVC.h
//  Bookmwah
//
//  Created by Developer on 13/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpVC.h"
#import "Constant.h"

@interface SignInVC : UIViewController{
    
    MBProgressHUD *HUD;
    NSMutableDictionary *fbDictionary;
}
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)signIn:(id)sender;
- (IBAction)signUpWithEmail:(id)sender;

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *SignIn;

- (IBAction)hideKeyboard:(id)sender;



@end

//
//  OTPVerificationVC.h
//  Bookmwah
//
//  Created by admin on 18/11/17.
//  Copyright © 2017 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface OTPVerificationVC : UIViewController {
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UITextField *txtForOtp;
- (IBAction)ResendOTP:(id)sender;
- (IBAction)ChangeNumber:(id)sender;
- (IBAction)Submit:(id)sender;

- (IBAction)hideKeyboard:(id)sender;

@end

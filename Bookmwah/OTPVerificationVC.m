//
//  OTPVerificationVC.m
//  Bookmwah
//
//  Created by admin on 18/11/17.
//  Copyright © 2017 Mahesh Kumar Dhakad. All rights reserved.
//

#import "OTPVerificationVC.h"

@interface OTPVerificationVC ()

@end

@implementation OTPVerificationVC
@synthesize txtForOtp;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // load MBProgressHUD
    [self load_MBProgressHUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MBProgressHUD Load
#pragma mark -

-(void)load_MBProgressHUD
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading...";
    //HUD.detailsLabelText = @"Pdf..";
    HUD.square = YES;
    [self.view addSubview:HUD];
    
}

#pragma mark - Validation
#pragma mark -
-(BOOL)validation
{
    if (txtForOtp.text.length==0) {
        _AlertView_WithOut_Delegate(@"Warning!", @"Please enter OTP", @"OK", nil);
        return NO;
    }
    else if (txtForOtp.text.length < 4) {
        _AlertView_WithOut_Delegate(@"Warning!", @"Please enter valid OTP", @"OK", nil);
        return NO;
    }
    return YES;
}

#pragma mark - Change Text Placeholder Color
#pragma mark -

- (IBAction)back:(id)sender {
   
}

- (IBAction)ResendOTP:(id)sender {
    _AlertView_WithOut_Delegate(@"Warning!", @"Under Development", @"OK", nil);
    return;

}

- (IBAction)ChangeNumber:(id)sender {
    _AlertView_WithOut_Delegate(@"Warning!", @"Under Development", @"OK", nil);
    return;
}

- (IBAction)Submit:(id)sender {
    if([self validation])
    {
        //[self call_OTPVerificationAPI];
        
        [NSUD setValue:@"1" forKey:@"IS_LOGIN"];
        [NSUD synchronize];
        
        NSString *strUserType = [NSUD valueForKey:@"user_type"];
        
        if ([strUserType isEqual:@"1"]) {
            
            TabBarVC *TabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
            [self presentViewController:TabBarVC animated:NO completion:nil];
            
        }else{
            
            ServiceProviderTabBarVC *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceProviderTabBarVC"];
            
            [self presentViewController:tabBarVC animated:NO completion:nil];
            
            [self.tabBarController setSelectedIndex:2];
            [[ServiceProviderTabBarVC new] change_TabBar:2];
        }
        
//        TabBarVC *TabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
//        [self presentViewController:TabBarVC animated:NO completion:nil];
    }
}

- (IBAction)hideKeyboard:(id)sender {
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 4;
}

#pragma mark - call_SignUpWithEmailAPI
#pragma mark -

-(void)call_OTPVerificationAPI{
    
    [HUD show:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[NSUD objectForKey:@"user_id"] forKey:@"user_id"];
    [dict setValue:txtForOtp.text forKey:@"user_otp"];
    
    [WebService call_API:dict andURL:API_OTPVERIFICATION andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
        
        [HUD hide:YES];
        NSString * sts = [response objectForKey:@"status"];
        if ([sts isEqualToString:@"true"])
        {
            [NSUD setValue:@"1" forKey:@"IS_LOGIN"];
            [NSUD synchronize];
            
            NSString *strUserType = [NSUD valueForKey:@"user_type"];
            
            if ([strUserType isEqual:@"1"]) {
                
                TabBarVC *TabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
                [self presentViewController:TabBarVC animated:NO completion:nil];
                
            }else{
                
                ServiceProviderTabBarVC *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceProviderTabBarVC"];
                
                [self presentViewController:tabBarVC animated:NO completion:nil];
                
                [self.tabBarController setSelectedIndex:2];
                [[ServiceProviderTabBarVC new] change_TabBar:2];
                
                
//                BookingForYou *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BookingForYou"];
//                [self presentViewController:tabBarVC animated:NO completion:nil];
                
            }
//
//            TabBarVC *TabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
//            [self presentViewController:TabBarVC animated:NO completion:nil];
        }
        else{
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
        }
        
    }];
    
}

@end

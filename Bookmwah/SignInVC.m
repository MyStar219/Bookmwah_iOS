//
//  SignInVC.m
//  Bookmwah
//
//  Created by Developer on 13/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "SignInVC.h"

@interface SignInVC ()
{
    NSString *email,*fbId,*fbPictureURL,*fbName;
}
@end

@implementation SignInVC


@synthesize txtEmail,txtPassword;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // load MBProgressHUD
    [self load_MBProgressHUD];
    fbDictionary = [NSMutableDictionary new];
    [_SignIn addTarget:self action:@selector(btnFacebookPressed) forControlEvents:UIControlEventTouchDown];//fb
    [self changePlaceholderColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

#pragma mark - Change Text Placeholder Color
#pragma mark -

-(void)changePlaceholderColor
{
    txtEmail.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Enter your email"attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    txtPassword.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Enter your password"attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

#pragma mark - Email Validation
#pragma mark -

- (BOOL)validateEmail:(NSString *)emailStr//signin
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

#pragma mark - Validation
#pragma mark -
-(BOOL)validation
{
    if (txtEmail.text.length==0) {
        _AlertView_WithOut_Delegate(@"Warning!", @"Please enter email id", @"OK", nil);
        return NO;
    }
    else if (![self validateEmail:txtEmail.text]) {
        _AlertView_WithOut_Delegate(@"Warning!", @"Please enter valid email id", @"OK", nil);
        return NO;
    }
    else if (txtPassword.text.length==0)
    {
        _AlertView_WithOut_Delegate(@"Warning!", @"Please enter password", @"OK", nil);
        return NO;
    }
    return YES;
}

- (IBAction)signIn:(id)sender {
    
    if([self validation])
    {
        [self call_SignInAPIWithEmail];
    }
    
}
//---------------------------------

- (IBAction)signUpWithEmail:(id)sender {
    SignUpVC *vc = (SignUpVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpVC"];
    [self presentViewController:vc animated:NO completion:nil];
}

-(void)btnFacebookPressed {
    
    [self fbLogout];
    FBSDKLoginManager *fbSDKLoginManager = [[FBSDKLoginManager alloc] init];
    fbSDKLoginManager.loginBehavior = FBSDKLoginBehaviorBrowser;
    
    [fbSDKLoginManager logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error){
             // Process error
         }else if (result.isCancelled){
             
             // Handle cancellations
         }else{
             
             if ([result.grantedPermissions containsObject:@"email"]){
                 
                 NSLog(@"result is:%@",result);
                 [self fetchUserInfo];
                 // [fbSDKLoginManager logOut]; // Only If you don't want to save the session for current app
             }
         }
     }];
}
-(void)fbLogout
{
    
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
    [FBSDKAccessToken setCurrentAccessToken:nil];
}
-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             
             if (!error){
                 
                 NSLog(@"FB Resultis : %@",result);
                 NSDictionary *fbData1 = (NSDictionary *)result;
                 email=fbData1 [@"email"];
                 fbId=fbData1 [@"id"];
                 NSString *f_Name=fbData1 [@"first_name"];
                 NSString *l_Name=fbData1[@"last_name"];
                 fbPictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1",fbId]];
                 fbName = [NSString stringWithFormat:@"%@ %@",f_Name,l_Name];
                 [self call_SignInAPIWithFB];
             }else{
                 
                 NSLog(@"Error %@",error);
             }
         }];
    }
}

#pragma mark - call_SignUpWithEmailAPI
#pragma mark -

-(void)call_SignInAPIWithEmail{
    
    [HUD show:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:@"1" forKey:@"type"];
    [dict setValue:txtEmail.text forKey:@"email"];
    [dict setValue:txtPassword.text forKey:@"password"];
    [dict setValue:[NSUD valueForKey:@"GCMId"] forKey:@"device_id"];
    
    [WebService call_API:dict andURL:API_LOGIN andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
        
        [HUD hide:YES];
        NSString * sts = [response objectForKey:@"status"];
        if ([sts isEqualToString:@"true"])
        {
            
            NSMutableDictionary *dic = [NSMutableDictionary new];
            dic = [response objectForKey:@"user_details"];
            NSLog(@"user _id %@",[dic objectForKey:@"u_id"]);
            [NSUD setObject:[dic objectForKey:@"u_id"] forKey:@"user_id"];
            [NSUD setObject:[dic objectForKey:@"u_wallet"] forKey:@"u_wallet"];
            [NSUD setObject:txtPassword.text forKey:@"password"];
            [NSUD setObject:[dic objectForKey:@"pro_id"] forKey:@"pro_id"];
            [NSUD setObject:[dic objectForKey:@"u_fullname"] forKey:@"u_fullname"];
            [NSUD setObject:[dic objectForKey:@"u_image"] forKey:@"u_image"];
            //[NSUD setObject:[dic objectForKey:@"u_mobile_no"] forKey:@"u_mobile_no"];
            
            [NSUD setObject:[dic objectForKey:@"user_type"] forKey:@"user_type"];
            
            [NSUD synchronize];
            
           // NSString * userID = [dic objectForKey:@"u_id"];
            NSString * userEmail = [dic objectForKey:@"u_email"];
            NSString * userPassword = @"123456";
            
            [self loginUser:userEmail pass:userPassword];
            
            
        }
        else{
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
        }
        
    }];
    
}

-(void)loginUser:(NSString*)email pass:(NSString*)pass {
    
    [[FIRAuth auth]signInWithEmail:email password:pass completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        
        if (error == nil) {
            NSLog(@"Login succesfully");
            
            
            if ([[NSUD valueForKey:@"IS_LOGIN"] isEqualToString:@"0"])
            {
                
                OTPVerificationVC *OTPVerificationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OTPVerificationVC"];
                [self presentViewController:OTPVerificationVC animated:NO completion:nil];
                
                
            } else {
                [NSUD setValue:@"1" forKey:@"IS_LOGIN"];
                [NSUD synchronize];
                
                if ([[NSUD valueForKey:@"user_type"] isEqualToString:@"1"]){
                    
                    TabBarVC *TabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];                [self presentViewController:TabBarVC animated:NO completion:nil];
                    
                }else{
                    
                    ServiceProviderTabBarVC *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceProviderTabBarVC"];
                    
                    [self presentViewController:tabBarVC animated:NO completion:nil];
                    // self.tabBarController.selectedIndex = 2;
                    // [[ServiceProviderTabBarVC new] change_TabBar:2];
                    
                    [self.tabBarController setSelectedIndex:0];
                    [[ServiceProviderTabBarVC new] change_TabBar:0];
                    
                }
                
            }
            
            // let userInfo = ["email": withEmail, "password": password]
            // UserDefaults.standard.set(userInfo, forKey: "userInformation")
            
        }else{
            NSLog(@"Login failed");
        }
    }];
}



#pragma mark - call_SignUpWithFBAPI
#pragma mark -

-(void)call_SignInAPIWithFB{
    
    [HUD show:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:@"2" forKey:@"type"];
    [dict setValue:[NSUD valueForKey:@"GCMId"] forKey:@"device_id"];
    [dict setValue:email forKey:@"email"];
    [dict setValue:fbId forKey:@"fb_id"];
    [dict setValue:fbPictureURL forKey:@"image_url"];
    [dict setValue:fbName forKey:@"name"];
    
    
    [WebService call_API:dict andURL:API_LOGIN andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
        
        [HUD hide:YES];
        NSString * sts = [response objectForKey:@"status"];
        if ([sts isEqualToString:@"true"]) {
            
            [NSUD setValue:@"1" forKey:@"IS_LOGIN"];
            
            NSMutableDictionary *dic = [NSMutableDictionary new];
            dic = [response objectForKey:@"user_details"];
            NSLog(@"%@",[dic objectForKey:@"u_id"]);
            [NSUD setObject:[dic objectForKey:@"u_id"] forKey:@"user_id"];
            [NSUD setObject:[dic objectForKey:@"u_wallet"] forKey:@"u_wallet"];
            [NSUD setObject:txtPassword.text forKey:@"password"];
            [NSUD setObject:[dic objectForKey:@"pro_id"] forKey:@"pro_id"];
            [NSUD setObject:[dic objectForKey:@"u_fullname"] forKey:@"u_fullname"];
            [NSUD setObject:[dic objectForKey:@"u_image"] forKey:@"u_image"];
            [NSUD synchronize];
            TabBarVC *TabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
            [self presentViewController:TabBarVC animated:NO completion:nil];
        }
        else{
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
        }
        
    }];
    
}


- (IBAction)hideKeyboard:(id)sender {
}
@end

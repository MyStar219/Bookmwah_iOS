//
//  SignUpVC.m
//  Bookmwah
//
//  Created by admin on 16/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "SignUpVC.h"

@interface SignUpVC (){
    
    NSString * strUser_ProviderType;
    
}
@property (weak, nonatomic) IBOutlet UILabel *lbl;

@property (strong, nonatomic) IBOutlet UIScrollView *ScrollVw;
@property (strong, nonatomic) IBOutlet UIButton *btn_User;
@property (strong, nonatomic) IBOutlet UIButton *btn_ServiceProvider;
//@property (strong, nonatomic) IBOutlet UIView *MainVw;

@end

@implementation SignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    strUser_ProviderType = @"1";
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    // load MBProgressHUD
    [self load_MBProgressHUD];

    // Change Placeholder Color
    [self changePlaceholderColor];

}

-(void)viewDidAppear:(BOOL)animated
{
    _ScrollVw.contentSize = CGSizeMake(_ScrollVw.contentSize.width,self.lbl.frame.size.height);
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

#pragma mark - Change Text Placeholder Color
#pragma mark - 


-(void)changePlaceholderColor
{
    _txtName.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Enter your name"attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _txtEmail.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Enter your email"attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _txtPassword.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Enter your password"attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _txtRePassword.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Re-Enter your password "attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    _txtPhoneNumber.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Enter your phone number "attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

#pragma mark - Email Validation
#pragma mark -

- (BOOL)validateEmail:(NSString *)emailStr//signin
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

- (BOOL)validatePhone:(NSString *)phoneNumber//signin
{
    NSString *phoneRegex = @"^+(?:[0-9] ?){6,14}[0-9]$";//@"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}

#pragma mark - Validation
#pragma mark -

-(BOOL)validation
{
    if (_txtName.text.length==0) {
        _AlertView_WithOut_Delegate(@"Warning!", @"Please enter name", @"OK", nil);
        return NO;
    }
    else if (_txtEmail.text.length==0){
        _AlertView_WithOut_Delegate(@"Warning!", @"Please enter email id", @"OK", nil);
        return NO;
    }
    else if (![self validateEmail:_txtEmail.text]){
        _AlertView_WithOut_Delegate(@"Warning!", @"Please enter valid email id", @"OK", nil);
        return NO;
    }
    else if(_txtPassword.text.length==0){
        _AlertView_WithOut_Delegate(@"Warning!", @"Please enter password", @"OK", nil);
        return NO;
    }
    else if(![_txtPassword.text isEqualToString:_txtRePassword.text]){
        _AlertView_WithOut_Delegate(@"Warning!", @"Please confirm your password", @"OK", nil);
        return NO;
    }
    else if(_txtPhoneNumber.text.length==0){
        _AlertView_WithOut_Delegate(@"Warning!", @"Please enter phone number", @"OK", nil);
        return NO;
    }
    else if (![self validatePhone:_txtPhoneNumber.text]){
        _AlertView_WithOut_Delegate(@"Warning!", @"Please enter valid phone number", @"OK", nil);
        return NO;
    }
    return YES;
}

- (IBAction)SignUp:(id)sender {
    
    if ([self validation]) {
        [self call_SignUpAPI];
    }
}

-(void)SignIn:(id)sender
{
    SignInVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInVC"];
    [self presentViewController:vc animated:NO completion:nil];
}



- (IBAction)action_User:(id)sender {
    
    strUser_ProviderType = @"1";
    
    [_btn_User setBackgroundColor:[WebService colorWithHexString:@"00AFDF"]];
    
    [_btn_ServiceProvider setBackgroundColor:[WebService colorWithHexString:@"FFFFFF"]];
    
    _btn_User.titleLabel.textColor = [WebService colorWithHexString:@"F6F6F6"];
    
    _btn_ServiceProvider.titleLabel.textColor =[WebService colorWithHexString:@"000000"];
    
}

- (IBAction)action_ServiceProvider:(id)sender {
    
    strUser_ProviderType = @"2";
    
    [_btn_ServiceProvider setBackgroundColor:[WebService colorWithHexString:@"00AFDF"]];
    
    [_btn_User setBackgroundColor:[WebService colorWithHexString:@"FFFFFF"]];
    
    //_btn_ServiceProvider.titleLabel.textColor = [WebService colorWithHexString:@"FFFFFF"];
    
    _btn_User.titleLabel.textColor =[WebService colorWithHexString:@"000000"];
    
    [_btn_ServiceProvider setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}


- (IBAction)hideKeyboard:(id)sender {
}

#pragma mark - call_SignUpAPI
#pragma mark -

-(void)call_SignUpAPI{
    
    [HUD show:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:_txtName.text forKey:@"name"];
    [dict setValue:_txtEmail.text forKey:@"email"];
    [dict setValue:_txtPassword.text forKey:@"password"];
    [dict setValue:[NSUD valueForKey:@"GCMId"] forKey:@"device_id"];
    [dict setValue:_txtPhoneNumber.text forKey:@"mobile"];
    [dict setValue:strUser_ProviderType forKey:@"user_type"];

    
    [WebService call_API:dict andURL:API_SIGNUP andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
        
        if ([[response objectForKey:@"status"]isEqualToString:@"true"]) {
            
            _AlertView_WithOut_Delegate(@"Message", [response objectForKey:@"message"], @"OK", nil);
            
             [HUD hide:YES];
            
            [NSUD setValue:@"0" forKey:@"IS_LOGIN"];
                        
            NSMutableDictionary *dic= [NSMutableDictionary new];
            dic = [response valueForKey:@"user_details"];
            [NSUD setObject:[dic objectForKey:@"u_id"] forKey:@"user_id"];
            [NSUD setObject:[dic objectForKey:@"u_fullname"] forKey:@"u_fullname"];
            [NSUD setObject:[dic objectForKey:@"u_wallet"] forKey:@"u_wallet"];
            [NSUD setObject:[dic objectForKey:@"pro_id"] forKey:@"pro_id"];
            [NSUD setObject:_txtPassword.text forKey:@"password"];
            [NSUD setObject:[dic objectForKey:@"u_image"] forKey:@"u_image"];
            
            [NSUD setObject:[dic objectForKey:@"u_mobile_no"] forKey:@"u_mobile_no"];
            
            [NSUD setObject:[dic objectForKey:@"user_type"] forKey:@"user_type"];

            
            [NSUD synchronize];
             NSString * userID = [dic objectForKey:@"u_id"];
             NSString * userEmail = [dic objectForKey:@"u_email"];
             NSString * userPassword = @"123456";
             NSString * userName = [dic objectForKey:@"u_fullname"];
            
            [self fireBaseSignUP:userID email:userEmail pass:userPassword userName:userName];
            
        }
        else{
            _AlertView_WithOut_Delegate(@"Message", [response objectForKey:@"message"], @"OK", nil);
        }
        
    }];
    

    
}

-(void)fireBaseSignUP:(NSString*)userID email:(NSString*)email pass:(NSString*)pass userName:(NSString*)name {
    
    [[FIRAuth auth]createUserWithEmail:email password:pass completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        
        if (error ==  nil) {
            [user sendEmailVerificationWithCompletion:^(NSError * _Nullable error) {}];
            //[[[[FIRStorage storage]reference]child:"usersProfilePics"]child:[user uid]];
            NSDictionary *values = @{@"name": name, @"email": email,@"localUserID": userID};
            
            [[[[[[FIRDatabase database]reference]child:@"users"]child:userID]child:@"credentials"]updateChildValues:values withCompletionBlock:^(NSError * _Nullable errr, FIRDatabaseReference * _Nonnull ref) {
                
                if (errr == nil) {
                    
                    NSLog(@"Registration succesfully");
                    
                    OTPVerificationVC *OTPVerificationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OTPVerificationVC"];
                    [self presentViewController:OTPVerificationVC animated:NO completion:nil];
                    
                }else{
                    
                    NSLog(@"Registration failed : %@",error.description);
                    
                }
                
            }];
        }else{
            NSLog(@"Registration failed");
            
        }
    }];
}

- (IBAction)btnSelectTermCondition:(UIButton*)sender {
    
        
    
    
}


@end

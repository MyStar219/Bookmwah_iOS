//
//  AccountInfo.m
//  Bookmwah
//
//  Created by admin on 21/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "AccountInfo.h"
#import "Constant.h"

@interface AccountInfo ()

@end

@implementation AccountInfo
@synthesize img;
#pragma mark - View Lifecycle Methods
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    stateArray = [[NSMutableArray new]init];
    [stateArray addObject:@"Madhya Pradesh"];
    [stateArray addObject:@"Uttar Pradesh"];
    [_btnMale addTarget:self action:@selector(selectGender:) forControlEvents:UIControlEventTouchDown];
    [_btnFemale addTarget:self action:@selector(selectGender:) forControlEvents:UIControlEventTouchDown];
    
    img.layer.cornerRadius = img.layer.frame.size.width/2;
    img.clipsToBounds = YES;
    user_dic = [[NSMutableDictionary alloc]init];
    [self call_ProfileInfoAPI];
    
    [self load_MBProgressHUD];
    
    [_txtOldPassword addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    [_txtNewPassword addTarget:self
                        action:@selector(textFieldDidChange:)
              forControlEvents:UIControlEventEditingChanged];
    [_txtRePassword addTarget:self
                        action:@selector(textFieldDidChange:)
              forControlEvents:UIControlEventEditingChanged];
}

-(void)viewDidAppear:(BOOL)animated
{
    _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width,_scrollView.contentSize.height+160);

    [self setTextFieldPlaceholderColor];
    [self setTextFieldPadding];
    [self setTextFieldBorder];
    [_tvView setHidden:true];
    [_genderView setHidden:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Textfield Delegate
#pragma mark -
-(void)textFieldDidChange:(UITextField *)textfield
{
    if (_txtOldPassword.text.length==0&&_txtNewPassword.text.length==0&&_txtRePassword.text.length==0) {
        isChangePassword = false;
    }
    else
    {
        isChangePassword = true;
    }
}

#pragma mark - MBProgressHUD Load
#pragma mark -

-(void)load_MBProgressHUD
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading...";
    HUD.square = YES;
    [self.view addSubview:HUD];
}

#pragma mark - Set TextField Placeholder Color
#pragma mark -

-(void)setTextFieldPlaceholderColor
{
    _txtName.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Name"attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    _txtState.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"State"attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    _txtGender.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Gender"attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    _txtMobNo.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Mobile No."attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    _txtEmail.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Email"attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    _txtAddress.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"House Visit Address"attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    _txtOldPassword.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Old Password"attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    _txtNewPassword.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"New Password"attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    _txtRePassword.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Repeat New Password"attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
}

#pragma mark - Set TextField Padding
#pragma mark -

-(void)setTextFieldPadding
{
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _txtName.frame.size.height)];
    _txtName.leftView = paddingView1;
    _txtName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _txtState.frame.size.height)];
    _txtState.leftView = paddingView2;
    _txtState.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _txtGender.frame.size.height)];
    _txtGender.leftView = paddingView3;
    _txtGender.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _txtMobNo.frame.size.height)];
    _txtMobNo.leftView = paddingView4;
    _txtMobNo.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _txtEmail.frame.size.height)];
    _txtEmail.leftView = paddingView5;
    _txtEmail.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _txtAddress.frame.size.height)];
    _txtAddress.leftView = paddingView6;
    _txtAddress.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _txtOldPassword.frame.size.height)];
    _txtOldPassword.leftView = paddingView7;
    _txtOldPassword.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _txtNewPassword.frame.size.height)];
    _txtNewPassword.leftView = paddingView8;
    _txtNewPassword.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _txtRePassword.frame.size.height)];
    _txtRePassword.leftView = paddingView9;
    _txtRePassword.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - Set TextField Border Width/Color
#pragma mark -

-(void)setTextFieldBorder
{
    _txtName.layer.borderColor = [UIColor grayColor].CGColor;
    _txtName.layer.borderWidth = 1.0f;
    
    _txtState.layer.borderColor = [UIColor grayColor].CGColor;
    _txtState.layer.borderWidth = 1.0f;
    
    _txtGender.layer.borderColor = [UIColor grayColor].CGColor;
    _txtGender.layer.borderWidth = 1.0f;
    
    _txtMobNo.layer.borderColor = [UIColor grayColor].CGColor;
    _txtMobNo.layer.borderWidth = 1.0f;
    
    _txtEmail.layer.borderColor = [UIColor grayColor].CGColor;
    _txtEmail.layer.borderWidth = 1.0f;
    
    _txtAddress.layer.borderColor = [UIColor grayColor].CGColor;
    _txtAddress.layer.borderWidth = 1.0f;
    
    _txtOldPassword.layer.borderColor = [UIColor grayColor].CGColor;
    _txtOldPassword.layer.borderWidth = 1.0f;
    
    _txtNewPassword.layer.borderColor = [UIColor grayColor].CGColor;
    _txtNewPassword.layer.borderWidth = 1.0f;
    
    _txtRePassword.layer.borderColor = [UIColor grayColor].CGColor;
    _txtRePassword.layer.borderWidth = 1.0f;
}


#pragma mark - call_ProfileInfoAPI
#pragma mark -
-(void)call_ProfileInfoAPI{
    
    [HUD show:YES];
    
    NSString *user_id =[NSUD valueForKey:@"user_id"];
    NSLog(@"User id %@",user_id);
    [user_dic setValue:user_id forKey:@"u_id"];
    
    

    [WebService call_API:user_dic andURL:API_PROFILE_INFO andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
    {
        
        [HUD hide:YES];
        NSMutableDictionary *dic = [NSMutableDictionary new];
        dic = [response objectForKey:@"profile_info"];
        
        [img setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"u_image"]] placeholderImage:[UIImage imageNamed:@"big_default_img"]];
        _txtName.text = [dic objectForKey:@"u_fullname"];
        _txtEmail.text = [dic objectForKey:@"u_email"];
        _txtMobNo.text = [dic objectForKey:@"u_mobile_no"];
        _txtState.text = [dic objectForKey:@"u_state"];
        password = [NSUD valueForKey:@"password"];

//        _txtOldPassword.text = [NSUD valueForKey:@"password"];
        NSString *user_gender= [dic objectForKey:@"u_gender"];
        if ([user_gender isEqualToString:@"0"]) {
            gender = 0;
        }
        else if([user_gender isEqualToString:@"1"])
        {
            _txtGender.text =@"Male";
            gender = 1;
        }
        else if([user_gender isEqualToString:@"2"])
        {
            _txtGender.text =@"Female";
            gender = 2;
        }
        NSString *pro_id = [NSUD valueForKey:@"pro_id"];
       // if ([pro_id isEqualToString:@""]) {  //by rd
            
        if ([pro_id isEqual:nil]) {
            [_txtAddress setEnabled:false];
            [_house_call_switch setEnabled:false];
        }
        
        
       // if([[NSUD valueForKey:@"pro_id"] isEqual:nil])
        
    }];

}


#pragma mark - Textfield Validation
#pragma mark -

-(BOOL)validation
{
    if (_txtName.text.length==0) {
        _AlertView_WithOut_Delegate(@"Warining!",@"Please enter name", @"OK", nil);
        return NO;
    }
    else if (_txtState.text.length==0) {
        _AlertView_WithOut_Delegate(@"Warining!",@"Please select state", @"OK", nil);
        return NO;
    }
    else if (_txtGender.text.length==0) {
        _AlertView_WithOut_Delegate(@"Warining!",@"Please select gender", @"OK", nil);
        return NO;
    }
    else if (_txtMobNo.text.length==0)
    {
        _AlertView_WithOut_Delegate(@"Warining!",@"Please enter mobile number", @"OK", nil);
        return NO;
    }
    else if (!(_txtMobNo.text.length==MOBILE_NO))
    {
        _AlertView_WithOut_Delegate(@"Warining!",@"Please enter valid mobile number", @"OK", nil);
        return NO;
    }
    if (isChangePassword) {
        if (_txtOldPassword.text.length==0) {
            _AlertView_WithOut_Delegate(@"Warining!",@"Please enter old password", @"OK", nil);
            return NO;
        }
        if (![_txtOldPassword.text isEqualToString:password]) {
            _AlertView_WithOut_Delegate(@"Warining!",@"Please enter correct old password", @"OK", nil);
            return NO;
        }
        else if (_txtNewPassword.text.length==0) {
            _AlertView_WithOut_Delegate(@"Warining!",@"Please enter new password", @"OK", nil);
            return NO;
        }
        else if (_txtRePassword.text.length==0) {
            _AlertView_WithOut_Delegate(@"Warining!",@"Please Re-enter new password", @"OK", nil);
            return NO;
        }
        else if (![_txtRePassword.text isEqualToString:_txtNewPassword.text]) {
            _AlertView_WithOut_Delegate(@"Warining!",@"Please confirm your password", @"OK", nil);
            return NO;
        }
        
    }
    return YES;
}

/*
 PHP Page: edit_profile.php
	Request parameter: u_id*, name*, state*, gender*, mobile_no*, image, old_pass, new_pass
 */
#pragma mark - call edit/Update ProfileInfoAPI
#pragma mark -
-(void)call_editProfileInfoAPI{
    [HUD show:YES];
    NSMutableDictionary *userDetails = [NSMutableDictionary new];
    NSString *user_id =[NSUD valueForKey:@"user_id"];
    
    [userDetails setValue:user_id forKey:@"u_id"];
    [userDetails setValue:_txtName.text forKey:@"name"];
    [userDetails setValue:_txtState.text forKey:@"state"];
    [userDetails setValue:[NSNumber numberWithInt:gender] forKey:@"gender"];
    [userDetails setValue:_txtMobNo.text forKey:@"mobile_no"];
    if (isChangePassword) {
        [userDetails setValue:_txtOldPassword.text forKey:@"old_pass"];
        [userDetails setValue:_txtNewPassword.text forKey:@"new_pass"];
    }
    [WebService call_API:userDetails andURL:API_EDIT_PROFILE andImage:image andImageName:@"image" OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status) {
     [HUD hide:YES];
     if ([[response valueForKey:@"status"] isEqualToString:@"true"]) {
         _AlertView_WithOut_Delegate(@"Message", [response valueForKey:@"message"], @"OK", nil);
         [NSUD setValue:[response valueForKey:@"name"] forKey:@"u_fullname"];
         [NSUD setValue:[response valueForKey:@"image"] forKey:@"u_image"];
         [NSUD synchronize];
     }
     else
     {
        _AlertView_WithOut_Delegate(@"Message", [response valueForKey:@"message"], @"OK", nil);
     }
}];
    
}



#pragma mark - Save Action
#pragma mark -

- (IBAction)saveAction:(id)sender {
    if ([self validation]) {
        [self call_editProfileInfoAPI];
    }
}

#pragma mark - Back 
#pragma mark -

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Hide State Tableview
#pragma mark -

- (IBAction)btnHide:(id)sender {
    [_tvView setHidden:true];
}

#pragma mark - Tableview Delegate Methods
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return stateArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = [stateArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _txtState.text = [stateArray objectAtIndex:indexPath.row];
    [_tvView setHidden:true];
}

#pragma mark - Show State Tableview
#pragma mark -
- (IBAction)showState:(id)sender {
    [_tvView setHidden:false];
}

#pragma mark - Select Gender
#pragma mark -

-(void)selectGender:(UIButton *)button
{
    //Tag is set in button property
    if (button.tag==1) {
        _txtGender.text = @"Male";
        gender = 1;
    }
    else if (button.tag==2){
        _txtGender.text = @"Female";
        gender = 2;
    }
    [_genderView setHidden:true];
}

#pragma mark - Show Gender View
#pragma mark -

- (IBAction)showGenderView:(id)sender {
    [_genderView setHidden:false];
}

#pragma mark - Hide Gender View
#pragma mark -

- (IBAction)closeGenderView:(id)sender {
    [_genderView setHidden:true];
}

- (IBAction)Camera:(id)sender {
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"Take Photo From Camera"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  //  The user tapped on "Take a photo"
                                  UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                  imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                  imagePickerController.delegate = self;
                                  [self presentViewController:imagePickerController animated:YES completion:^{}];
                              }];
    
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:@"Take Photo From Gallery"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  //  The user tapped on "Choose existing"
                                  UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                  imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                  imagePickerController.delegate = self;
                                  imagePickerController.allowsEditing = YES;
                                  [self presentViewController:imagePickerController animated:YES completion:^{}];
                              }];
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Navigation Controller & Picker Controller Delegate Methods
#pragma mark -

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker
{
    [Picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *) Picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    image = [info valueForKey:UIImagePickerControllerOriginalImage];
    img.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end

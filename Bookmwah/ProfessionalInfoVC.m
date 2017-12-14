//
//  ProfessionalInfoVC.m
//  Bookmwah
//
//  Created by admin on 19/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "ProfessionalInfoVC.h"
#import "Constant.h"

@interface ProfessionalInfoVC (){
    int int_houseCall;
    NSString *lat;
    NSString *lang;
    NSMutableArray *arr;
}
@end
static NSString *notesDirPath;
@implementation ProfessionalInfoVC
@synthesize txtViewOtherNotes,txtName,txtEmail,txtWebsite,txtBusinessName,txtCacellationPolicy,txtRole,txtState,txtZipcode,txtMobileNo,txtBusinessAddress,txtDirection,tbl_Search,vw_Search,txt_Search,shView,datePickerView,datePicker,btnDone,btnRecommendation,btnPortfolio,btnServices,btnInfo,btnBankDetails,btnto,btnfrom;

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [shView setHidden:true];
    
    [datePickerView setHidden:true];
    [self changeTextFieldBorderColor];
    [self changeButtonColor];
    [self addPaddingOnTextfield];
    
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(on_Direction:)];
    tap.numberOfTapsRequired = 1;
    [txtDirection addGestureRecognizer:tap];
    [self load_MBProgressHUD];
    
    if([[NSUD valueForKey:@"pro_id"] isEqual:nil])
    {
        [btnServices setEnabled:NO];
        [btnRecommendation setEnabled:NO];
        [btnPortfolio setEnabled:NO];
        [btnBankDetails setEnabled:NO];
    }
    else
    {
        [self call_ProviderDetailsAPI];
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    _svBtn.contentSize = CGSizeMake(_svBtn.contentSize.width+btnPortfolio.frame.size.width+btnBankDetails.frame.size.width,_svBtn.contentSize.height);

    _sv.contentSize = CGSizeMake(_sv.contentSize.width,_sv.contentSize.height+350);
 [_svBtn setContentOffset:CGPointMake((btnInfo.frame.origin.x-self.view.frame.size.width+btnInfo.frame.size.width), _svBtn.frame.size.height) animated:TRUE];
    
    [tbl_Search setTableFooterView:[UIView new]];
    
    vw_Search.translatesAutoresizingMaskIntoConstraints = YES;
    
    vw_Search.frame=CGRectMake(0,1024, vw_Search.frame.size.width, vw_Search.frame.size.height);
    
    vw_Search.hidden = false;
    
}

#pragma mark - Scroll view delegate
#pragma mark - 

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_svBtn])
    {
        if (scrollView.contentOffset.y > 0  ||  scrollView.contentOffset.y < 0 )
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
    
}

#pragma mark - Change Textfield Border Color
#pragma mark -

-(void)changeTextFieldBorderColor
{
    txtName.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtName.layer.borderWidth = 1.0f;
    
    txtBusinessAddress.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtBusinessAddress.layer.borderWidth = 1.0f;
    
    txtCacellationPolicy.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtCacellationPolicy.layer.borderWidth = 1.0f;
    
    txtBusinessName.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtBusinessName.layer.borderWidth = 1.0f;
    
    txtMobileNo.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtMobileNo.layer.borderWidth = 1.0f;
    
    txtWebsite.layer.borderColor=[WebService colorWithHexString:@"777777"].CGColor;
    txtWebsite.layer.borderWidth=1.0f;
    
    txtEmail.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtEmail.layer.borderWidth = 1.0f;
    
    txtZipcode.layer.borderColor=[WebService colorWithHexString:@"777777"].CGColor;
    txtZipcode.layer.borderWidth=1.0f;
    
    txtState.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtState.layer.borderWidth = 1.0f;
    
    txtViewOtherNotes.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtViewOtherNotes.layer.borderWidth = 1.0f;
    
    txtDirection.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtDirection.layer.borderWidth = 1.0f;
    
    txtRole.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtRole.layer.borderWidth = 1.0f;
    
    btnfrom.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    btnfrom.layer.borderWidth = 1.0f;
    
    btnto.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    btnto.layer.borderWidth = 1.0f;
}

#pragma mark - Change Menu Button Color
#pragma mark -

-(void)changeButtonColor
{
    btnInfo.layer. backgroundColor =[WebService colorWithHexString:@"00afdf"].CGColor;
    
    [btnInfo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btnServices.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnServices setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btnBankDetails.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnBankDetails setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btnPortfolio.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnPortfolio setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btnRecommendation.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnRecommendation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

#pragma mark - Load MBProgressHUD
#pragma mark -

-(void)load_MBProgressHUD
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading...";
    //HUD.detailsLabelText = @"Pdf..";
    HUD.square = YES;
    [self.view addSubview:HUD];
    
}

#pragma mark - Add left view padding on textfield
#pragma mark -

-(void)addPaddingOnTextfield
{
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtName.frame.size.height)];
    txtName.leftView = paddingView1;
    txtName.leftViewMode = UITextFieldViewModeAlways;
    txtName.textColor = [UIColor grayColor];
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtBusinessName.frame.size.height)];
    txtBusinessName.leftView = paddingView2;
    txtBusinessName.leftViewMode = UITextFieldViewModeAlways;
    txtBusinessName.textColor = [UIColor grayColor];
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtBusinessAddress.frame.size.height)];
    txtBusinessAddress.leftView = paddingView3;
    txtBusinessAddress.leftViewMode = UITextFieldViewModeAlways;
    txtBusinessAddress.textColor = [UIColor grayColor];
    
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtRole.frame.size.height)];
    txtRole.leftView = paddingView4;
    txtRole.leftViewMode = UITextFieldViewModeAlways;
    txtRole.textColor = [UIColor grayColor];
    
    UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtBusinessAddress.frame.size.height)];
    txtBusinessAddress.leftView = paddingView5;
    txtBusinessAddress.leftViewMode = UITextFieldViewModeAlways;
    txtBusinessAddress.textColor = [UIColor grayColor];
    
    UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtEmail.frame.size.height)];
    txtEmail.leftView = paddingView6;
    txtEmail.leftViewMode = UITextFieldViewModeAlways;
    txtEmail.textColor = [UIColor grayColor];
    
    UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtZipcode.frame.size.height)];
    txtZipcode.leftView = paddingView7;
    txtZipcode.leftViewMode = UITextFieldViewModeAlways;
    txtZipcode.textColor = [UIColor grayColor];
    
    UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtState.frame.size.height)];
    txtState.leftView = paddingView8;
    txtState.leftViewMode = UITextFieldViewModeAlways;
    txtState.textColor = [UIColor grayColor];
    
    UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtMobileNo.frame.size.height)];
    txtMobileNo.leftView = paddingView9;
    txtMobileNo.leftViewMode = UITextFieldViewModeAlways;
    txtMobileNo.textColor = [UIColor grayColor];
    
    UIView *paddingView10 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtWebsite.frame.size.height)];
    txtWebsite.leftView = paddingView10;
    txtWebsite.leftViewMode = UITextFieldViewModeAlways;
    txtWebsite.textColor = [UIColor grayColor];
    
    UIView *paddingView11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtCacellationPolicy.frame.size.height)];
    txtCacellationPolicy.leftView = paddingView11;
    txtCacellationPolicy.leftViewMode = UITextFieldViewModeAlways;
    txtCacellationPolicy.textColor = [UIColor grayColor];

}

-(void)call_ProviderDetailsAPI{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    NSString *pro_id = [NSUD valueForKey:@"pro_id"];
    
    if (pro_id == nil) {
        
         [dict setValue: @"4" forKey:@"pro_id"];
        
    }else{
        
         [dict setValue: pro_id forKey:@"pro_id"];
        
    }
    
   
    
    [dict setValue:@"2" forKey:@"type"];
    
    [HUD show:YES];
    
    [WebService call_API:dict andURL:API_PROVIDERS_DETAILS andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
    {
        
        [HUD hide:YES];
        if ([[response objectForKey:@"status"] isEqualToString:@"true"]) {
            NSMutableDictionary *dic = [NSMutableDictionary new];
            dic = [response valueForKey:@"provider_details"];
            //arrayData = [dic valueForKey:@"bank_details"];
            
            txtName.text = [dic  valueForKey:@"pro_name"];
            txtRole.text = [dic  valueForKey:@"pro_role"];
            txtEmail.text = [dic  valueForKey:@"pro_email"];
            txtState.text = [dic  valueForKey:@"pro_state"];
            txtWebsite.text = [dic  valueForKey:@"pro_website"];
            txtZipcode.text = [dic  valueForKey:@"pro_zipcode"];
            txtMobileNo.text = [dic  valueForKey:@"pro_mobile_no"];
            txtBusinessName.text = [dic  valueForKey:@"pro_business_name"];
            txtBusinessAddress.text = [dic  valueForKey:@"pro_addr"];
            txtCacellationPolicy.text = [dic  valueForKey:@"pro_cancel_policy"];
            txtViewOtherNotes.text =[dic  valueForKey:@"pro_other_notes"];
            txtDirection.text = [dic  valueForKey:@"pro_direction"];
            int_houseCall =[[dic  valueForKey:@"pro_status"]intValue];
            lang = [dic  valueForKey:@"pro_lat"];
            lat = [dic  valueForKey:@"pro_long"];
            btnto.titleLabel.text =  [dic  valueForKey:@"pro_availability_to"];
            btnfrom.titleLabel.text = [dic  valueForKey:@"pro_availability_from"];
            
        }else{
            
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
        }
        
    }];
}


-(void)call_InfoAPI{
    
    [HUD show:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:txtName.text forKey:@"name"];
    [dict setValue:txtRole.text forKey:@"role"];
    [dict setValue:txtEmail.text forKey:@"email"];
    [dict setValue:txtState.text forKey:@"state"];
    [dict setValue:txtWebsite.text forKey:@"website"];
    [dict setValue:txtZipcode.text forKey:@"zipcode"];
    [dict setValue:txtMobileNo.text forKey:@"mobile_no"];
    [dict setValue:txtBusinessName.text forKey:@"business_name"];
    [dict setValue:txtBusinessAddress.text forKey:@"address"];
    [dict setValue:txtCacellationPolicy.text forKey:@"c_policy"];
    [dict setValue:txtViewOtherNotes.text forKey:@"other_notes"];
    [dict setValue:[NSString stringWithFormat:@"%d",int_houseCall] forKey:@"house_call"];
    [dict setValue:lang forKey:@"longitude"];
    [dict setValue:lat forKey:@"latitude"];
    [dict setValue:btnto.titleLabel.text forKey:@"availability_to"];
    [dict setValue:btnfrom.titleLabel.text forKey:@"availability_from"];
    NSString *u_id = [NSUD valueForKey:@"user_id"];
    [dict setValue:u_id forKey:@"user_id"];
    [dict setValue:txtDirection.text forKey:@"direction"];

     [WebService call_API:dict andURL:API_ADD_PROVIDER_INFO andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
    {
        
        [HUD hide:YES];
        
        NSString * sts = [response objectForKey:@"status"];
        NSLog(@"status %@",sts);
        NSLog(@"response %@",[response valueForKey:@"message"]);
        if ([sts isEqualToString:@"true"]) {
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
            
            [defaults setObject:[response objectForKey:@"pro_id"] forKey:@"pro_id"];
            [NSUD setObject:[response objectForKey:@"pro_id"] forKey:@"pro_id"];
            [NSUD synchronize];

            [btnServices setEnabled:YES];
            [btnRecommendation setEnabled:YES];
            [btnPortfolio setEnabled:YES];
            [btnBankDetails setEnabled:YES];
            
        }
        else{
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
        }
        
    }];
    
}


-(void)call_InfoUpdateAPI{
    
    [HUD show:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:txtName.text forKey:@"name"];
    [dict setValue:txtRole.text forKey:@"role"];
    [dict setValue:txtEmail.text forKey:@"email"];
    [dict setValue:txtState.text forKey:@"state"];
    [dict setValue:txtWebsite.text forKey:@"website"];
    [dict setValue:txtZipcode.text forKey:@"zipcode"];
    [dict setValue:txtMobileNo.text forKey:@"mobile_no"];
    [dict setValue:txtBusinessName.text forKey:@"business_name"];
    [dict setValue:txtBusinessAddress.text forKey:@"address"];
    [dict setValue:txtCacellationPolicy.text forKey:@"c_policy"];
    [dict setValue:txtViewOtherNotes.text forKey:@"other_notes"];
    [dict setValue:[NSString stringWithFormat:@"%d",int_houseCall] forKey:@"house_call"];
    [dict setValue:lang forKey:@"longitude"];
    [dict setValue:lat forKey:@"latitude"];
    [dict setValue:btnto.titleLabel.text forKey:@"availability_to"];
    [dict setValue:btnfrom.titleLabel.text forKey:@"availability_from"];
    [dict setValue:txtDirection.text forKey:@"direction"];
    NSString *u_id = [NSUD valueForKey:@"user_id"];
    [dict setValue:u_id forKey:@"user_id"];
    NSString *pro_id = [NSUD valueForKey:@"pro_id"];
    [dict setValue:pro_id forKey:@"pro_id"];
    
    
    
    
    [WebService call_API:dict andURL:API_ADD_PROVIDER_INFO andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
    {
        
        [HUD hide:YES];
        
        
        NSString * sts = [response objectForKey:@"status"];
        NSLog(@"status %@",sts);
        NSLog(@"response %@",[response valueForKey:@"message"]);
        if ([sts isEqualToString:@"true"]) {
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
            
            NSString * pro_id = [response objectForKey:@"pro_id"];
            
            [NSUD setValue:pro_id forKey: @"pro_id"];//:@"pro_id"];
        }
        else{
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
        }
        
    }];
    
}



- (IBAction)Info:(id)sender {
   
    ProfessionalInfoVC *professionalInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalInfoVC"];
    
    [self.navigationController pushViewController:professionalInfoVC animated:NO];
    //[self presentViewController:professionalInfoVC animated:false completion:nil];
    
}

- (IBAction)Portfolio:(id)sender {
    
    PortfolioVC *portfolioVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PortfolioVC"];
    [self.navigationController pushViewController:portfolioVC animated:NO];
}

- (IBAction)BankDetails:(id)sender {

    ProfessionalBankDetailsVC *professionalBankDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalBankDetailsVC"];
    
    [self.navigationController pushViewController:professionalBankDetailsVC animated:NO];
    
}

- (IBAction)houseCall:(id)sender {

    if (int_houseCall == 0) {
        int_houseCall = 1;
        [_btn_houseCall setImage:[UIImage imageNamed:@"toggle_on"] forState:UIControlStateNormal];
    }else{
        int_houseCall =0;
        [_btn_houseCall setImage:[UIImage imageNamed:@"toggle_off"] forState:UIControlStateNormal];
    }
}

- (void)on_Direction:(id)sender {
    arr = [[NSMutableArray alloc]init];
   
    [tbl_Search reloadData];
    
    txt_Search.text = @"";
    
    //   txt_Search.tag = [sender tag];
    
    [UIView animateWithDuration:.5 animations:^{
        
        vw_Search.frame=CGRectMake(0,0, vw_Search.frame.size.width, vw_Search.frame.size.height);
        
    }completion:^(BOOL finished) {
        
    }];
    
}

- (IBAction)Done:(id)sender {
    
    NSDate *tim= datePicker.date;
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh:mm a"];
    time = [formatter stringFromDate:tim];
    
    
    NSLog(@"%@",time);
    if (btnDone.tag==1) {
        [btnfrom setTitle:time forState:UIControlStateNormal];
    }
    if (btnDone.tag==2) {
        [btnto setTitle:time forState:UIControlStateNormal];
    }
    
    [datePickerView setHidden:true];
    
    [shView setHidden:true];


}

- (IBAction)CancelPicker:(id)sender {
    
    [datePickerView setHidden:true];
    [shView setHidden:true];
}

- (IBAction)From:(id)sender {
    
    btnDone.tag =1;
    [self.view endEditing:YES];
    _lbl_DateTimeHeader.text = @"Avability From";

    [datePickerView setHidden:false];
    [shView setHidden:false];
}

- (IBAction)To:(id)sender {
    _lbl_DateTimeHeader.text = @"Avability To";
        [self.view endEditing:YES];
    btnDone.tag =2;
    
    [datePickerView setHidden:false];
    [shView setHidden:false];
    
}

- (IBAction)Recommendation:(id)sender {

    ProfessionalRecommendationVC *professionalServicesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalRecommendationVC"];
    
    [self.navigationController pushViewController:professionalServicesVC animated:NO];

}

- (IBAction)Services:(id)sender {
    
    ProfessionalServicesVC *professionalServicesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalServicesVC"];
    
    [self.navigationController pushViewController:professionalServicesVC animated:NO];

}

- (BOOL)validatePhone:(NSString *)phoneNumber//signin
{
    NSString *phoneRegex = @"^+(?:[0-9] ?){6,14}[0-9]$";//@"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}

#pragma mark - Email Validation
#pragma mark -

- (BOOL)validateEmail:(NSString *)emailStr//signin
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

#pragma mark - TextField Validation
#pragma mark -

-(BOOL)validation
{
    if (txtName.text.length==0) {
        _AlertView_WithOut_Delegate(@"Error", @"Please enter name", @"OK", nil);
        return NO;
    }
    else if (txtBusinessName.text.length==0) {
        _AlertView_WithOut_Delegate(@"Error", @"Please enter business name", @"OK", nil);
        return NO;
    }
    else if (txtBusinessAddress.text.length==0) {
        _AlertView_WithOut_Delegate(@"Error", @"Please enter business address", @"OK", nil);
        return NO;
    }
    else if (txtRole.text.length==0) {
        _AlertView_WithOut_Delegate(@"Error", @"Please enter role", @"OK", nil);
        return NO;
    }
    else if (txtZipcode.text.length==0) {
        _AlertView_WithOut_Delegate(@"Error", @"Please enter zipcode", @"OK", nil);
        return NO;
    }
    else if (txtState.text.length==0) {
        _AlertView_WithOut_Delegate(@"Error", @"Please enter state", @"OK", nil);
        return NO;
    }
    else if (txtMobileNo.text.length==0) {
        _AlertView_WithOut_Delegate(@"Error", @"Please enter mobile number", @"OK", nil);
        return NO;
    }
    else if (![self validatePhone:txtMobileNo.text]){
        _AlertView_WithOut_Delegate(@"Warning!", @"Please enter valid mobile number", @"OK", nil);
        return NO;
    }
    else if (txtEmail.text.length==0) {
        _AlertView_WithOut_Delegate(@"Error", @"Please enter email id", @"OK", nil);
        return NO;
    }
    else if (![self validateEmail:txtEmail.text])
    {
        _AlertView_WithOut_Delegate(@"Error", @"Please enter correct email id", @"OK", nil);
        return NO;
    }
    else if (txtWebsite.text.length==0)
    {
        _AlertView_WithOut_Delegate(@"Error", @"Please enter website name", @"OK", nil);
        return NO;
    }
    else if (txtCacellationPolicy.text.length==0)
    {
        _AlertView_WithOut_Delegate(@"Error", @"Please enter cancelation policy", @"OK", nil);
        return NO;
    }
    else if (txtViewOtherNotes.text.length==0)
    {
        _AlertView_WithOut_Delegate(@"Error", @"Please enter other notes ", @"OK", nil);
        return NO;
    }

    
    return YES;
}

#pragma  mark - Save Action
#pragma mark -

- (IBAction)Save:(id)sender {
    
    if ([self validation]) {
        NSString *pro_id = [NSUD valueForKey:@"pro_id"];
        
        if([pro_id isEqual:nil]){
        
       // if ([pro_id isEqualToString:@""]) { //by rd 
            [self call_InfoAPI];
        }
        else{
            [self call_InfoUpdateAPI];
        }
    }

}

-(IBAction)on_cancel_search:(id)sender

{
    
    [txt_Search resignFirstResponder];
    
    [UIView animateWithDuration:.5 animations:^{
        
        vw_Search.frame=CGRectMake(0,1024, vw_Search.frame.size.width, vw_Search.frame.size.height);
        
    }completion:^(BOOL finished) {
        
        vw_Search.frame=CGRectMake(0,1024, vw_Search.frame.size.width, vw_Search.frame.size.height);
        
    }];
}

-(IBAction)on_searchaddress:(id)sender{
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    NSString *strURL=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@",txt_Search.text];
    
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:strURL];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:
     
     ^(NSURLResponse *resp, NSData *data, NSError *err){
         NSMutableDictionary *dictRoot=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         arr=[dictRoot objectForKey:@"results"];
         
         [tbl_Search reloadData];
         
     } ];
}


#pragma mark - Tableview delegates methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *Cell =[[UITableViewCell alloc]init];
    NSMutableDictionary *dict = [arr objectAtIndex:indexPath.row];
    Cell.textLabel.text = [dict objectForKey:@"formatted_address"];
    [Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    Cell.textLabel.font =[UIFont systemFontOfSize:12];
    
    return Cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dict = [arr objectAtIndex:indexPath.row];
    txtDirection.text=[dict objectForKey:@"formatted_address"];
    NSMutableDictionary *dict1 = [dict objectForKey:@"geometry"];
    NSMutableDictionary *dict2 = [dict1 objectForKey:@"location"];
    lat = [[dict2 objectForKey:@"lat"] stringValue];
    lang = [[dict2 objectForKey:@"lng"] stringValue];
    [self on_cancel_search:self];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

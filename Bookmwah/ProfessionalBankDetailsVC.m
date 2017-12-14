//
//  ProfessionalBankDetailsVC.m
//  Bookmwah
//
//  Created by admin on 09/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "ProfessionalBankDetailsVC.h"

@interface ProfessionalBankDetailsVC ()

@end

@implementation ProfessionalBankDetailsVC

@synthesize txtAccNo,txtBankName,txtHolderName,btnRecommendation,btnBankDetails,btnPortfolio,btnServices,btnInfo,svBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    array = [[NSMutableArray alloc]init];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtHolderName.frame.size.height)];
    txtHolderName.leftView = paddingView1;
    txtHolderName.leftViewMode = UITextFieldViewModeAlways;
    txtHolderName.textColor = [UIColor grayColor];
    
    txtHolderName.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtHolderName.layer.borderWidth = 1.0f;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtBankName.frame.size.height)];
    txtBankName.leftView = paddingView2;
    txtBankName.leftViewMode = UITextFieldViewModeAlways;
    txtBankName.textColor = [UIColor grayColor];
    
    txtBankName.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtBankName.layer.borderWidth = 1.0f;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtAccNo.frame.size.height)];
    txtAccNo.leftView = paddingView3;
    txtAccNo.leftViewMode = UITextFieldViewModeAlways;
    txtAccNo.textColor = [UIColor grayColor];
    
    txtAccNo.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtAccNo.layer.borderWidth = 1.0f;

    [self changeButtonColor];
    [self load_MBProgressHUD];
    
    [self call_ProviderDetailsAPI];

}



-(void)load_MBProgressHUD
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading...";
    //HUD.detailsLabelText = @"Pdf..";
    HUD.square = YES;
    [self.view addSubview:HUD];
    
}

-(void)call_ProviderDetailsAPI{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    NSString *pro_id = [NSUD valueForKey:@"pro_id"];
    [dict setValue:pro_id forKey:@"pro_id"];
    
//    NSString *s_cat_id = [defaults valueForKey:@"s_cat_id"];
//    [dict setValue:s_cat_id forKey:@"cat_id"];
    
    [dict setValue:@"2" forKey:@"type"];
    
    [HUD show:YES];
    
    [WebService call_API:dict andURL:API_PROVIDERS_DETAILS andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {

        
        [HUD hide:YES];
        if ([[response objectForKey:@"status"] isEqualToString:@"true"]) {
            NSMutableDictionary *dic = [NSMutableDictionary new];
            dic = [response valueForKey:@"provider_details"];
            array = [dic valueForKey:@"bank_details"];
            
            if (array.count > 0) {
                
                txtHolderName.text = [[array valueForKey:@"bd_holder_name"]objectAtIndex:0];
                txtBankName.text = [[array valueForKey:@"bd_bank"]objectAtIndex:0];
                txtAccNo.text =[[array valueForKey:@"bd_account_no"]objectAtIndex:0];
                
            }
            // NSMutableDictionary
            
        }else{
            
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"msg"], @"OK", nil);
        }
        
    }];
}


-(void)call_BankDetailsUpdateAPI{
    
    [HUD show:YES];
    
    //   pro_id*, bank*, holder_name*, account_no*, bd_id (for updating bank details)
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:txtHolderName.text forKey:@"holder_name"];
    [dict setValue:txtBankName.text forKey:@"bank"];
    [dict setValue:txtAccNo.text forKey:@"account_no"];
    NSString *pro_id = [defaults valueForKey:@"pro_id"];
    [dict setValue:pro_id forKey:@"pro_id"];
    NSString *bd_id = [defaults valueForKey:@"bd_id"];
    [dict setValue:bd_id forKey:@"bd_id"];
    
    [WebService call_API:dict andURL:API_ADD_BANK_DETAILS andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {

        
        [HUD hide:YES];
        
        NSString * sts = [response objectForKey:@"status"];
        
        if ([sts isEqualToString:@"true"]) {
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
            
            
        }else{
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
        }
        
    }];
    
}


-(void)call_BankDetailsAPI{
    
    [HUD show:YES];
    
    //   pro_id*, bank*, holder_name*, account_no*, bd_id (for updating bank details)
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:txtHolderName.text forKey:@"holder_name"];
    [dict setValue:txtBankName.text forKey:@"bank"];
    [dict setValue:txtAccNo.text forKey:@"account_no"];
    NSString *pro_id = [defaults valueForKey:@"pro_id"];
    [dict setValue:pro_id forKey:@"pro_id"];
    
    
    
    [WebService call_API:dict andURL:API_ADD_BANK_DETAILS andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
        
        [HUD hide:YES];
        
        NSString * sts = [response objectForKey:@"status"];
        if ([sts isEqualToString:@"true"]) {
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
            
            NSLog(@"bd_id %@",[response objectForKey:@"bd_id"]);
            [defaults setObject:[response objectForKey:@"bd_id"] forKey:@"bd_id"];
            
            
        }
        else{
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
        }
        
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    svBtn.contentSize = CGSizeMake(svBtn.contentSize.width+btnPortfolio.frame.size.width+btnBankDetails.frame.size.width,svBtn.contentSize.height);
    
    [svBtn setContentOffset:CGPointMake((btnBankDetails.frame.origin.x-self.view.frame.size.width+btnBankDetails.frame.size.width), svBtn.frame.size.height) animated:TRUE];

    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:svBtn])
    {
        if (scrollView.contentOffset.y > 0  ||  scrollView.contentOffset.y < 0 )
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
    
}


-(void)changeButtonColor
{
    btnBankDetails.layer. backgroundColor =[WebService colorWithHexString:@"00afdf"].CGColor;
    
    [btnBankDetails setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btnInfo.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btnServices.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnServices setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btnPortfolio.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnPortfolio setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btnRecommendation.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnRecommendation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (IBAction)Services:(id)sender {
 
    
    ProfessionalServicesVC *professionalServicesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalServicesVC"];
    
    [self.navigationController pushViewController:professionalServicesVC animated:NO];
    
}

- (IBAction)Recommendation:(id)sender {
    
    ProfessionalRecommendationVC *professionalRecommendationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalRecommendationVC"];
    
    [self.navigationController pushViewController:professionalRecommendationVC animated:NO];
}

- (IBAction)Info:(id)sender {
    
    ProfessionalInfoVC *professionalInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalInfoVC"];
    
    [self.navigationController pushViewController:professionalInfoVC animated:NO];
}

- (IBAction)Portfolio:(id)sender {
    
    PortfolioVC *portfolioVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PortfolioVC"];
    [self.navigationController pushViewController:portfolioVC animated:NO];
}

- (IBAction)BankDetails:(id)sender {
    
    ProfessionalBankDetailsVC *professionalBankDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalBankDetailsVC"];
    
    [self.navigationController pushViewController:professionalBankDetailsVC animated:NO];
}


- (IBAction)Save:(id)sender {
    
    NSString *bd_id = [defaults valueForKey:@"bd_id"];
    if (!bd_id) {
        [self call_BankDetailsAPI];
    }
    else{
        [self call_BankDetailsUpdateAPI];
    }
}

- (IBAction)Cancel:(id)sender {
    
    ProfessionalInfoVC *professionalInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalInfoVC"];
    
    [self.navigationController pushViewController:professionalInfoVC animated:NO];

}
@end

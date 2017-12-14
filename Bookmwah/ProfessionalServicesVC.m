//
//  ProfessionalServicesVC.m
//  Bookmwah
//
//  Created by admin on 20/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "ProfessionalServicesVC.h"

@interface ProfessionalServicesVC ()
{
    NSMutableArray *array;
    long tag;
}
@end

@implementation ProfessionalServicesVC
@synthesize tv,sv,viewShadow,tvPopUp,btnInfo,btnServices,btnPortfolio,btnBankDetails,btnRecommendation,svBtn,btnPopup;
- (void)viewDidLoad {
    [super viewDidLoad];
    [tvPopUp setHidden:true];
    defaults = [NSUserDefaults standardUserDefaults];
    
    arrayTVData=[[NSMutableArray alloc]init];
    array = [[NSMutableArray alloc]init];
    arrayPopUp = [[NSMutableArray alloc]initWithObjects:@"",nil];
    
    
    [tv reloadData];
    [viewShadow setHidden:YES];
    [self changeButtonColor];
    [self call_ProviderDetailsAPI];
    [self call_ServiceCategoryAPI];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:svBtn])
    {
        
        if (scrollView.contentOffset.y > 0  ||  scrollView.contentOffset.y < 0 )
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    sv.contentSize = CGSizeMake(sv.contentSize.width,sv.contentSize.height+1050);
    svBtn.contentSize = CGSizeMake(svBtn.contentSize.width+btnPortfolio.frame.size.width+btnBankDetails.frame.size.width,svBtn.contentSize.height);

    [svBtn setContentOffset:CGPointMake((btnServices.frame.origin.x), svBtn.frame.size.height) animated:TRUE];
    [tv reloadData];

}

-(void)changeButtonColor
{
    btnServices.layer. backgroundColor =[WebService colorWithHexString:@"00afdf"].CGColor;
    
    [btnServices setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btnInfo.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btnBankDetails.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnBankDetails setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btnPortfolio.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnPortfolio setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btnRecommendation.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnRecommendation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}


-(void)load_MBProgressHUD
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading...";
    //HUD.detailsLabelText = @"Pdf..";
    HUD.square = YES;
    [self.view addSubview:HUD];
    
}


#pragma mark - call_ServiceCategoryAPI
#pragma mark -

-(void)call_ServiceCategoryAPI{
    
    [HUD show:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
   // [dict setValue:[NSUD valueForKey:@"user_id"] forKey:@"u_id"];

  //  [WebService call_API:dict andURL:API_PROFILE_INFO andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) { ///by rd
    
    [WebService call_API:dict andURL:API_SERVICE_CATEGORY andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
        
        [HUD hide:YES];
        
        if ([@"true" isEqualToString:[response objectForKey:@"status"]]) {
           
            array =[response objectForKey:@"service_category"];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            dic = [array objectAtIndex:tag];
            NSString *str =[dic valueForKey:@"s_cat_id"];
            
            [defaults setObject:str forKey:@"s_cat_id"];
            [tvPopUp reloadData];
        }
    }];
}

-(void)call_ProviderDetailsAPI{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];

    NSString *pro_id = [defaults valueForKey:@"pro_id"];
    [dict setValue:pro_id forKey:@"pro_id"];
   // [dict setValue:@"30" forKey:@"pro_id"];
    
    
    NSString *s_cat_id = [defaults valueForKey:@"s_cat_id"];//[data setObject:@"1" forKey:@"type"];
    [dict setValue:s_cat_id forKey:@"cat_id"];

    [dict setValue:@"2" forKey:@"type"];

    [HUD show:YES];
    
    [WebService call_API:dict andURL:API_PROVIDERS_DETAILS andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
        
        [HUD hide:YES];
        if ([[response objectForKey:@"status"] isEqualToString:@"true"]) {
            NSMutableDictionary *dic = [NSMutableDictionary new];
            dic = [response valueForKey:@"provider_details"];
            arrayTVData = [dic valueForKey:@"services"];
            
            [tv reloadData];
        }else{
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
        }
        
    }];
}
- (IBAction)btnPopUp:(id)sender {
    
    [tvPopUp setHidden:false];
    [viewShadow setHidden:false];
    [btnPopup setHidden:false];
    [self call_ServiceCategoryAPI];
}

- (IBAction)btnCancelPopUp:(id)sender {
    
    [tvPopUp setHidden:true];
    [viewShadow setHidden:true];
    [btnPopup setHidden:true];
    //[self call_ServiceCategoryAPI];
}


#pragma mark - TableView Delegate Methods
#pragma mark -


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == tv) {
        
        return  arrayTVData.count;
        
    }
    else if(tableView == tvPopUp){
        
        return  array.count;
    }
    
    return 1;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *dic ;
    
    NSString *cellIdentifier = @"itemCell ";
    
    ProfessionalServicesTVCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tableView == tv) {
        dic = [arrayTVData objectAtIndex:indexPath.row];
        
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ProfessionalServicesTVCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
        cell.lblServices.text  = [dic valueForKey:@"s_name"];
        
        cell.lblCost.text   = [dic valueForKey:@"s_cost"];
        
                
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [cell.showSave addTarget:self action:@selector(showupdate:) forControlEvents:UIControlEventTouchDown];

        cell.showSave.tag = indexPath.row;

        [cell.showCancel addTarget:self action:@selector(showcancel:) forControlEvents:UIControlEventTouchDown];
        
        cell.showCancel.tag = indexPath.row;

        
        return cell;

    }
    if (tableView==tvPopUp)
    {
        dic = [array objectAtIndex:indexPath.row];
        
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ProfessionalServicesPopUpTVCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
        NSString *str ;
        str =[dic valueForKey:@"s_cat_name"];
        NSLog(@"name%@",str);
        [cell.showPopUp setTitle:str forState:UIControlStateNormal];
        [cell.showPopUp setTag:indexPath.row];
        
        [cell.showPopUp addTarget:self action:@selector(showpopup:) forControlEvents:UIControlEventTouchDown];
        
        return cell;
        
    }
    return  nil;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (tableView==tvPopUp) {
        // Create label with section title
        UILabel *serviceType = [[UILabel alloc] init];
        serviceType.frame = CGRectMake(80, 5, 284, 23);
        serviceType.textColor = [UIColor whiteColor];
        serviceType.font = [UIFont fontWithName:@"Corbel" size:16];
        serviceType.text = @"Select Service Type";
        serviceType.backgroundColor = [WebService colorWithHexString:@"#00afdf"];
        
        // Create header view and add label as a subview
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        [view setBackgroundColor:[WebService colorWithHexString:@"#00afdf"]];
        [view addSubview:serviceType];
        
        return view;
    }if(tableView==tv){
        
        UILabel *serviceName = [[UILabel alloc] init];
        serviceName.frame = CGRectMake(8, 5, 284, 23);
        serviceName.textColor = [UIColor blackColor];
        serviceName.font = [UIFont fontWithName:@"Corbel" size:16];
        serviceName.text = @"Services";
        serviceName.backgroundColor = [WebService colorWithHexString:@"#eeeeee"];
        
        UILabel *serviceRate = [[UILabel alloc] init];
        serviceRate.frame = CGRectMake(160, 5, 284, 23);
        serviceRate.textColor = [UIColor blackColor];
        serviceRate.font = [UIFont fontWithName:@"Corbel" size:16];
        serviceRate.text = @"Rates";
        serviceRate.backgroundColor = [WebService colorWithHexString:@"#eeeeee"];
        
        // Create header view and add label as a subview
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        [view setBackgroundColor:[WebService colorWithHexString:@"#eeeeee"]];
        [view addSubview:serviceName];
        [view addSubview:serviceRate];

        return view;
    }
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tv) {
        return 50;
    }
    if(tableView==tvPopUp)
    {
        return 50;
    }
    return 0;
}
-(void)showpopup:(UIButton *)sender{
    
    NSLog(@"call Show  1");
     tag = [sender tag];
    [tvPopUp setHidden:true];
    [viewShadow setHidden:true];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic = [array objectAtIndex:tag];
    [defaults setObject:dic forKey:@"sc"];
    
    DiscountVC *DiscountVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DiscountVC"];
    
    [self presentViewController:DiscountVC animated:false completion:nil];

    
}

-(void)showupdate:(id)sender{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    dic = [arrayTVData objectAtIndex:[sender tag]];
    
    NSString *sid  = [dic valueForKey:@"s_id"];
    
    [defaults setObject:sid forKey:@"SERVICEID"];
    
    DiscountVC *discountVC = [self.storyboard
                              instantiateViewControllerWithIdentifier:@"DiscountVC"];
    
    //[self.navigationController pushViewController:professionalServicesVC animated:NO];
    [self presentViewController:discountVC animated:false completion:nil];
    
}

-(void)showcancel:(id)sender{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    dic = [arrayTVData objectAtIndex:[sender tag]];
    
    NSString *sid  = [dic valueForKey:@"s_id"];
    
    [self call_REMOVEAPI:sid];
    
}


-(void)call_REMOVEAPI:(NSString *)ServiceID{
    
    [HUD show:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:ServiceID forKey:@"s_id"];
    
    // [dict setValue:category forKey:@"category"];
    
    [WebService call_API:dict andURL:API_REMOVE_SERVICE andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
        
        [HUD hide:YES];
        
        NSString *sts = [response objectForKey:@"status"];
        
        if ([sts isEqualToString:@"true"]) {
            
            [tv reloadData];
            
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
            
            
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

- (IBAction)Services:(id)sender {

   
    ProfessionalServicesVC *professionalServicesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalServicesVC"];
    
    [self.navigationController pushViewController:professionalServicesVC animated:NO];
    //[self presentViewController:professionalServicesVC animated:false completion:nil];
    
}

- (IBAction)Recommendation:(id)sender {
    
    ProfessionalRecommendationVC *professionalRecommendationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalRecommendationVC"];
    
    [self.navigationController pushViewController:professionalRecommendationVC animated:NO];
    
    //[self presentViewController:professionalRecommendationVC animated:false completion:nil];
    
}

- (IBAction)Info:(id)sender {
    
    
    ProfessionalInfoVC *professionalInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalInfoVC"];
    
    [self.navigationController pushViewController:professionalInfoVC animated:NO];
    //[self presentViewController:professionalInfoVC  animated:false completion:nil];

    
    
    
}

- (IBAction)Portfolio:(id)sender {
 
    
    PortfolioVC *portfolioVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PortfolioVC"];
    [self.navigationController pushViewController:portfolioVC animated:NO];
    
}

- (IBAction)BankDetails:(id)sender {
    
    ProfessionalBankDetailsVC *professionalBankDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalBankDetailsVC"];
    
    [self.navigationController pushViewController:professionalBankDetailsVC animated:NO];
    
    
}

/*CGRect scrollFrame;
scrollFrame.origin = ScrollView.frame.origin;
scrollFrame.size = CGSizeMake(w, h);
ScrollView.frame = scrollFrame;
Edit keeping the center unchanged:

CGRect scrollFrame;
CGFloat newX = scrollView.frame.origin.x + (scrollView.frame.size.width - w) / 2;
CGFloat newY = scrollView.frame.origin.y + (scrollView.frame.size.height - y) / 2;
scrollFrame.origin = CGPointMake(newX, newY);
scrollFrame.size = CGSizeMake(w, h);
scrollView.frame = scrollFrame;*/

 
@end

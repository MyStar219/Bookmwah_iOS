//
//  ProfessionalRecommendationVC.m
//  Bookmwah
//
//  Created by admin on 09/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "ProfessionalRecommendationVC.h"

@interface ProfessionalRecommendationVC ()

@end

@implementation ProfessionalRecommendationVC
@synthesize btnInfo,btnServices,btnPortfolio,btnBankDetails,btnRecommendation,svBtn,tv;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeButtonColor];
    [self call_ServiceProviderDetailsAPI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    svBtn.contentSize = CGSizeMake(svBtn.contentSize.width+btnPortfolio.frame.size.width+btnBankDetails.frame.size.width,svBtn.contentSize.height);
    
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
    btnRecommendation.layer. backgroundColor =[WebService colorWithHexString:@"00afdf"].CGColor;
    
    [btnRecommendation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btnServices.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnServices setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btnInfo.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btnPortfolio.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnPortfolio setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btnBankDetails.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [btnBankDetails setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}



- (IBAction)Services:(id)sender {
    
    ProfessionalServicesVC *professionalServicesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalServicesVC"];
    
    [self.navigationController pushViewController:professionalServicesVC animated:NO];
    
    //[self presentViewController:professionalServicesVC  animated:false completion:nil];
    
    
}

- (IBAction)Recommendation:(id)sender {
    
    ProfessionalRecommendationVC *professionalRecommendationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalRecommendationVC"];
    
    [self.navigationController pushViewController:professionalRecommendationVC animated:NO];
    
    //[self presentViewController:professionalRecommendationVC  animated:false completion:nil];
    
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
    
    //[self presentViewController:professionalBankDetailsVC  animated:false completion:nil];
}


-(void)load_MBProgressHUD
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading...";
    HUD.square = YES;
    [self.view addSubview:HUD];
}

#pragma mark - call_ServiceProviderDetailsAPI
#pragma mark -

-(void)call_ServiceProviderDetailsAPI{
    [HUD show:YES];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[NSUD valueForKey:@"pro_id"] forKey:@"pro_id"];
    [dict setObject:@"2" forKey:@"type"];
    
    [WebService call_API:dict andURL:API_PROVIDERS_DETAILS andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
        
        [HUD hide:YES];
        NSMutableDictionary *dic = [response objectForKey:@"provider_details"];
        arrayRecommendation = [dic objectForKey:@"recommendation"];
        
        [self.tv reloadData];
    }];
    
}


#pragma mark - Tableview  method
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arrayRecommendation.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    NSString *cellIdentifier = @"recomendation";
    
    ProfessionalRecommendationTVCell *cell = [self.tv dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    dic = [arrayRecommendation objectAtIndex:indexPath.row];
    NSString *rating = [dic objectForKey:@"book_rating"];
    cell.ratView.rating = [rating floatValue];
    cell.lblName.text = [dic objectForKey:@"u_fullname"];
    [cell.img setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"u_image"]] placeholderImage:[UIImage imageNamed:@"small_default_img"]];
    
    cell.lblLike.text = [dic objectForKey:@"book_feedback"];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 98;
    
}

@end

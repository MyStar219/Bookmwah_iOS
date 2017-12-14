//
//  ServiceProviderDetailVC.m
//  Bookmwah
//
//  Created by admin on 18/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "ServiceProviderDetailVC.h"

@interface ServiceProviderDetailVC ()
{
}
@end

@implementation ServiceProviderDetailVC

@synthesize tv;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    providerDataDic = [NSMutableDictionary new];
    arrayServicesData = [NSMutableArray new];
    if (_dataDic!=nil) {
        [self load_MBProgressHUD];
        [self call_ServiceProviderDetailsAPI];
    }
    else
    {
        NSLog(@"nil");
    }
    segmentIndex=0;
    [_portfolioCV setHidden:YES];
    
    NSLog(@"data %@",_dataDic);

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
    HUD.square = YES;
    [self.view addSubview:HUD];
}

#pragma mark - call_ServiceProviderDetailsAPI
#pragma mark -

-(void)call_ServiceProviderDetailsAPI{
    [HUD show:YES];
    
    [WebService call_API:_dataDic andURL:API_PROVIDERS_DETAILS andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {

    
        [HUD hide:YES];
        providerDataDic = [response objectForKey:@"provider_details"];
        arrayServicesData = [providerDataDic objectForKey:@"services"];
        arrayPortfolio =  [NSMutableArray new];
        arrayPortfolio = [providerDataDic objectForKey:@"portfolio"];
        arrayRecommendation = [providerDataDic objectForKey:@"recommendation"];
        NSLog(@"provider details %@",providerDataDic);
        [NSUD setValue:[providerDataDic valueForKey:@"pro_lat"] forKey:@"pro_lat"];
        [NSUD setValue:[providerDataDic valueForKey:@"pro_long"] forKey:@"pro_long"];
        [self.tv reloadData];
    }];
    
}

#pragma mark - Tableview  method
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section==0){
        return 1;
    }
    if (section==1) {
        if (segmentIndex==0) {
                return arrayServicesData.count;
        }
        else if (segmentIndex==1)
        {
            return arrayRecommendation.count;
        }
        else if (segmentIndex==2)
        {
            return 1;
        }
        else if (segmentIndex==3)
        {
            return 1;
        }
     
}
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1)
    {
        if (segmentIndex==0)
        {
            return 40;
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section==1) {
        if (segmentIndex==0) {
            // Create label with section title
            UILabel *serviceName = [[UILabel alloc] init];
            serviceName.frame = CGRectMake(18, 10, 284, 23);
            serviceName.textColor = [UIColor blackColor];
            serviceName.font = [UIFont fontWithName:@"Corbel" size:16];
            serviceName.text = @"Service Names";
            serviceName.backgroundColor = [UIColor clearColor];
            
            UILabel *cost = [[UILabel alloc] init];
            cost.frame = CGRectMake(self.view.frame.size.width-174, 10, 45, 23);
            cost.textColor = [UIColor blackColor];
            cost.font = [UIFont fontWithName:@"Corbel" size:16];
            cost.text = @"Cost";
            cost.backgroundColor = [UIColor clearColor];
            
            // Create header view and add label as a subview
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
            [view setBackgroundColor:[WebService colorWithHexString:@"#eeeeee"]];
            [view addSubview:serviceName];
            [view addSubview:cost];
            return view;
        }
        
    }
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = [NSDictionary new];
    
    NSString *cellIdentifier = @"itemCell ";
    
    ServiceProviderDetailTVCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
   
    if(indexPath.section==0){
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ServiceProviderDetailTVCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
        
        cell.lblProviderName.text  = [providerDataDic valueForKey:@"pro_name"];
        providerDescription =[providerDataDic valueForKey:@"pro_desc"];

        cell.lblDescription.text = providerDescription;
        
        NSString *time = [NSString stringWithFormat:@"%@ to %@",[providerDataDic valueForKey:@"pro_availability_from"],[providerDataDic valueForKey:@"pro_availability_to"]];
        cell.lblTime.text = time;
        cell.lblTime.textColor = [WebService colorWithHexString:@"#00afdf"];

        cell.lblAddress.text    = [providerDataDic valueForKey:@"pro_addr"];
        NSString *rating = [[providerDataDic valueForKey:@"pro_rating"] stringValue];
        
        if([rating isEqualToString:@""]){
            cell.lblRating.text = @"0";
        }
        else{
            cell.lblRating.text =rating;
        }
        
        NSURL *url = [NSURL URLWithString:[providerDataDic valueForKey:@"pro_image"]];
        [cell.img setImageWithURL:url placeholderImage:[UIImage imageNamed:@"big_default_img"]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString * category = [providerDataDic objectForKey:@"s_cat_name"];
        //set Category
    

        if (![category isKindOfClass:[NSNull class]]) {
            NSString *category = [providerDataDic objectForKey:@"s_cat_name"];
            
            cell.lblCategory.text = category;
            cell.lblCategory.backgroundColor = [WebService colorWithHexString:@"#00afdf"];
            
            CGFloat iWidthLabel;
            CGSize stringSize = [category sizeWithFont:[UIFont systemFontOfSize:10]];
            
            iWidthLabel = stringSize.width+5;
            CGRect rectFrame = CGRectMake(cell.lblCategory.frame.origin.x, cell.lblCategory.frame.origin.y, iWidthLabel, cell.lblCategory.frame.size.height);
            
            [cell.lblCategory setTranslatesAutoresizingMaskIntoConstraints:YES];
            cell.lblCategory.frame = rectFrame;
            
            //segment
        }
        else
        {
            [cell.lblCategory setHidden:YES];
        }
        [cell.btnEmail addTarget:self action:@selector(openMailComposer) forControlEvents:UIControlEventTouchDown];
        [cell.btnCalling addTarget:self action:@selector(openCallingPad) forControlEvents:UIControlEventTouchDown];
        [cell.segment addTarget:self action:@selector(openView:) forControlEvents:UIControlEventValueChanged];
        [cell.showMap addTarget:self action:@selector(showMapLocationVC) forControlEvents:UIControlEventTouchDown];
        
        cell.btnEmail.tintColor = [WebService colorWithHexString:@"#00afdf"];
        cell.btnCalling.tintColor = [WebService colorWithHexString:@"#00afdf"];
        
        return cell;
    }
    /************************************End of Section 0 ***************************************/
    else
    {
        if(segmentIndex==0)
        {
            dic = [arrayServicesData objectAtIndex:indexPath.row];
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ServiceProviderServicesTVCell" owner:self options:nil];
            
            cell = [nib objectAtIndex:0];
            
            [NSUD setObject:[dic objectForKey:@"s_id"] forKey:@"s_id"];
            
            cell.lblServicesName.text = [dic valueForKey:@"s_name"];
            
            cell.lblCost.text = [NSString stringWithFormat:@"$%@",[dic valueForKey:@"s_cost"]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            cell.showBook.tag = indexPath.row;
            [cell.showBook addTarget:self action:@selector(showCustomerBookingVC:) forControlEvents:UIControlEventTouchDown];
            cell.showBook.tintColor = [WebService colorWithHexString:@"#00afdf"];
            
            return cell;
            
        }
        else if (segmentIndex==1)
        {
            NSMutableDictionary *dic = [NSMutableDictionary new];
            
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"RecommendationCell" owner:self options:nil];
            
            cell = [nib objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            dic = [arrayRecommendation objectAtIndex:indexPath.row];
            NSString *rating = [dic objectForKey:@"book_rating"];
            cell.viewRating.rating = [rating floatValue];
            cell.lblName.text = [dic objectForKey:@"u_fullname"];
            [cell.imageView1 setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"u_image"]] placeholderImage:[UIImage imageNamed:@"small_default_img"]];
            
            cell.lblFeedback.text = [dic objectForKey:@"book_feedback"];
            return cell;
        }
        else if (segmentIndex==2)
        {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"InfoCell" owner:self options:nil];
            
            cell = [nib objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.lbl_business_name.text = [providerDataDic valueForKey:@"pro_business_name"];
            cell.lbl_business_address.text = [providerDataDic valueForKey:@"pro_addr"];
            cell.lbl_business_role.text = [providerDataDic valueForKey:@"pro_role"];
            cell.lbl_business_email.text = [providerDataDic valueForKey:@"pro_email"];
            cell.lbl_business_mobile.text = [providerDataDic valueForKey:@"pro_mobile_no"];
            cell.lbl_business_website.text = [providerDataDic valueForKey:@"pro_website"];
            cell.lbl_business_state.text = [providerDataDic valueForKey:@"pro_state"];
            cell.lbl_business_zipcode.text = [providerDataDic valueForKey:@"pro_zipcode"];
            cell.lbl_business_other_notes.text = [providerDataDic valueForKey:@"pro_other_notes"];
            cell.lbl_business_cancel_policy.text = [providerDataDic valueForKey:@"pro_cancel_policy"];
            
            return cell;
        }
        else if (segmentIndex==3)
        {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"PortFolioCell" owner:self options:nil];
            
            cell = [nib objectAtIndex:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.collection_view.delegate = self;
            cell.collection_view.dataSource = self;
            
            [cell.collection_view registerNib:[UINib nibWithNibName:@"PortfolioCVCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
            
           //[cell.collection_view registerClass:[PortfolioCVCell class] forCellWithReuseIdentifier:@"CELL"];
            
            cell.collection_view.backgroundColor = [UIColor clearColor];
            [cell.collection_view reloadData];
            return cell;
        }
        
    }
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ServiceProviderDetailTVCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ServiceProviderDetailTVCell"];
    if (cell == nil) {
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"ServiceProviderDetailTVCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    if (indexPath.section==0) {
        
       CGFloat iHeight = [self height:providerDescription viewFrame:cell.lblDescription];
         cell.lblDescription.frame = CGRectMake(cell.lblDescription.frame.origin.x, cell.lblDescription.frame.origin.y, cell.frame.size.width,iHeight);
       cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height+iHeight-60);
        
        cell.lblDescription.lineBreakMode = NSLineBreakByWordWrapping;
        cell.lblDescription.numberOfLines = 0;
        [cell.lblDescription setNeedsDisplay];
        NSLog(@"Height %f",cell.frame.size.height);
        if (cell.frame.size.height>197) {
            return cell.frame.size.height;
        }
        else
            return 197;
        
    }else{
        if (segmentIndex==0) {
            return 60;
        }
        else if(segmentIndex==1)
        {
            return 82;
        }
        else if(segmentIndex==2)
        {
            return 309;
        }
        else if(segmentIndex==3)
        {
            return 300;
        }
        
    }
    return 0;
}

-(float)height :(NSString*)descriptionvalue viewFrame:(UILabel*)txtdescription{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:txtdescription.font.pointSize]};
    CGRect labelSize = [descriptionvalue boundingRectWithSize:CGSizeMake(txtdescription.frame.size.width, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return labelSize.size.height;
}

#pragma mark - Collection View Delegate Methods
#pragma mark -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrayPortfolio.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   NSDictionary *dic = [arrayPortfolio objectAtIndex:indexPath.row];

    PortfolioCVCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    
   // [cell.image_view setImage:[UIImage imageNamed:@"nails_art"]];
    
    NSString *pic_URLString = [dic valueForKey:@"pp_image"];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:pic_URLString] placeholderImage:[UIImage imageNamed:@"big_default_img.png"]];
    
     UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handelTapGestureRecognizer:)];
    
     tapGR.numberOfTapsRequired = 1;

     [cell.imageView addGestureRecognizer:tapGR];
    
    
   // cell.backgroundColor= [UIColor redColor];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(((collectionView.frame.size.width/2)-25), ((collectionView.frame.size.width/2)-25));
}

#pragma mark - Show Customer Booking
#pragma mark -

-(void)showCustomerBookingVC:(id)sender{
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
    dic1 = [arrayServicesData objectAtIndex:[sender tag]];
    [NSUD setValue:[dic1 valueForKey:@"s_name"] forKey:@"s_name"];
    [NSUD setValue:[dic1 valueForKey:@"s_cost"] forKey:@"s_cost"];
    [NSUD setValue:[providerDataDic valueForKey:@"pro_name"] forKey:@"pro_name"];
    [NSUD setValue:[providerDataDic valueForKey:@"pro_image"] forKey:@"pro_image"];
    CustomerBookingVC  *customerBookingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomerBookingVC"];
    
    [self.navigationController pushViewController:customerBookingVC animated:YES];
}

#pragma mark - Show View On Segment Click
#pragma mark -

-(void)openView:(UISegmentedControl *)sender
{
    NSLog(@"call");
    if (sender.selectedSegmentIndex==0) {
        segmentIndex = sender.selectedSegmentIndex;
    }
    else if (sender.selectedSegmentIndex==1)
    {
        segmentIndex = sender.selectedSegmentIndex;
    }
    else if (sender.selectedSegmentIndex==2)
    {
        segmentIndex = sender.selectedSegmentIndex;
    }
    else if (sender.selectedSegmentIndex==3)
    {
        segmentIndex = sender.selectedSegmentIndex;
    }
    NSIndexSet *sections = [[NSIndexSet alloc] initWithIndex:1];
    [self.tv reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Show Map Location
#pragma mark -

-(void)showMapLocationVC{
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[providerDataDic valueForKey:@"pro_lat"] forKey:@"pro_lat"];
    [dic setObject:[providerDataDic valueForKey:@"pro_long"] forKey:@"pro_long"];
    [dic setObject:[providerDataDic valueForKey:@"pro_addr"] forKey:@"pro_addr"];
    MapLocationVC  *mapLocationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MapLocationVC"];
    mapLocationVC.mapData = dic;

    [self.navigationController pushViewController:mapLocationVC animated:YES];

}

#pragma mark - Show Previous Screen
#pragma mark -

- (IBAction)back:(id)sender {
    ListOfServiceProviderVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListOfServiceProviderVC"];
    vc.serviceCategoryID = [_dataDic objectForKey:@"cat_id"];
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma  mark - Show / Hide Full Story Image
#pragma  mark -

-(void)handelTapGestureRecognizer:(UITapGestureRecognizer *)sender{
    
    UIImageView *imgView = (UIImageView *)sender.view;
    
    [UUImageAvatarBrowser showImageForZoomView:self withImage:imgView];

}



-(void)show_FullStoryImage:(UIButton *)sender{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0]; // if section is 0
    
    PortfolioCVCell *cell = (PortfolioCVCell*)[tv cellForRowAtIndexPath:indexPath];
    //[UUImageAvatarBrowser showImage:cell.imgView_Story];
    [UUImageAvatarBrowser showImageForZoomView:self withImage:cell.imageView];
    
}

#pragma mark - Open Calling Pad
#pragma mark -

-(void)openCallingPad
{
    NSString *mobile_no = [providerDataDic valueForKey:@"pro_mobile_no"];
    NSLog(@"Mobile no %@",mobile_no);
    
    NSString *phoneNumber = [@"tel://" stringByAppendingString:mobile_no];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

#pragma mark - Open Mail Composer
#pragma mark -

-(void)openMailComposer
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    NSString *email = [providerDataDic valueForKey:@"pro_email"];
    
    if ([email isEqualToString:@""]) {
        
       [picker setToRecipients:@[@""]];
        
     }else{
    
       [picker setToRecipients:@[email]];
        
    }
   // [picker setToRecipients:email];
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - MailComposer Delegate Methods
#pragma mark -

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

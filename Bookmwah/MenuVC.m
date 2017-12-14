//
//  Menu.m
//  Bookmwah
//
//  Created by admin on 23/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "MenuVC.h"
#import "Constant.h"
#import "MenuTableViewCell.h"
@interface MenuVC ()
{
    KYDrawerController *elDrawer;
    long count;
    
    MBProgressHUD *HUD;
    
}
@property (weak, nonatomic) IBOutlet UIButton *btn_logout;

@property (strong, nonatomic) IBOutlet UIImageView *img_LogOut;

@end

@implementation MenuVC

#pragma mark - View Lifecycle Methods
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
 
    elDrawer = (KYDrawerController*)self.navigationController.parentViewController;

    [self call_NotificationAPI];
    
    [self.tv registerClass:[MenuTableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    _tv.scrollEnabled = false;

}

-(void)viewDidAppear:(BOOL)animated
{
    //cell.img_LogOut.image =
     _img_LogOut.tintColor = [WebService colorWithHexString:@"B7B9B6"];
    _imgView.layer.cornerRadius = _imgView.frame.size.height/2;
    _imgView.layer.cornerRadius = _imgView.frame.size.width/2;
    _imgView.clipsToBounds = YES;
    _imgView.layer.borderColor = [WebService colorWithHexString:@"#00afdf"].CGColor;
    _imgView.layer.borderWidth = 1.0f;

}
-(void)viewWillAppear:(BOOL)animated
{
    [self setRightPanelValue];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setRightPanelValue
{
    _lblName.text = [NSUD valueForKey:@"u_fullname"];
    NSString *url = [NSUD valueForKey:@"u_image"];
    if ([[NSUD valueForKey:@"u_image"]isEqualToString:@""]) {
        _imgView.image = [UIImage imageNamed:@"big_default_img"];
    }
    else
    {
        [_imgView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"big_default_img"]];
    }
    
}



#pragma mark - call_NotificationAPI
#pragma mark -

-(void)call_NotificationAPI{
    
    NSString *user_id =[NSUD valueForKey:@"user_id"];
    NSLog(@"User id %@",user_id);
    NSMutableDictionary *user_dic = [NSMutableDictionary new];
    [user_dic setValue:user_id forKey:@"u_id"];
    
    
  [WebService call_API:user_dic andURL:API_NOTIFICATION_LIST andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status){
        if([[response valueForKey:@"status"] isEqualToString:@"true"])
        {
            notificationArray = [NSMutableArray new];
            notificationArray = [response valueForKey:@"notification"];
            count = notificationArray.count;
            [self.tv reloadData];
        }
        
    }];
    
}

#pragma mark - Tableview Delegate Methods
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSString *strUserType = [NSUD valueForKey:@"user_type"];
    
    NSLog(@"%@",strUserType);
    
    if([strUserType isEqual:@"1"]){
        
        return 9;
    }
    else{
        
       return 9;
        
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuTableViewCell *cell ;
    
    if(cell == nil)
    {
        cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    
    NSString *strUserType = [NSUD valueForKey:@"user_type"];
    
   // NSLog(@"%@",strUserType);
    
   if([strUserType isEqual:@"1"])
    {
        [_btn_logout setHidden:true];
    
     }

        if (indexPath.section==0) {
            cell = [_tv dequeueReusableCellWithIdentifier:@"home" forIndexPath:indexPath];
            return cell;
        }
        if (indexPath.section==1) {
            
            cell = [_tv dequeueReusableCellWithIdentifier:@"service" forIndexPath:indexPath];
            if([strUserType isEqual:@"2"]){
                
              [cell.btnService setTitle:@"List Your Business" forState:UIControlStateNormal];
                
            }
           
           // cell.lblService.titleLabel.text = @"List Your Business";
            
            return cell;
        }
        if (indexPath.section==2) {
            cell = [_tv dequeueReusableCellWithIdentifier:@"booking" forIndexPath:indexPath];
            return cell;
        }
        if (indexPath.section==3) {
            cell = [_tv dequeueReusableCellWithIdentifier:@"wallet" forIndexPath:indexPath];
            //cell.lblProfession.titleLabel.text = @"Professional";
            if([strUserType isEqual:@"2"]){
            
              [cell.btnProfession setTitle:@"Professional" forState:UIControlStateNormal];
                  
            }
           
            [cell.lblWallet setHidden:true];
                  
                  
            
           // [cell.lblWallet setHidden:true];
          //  cell.lblNotification.text = [NSString stringWithFormat:@"%lu",count];
            
            //        NSString *wallet = [NSUD valueForKey:@"u_wallet"];
            //        if ([wallet isEqualToString:@""]) {
            //            cell.lblWallet.text = @"$0";
            //        }
            //        else
            //        {
            //            cell.lblWallet.text = wallet;
            //        }
            return cell;
        }
        if (indexPath.section==4) {
            cell = [_tv dequeueReusableCellWithIdentifier:@"notification" forIndexPath:indexPath];
            
            if (count == 0) {
                
                [cell.lblNotification setHidden:true];
                
            }else{
                
               [cell.lblNotification setHidden:false];
                
               cell.lblNotification.text = [NSString stringWithFormat:@"%lu",count];
                
            }
            return cell;
        }
        if (indexPath.section==5) {
            cell = [_tv dequeueReusableCellWithIdentifier:@"terms" forIndexPath:indexPath];
            return cell;
        }
        if (indexPath.section==6) {
            cell = [_tv dequeueReusableCellWithIdentifier:@"privacy" forIndexPath:indexPath];
            return cell;
        }
        if (indexPath.section==7) {
            cell = [_tv dequeueReusableCellWithIdentifier:@"about" forIndexPath:indexPath];
            return cell;
        }
        if (indexPath.section==8) {
            cell = [_tv dequeueReusableCellWithIdentifier:@"email" forIndexPath:indexPath];
            return cell;
        }
        

   // }else{
        
//        if (indexPath.section==0) {
//            cell = [_tv dequeueReusableCellWithIdentifier:@"home" forIndexPath:indexPath];
//            return cell;
//        }
//        if (indexPath.section==1) {
//            cell = [_tv dequeueReusableCellWithIdentifier:@"service" forIndexPath:indexPath];
//              //cell.btnService.titleLabel.text = @"List Your Business";
//             [cell.btnService setTitle:@"List Your Business" forState:UIControlStateNormal];
//            return cell;
//        }
//        if (indexPath.section==2) {
//
//        }
//        
//        if (indexPath.section==3) {
//            cell = [_tv dequeueReusableCellWithIdentifier:@"wallet" forIndexPath:indexPath];
//            
//            [cell.btnProfession setTitle:@"Professional" forState:UIControlStateNormal];
//            
//            [cell.lblWallet setHidden:true];
//            
//            //cell.lblNotification.text = [NSString stringWithFormat:@"%lu",count];
//            
//            //        NSString *wallet = [NSUD valueForKey:@"u_wallet"];
//            //        if ([wallet isEqualToString:@""]) {
//            //            cell.lblWallet.text = @"$0";
//            //        }
//            //        else
//            //        {
//            //            cell.lblWallet.text = wallet;
//            //        }
//            return cell;
//        }
//
//        if (indexPath.section==4) {
//            cell = [_tv dequeueReusableCellWithIdentifier:@"notification" forIndexPath:indexPath];
//            cell.lblNotification.text = [NSString stringWithFormat:@"%lu",count];
//            return cell;
//        }
//        if (indexPath.section==5) {
//            cell = [_tv dequeueReusableCellWithIdentifier:@"terms" forIndexPath:indexPath];
//            return cell;
//        }
//        if (indexPath.section==6) {
//            cell = [_tv dequeueReusableCellWithIdentifier:@"privacy" forIndexPath:indexPath];
//            return cell;
//        }
//        if (indexPath.section==7) {
//            cell = [_tv dequeueReusableCellWithIdentifier:@"about" forIndexPath:indexPath];
//            return cell;
//        }
//        if (indexPath.section==8) {
//            cell = [_tv dequeueReusableCellWithIdentifier:@"email" forIndexPath:indexPath];
//            return cell;
//        }
//        
//    }
    
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *strUserType = [NSUD valueForKey:@"user_type"];
    
     NSLog(@"%@",strUserType);
    
    if([strUserType isEqual:@"1"]){
        
        if (indexPath.section==0) {
            
            TabBarVC *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
            
            UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:tabBarVC];
            
            [navController setNavigationBarHidden:YES];
            
            elDrawer.mainViewController=navController;
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            
        }
        
        if (indexPath.section==1) {
            
//            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
//            
//            ServiceProviderTabBarVC *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceProviderTabBarVC"];
//            
//            [self presentViewController:tabBarVC animated:NO completion:nil];
//            
//            [self.tabBarController setSelectedIndex:2];
//            [[ServiceProviderTabBarVC new] change_TabBar:2];
        }
        
        if (indexPath.section==2) {
            
          // [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
//            
         //  AppointmentsVC *tabBarVC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"AppointmentsVC"];
      
            
            TabBarVC *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
            
          //  [tabBarVC setSelectedViewController:tabBarVC1];
            
            [self.tabBarController setSelectedIndex:2];
            [[TabBarVC new] change_TabBar:1];
           // [self.tabBarController setSelectedIndex:1];
            //[tabBarVC setSelectedIndex:1];
            
//
//
//            
           // [self presentViewController:tabBarVC animated:NO completion:nil];
            
            UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:tabBarVC];
            
            [navController setNavigationBarHidden:YES];
            
            elDrawer.mainViewController=navController;
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            
            
        }
        
          if (indexPath.section==3) {
              
          }
        
        if (indexPath.section==4) {
            
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            
            NotificationsVC *notificationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsVC"];
            notificationVC.notificationArray =notificationArray;
            [self presentViewController:notificationVC animated:YES completion:nil];
            
        }
        if (indexPath.section==5) {
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            
            TermsVC *termsVC = (TermsVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"TermsVC"];
            
            [self presentViewController:termsVC animated:NO completion:^{
                
            }];
        }
        if (indexPath.section==6) {
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            
            PrivacyVC *privacyVC = (PrivacyVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyVC"];
            
            [self   presentViewController:privacyVC animated:NO completion:^{
                
            }];
        }
        if (indexPath.section==7) {
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            
            AboutUsVC *aboutVC = (AboutUsVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsVC"];
            
            [self   presentViewController:aboutVC animated:NO completion:^{
                
            }];
            
        }
        if (indexPath.section==8) {
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            
            
            
            if ([MFMailComposeViewController canSendMail] ) {
                EmailVC *emailVC = (EmailVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"EmailVC"];
                
                [self   presentViewController:emailVC animated:NO completion:^{
                    
                }];
                
            } else {
                
                 UIAlertView* curr2=[[UIAlertView alloc] initWithTitle:@"This app does not have Login with Account" message:@"You can Add Account from Settings->Mail,Contacts,Calender->Add Account->Google" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Settings", nil];
                
                
                [curr2 show];
                
            }
            
            /*MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
             picker.mailComposeDelegate = self;
             [picker setToRecipients:@[@"support@bookmwah.com"]];
             //[self presentViewController:picker animated:YES completion:nil];
             [self   presentViewController:picker animated:NO completion:^{
             
             }];*/
        }

        
    }else{
        
        if (indexPath.section==0) {
           
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            ServiceProviderTabBarVC *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceProviderTabBarVC"];
            
            [self presentViewController:tabBarVC animated:NO completion:nil];
            [self.tabBarController setSelectedIndex:0];
            [[ServiceProviderTabBarVC new] change_TabBar:0];
            
        }
  
        if (indexPath.section==1) {
            
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            ServiceProviderTabBarVC *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceProviderTabBarVC"];
            
          //
            
           // [self presentViewController:tabBarVC animated:NO completion:nil];
           //  [(UITabBarController*)self.navigationController.topViewController setSelectedIndex:2];
        
            [self.tabBarController setSelectedIndex:2];
            [[ServiceProviderTabBarVC new] change_TabBar:2];
            
            [self presentViewController:tabBarVC animated:NO completion:nil];
            
        }
        
        if (indexPath.section==2) {
        }
        
        if (indexPath.section==3) {
            
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            
            ServiceProviderTabBarVC *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceProviderTabBarVC"];
            
            [self presentViewController:tabBarVC animated:NO completion:nil];
            [self.tabBarController setSelectedIndex:0];
            [[ServiceProviderTabBarVC new] change_TabBar:0];
            
        }
        
        if (indexPath.section==4) {
            
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            
            NotificationsVC *notificationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationsVC"];
            notificationVC.notificationArray =notificationArray;
            [self presentViewController:notificationVC animated:YES completion:nil];
            
        }
        
        if (indexPath.section==5) {
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            
            TermsVC *termsVC = (TermsVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"TermsVC"];
            
            [self presentViewController:termsVC animated:NO completion:^{
                
            }];
        }
        
        if (indexPath.section==6) {
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            
            PrivacyVC *privacyVC = (PrivacyVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyVC"];
            
            [self   presentViewController:privacyVC animated:NO completion:^{
                
            }];
        }
        if (indexPath.section==7) {
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            
            AboutUsVC *aboutVC = (AboutUsVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsVC"];
            
            [self   presentViewController:aboutVC animated:NO completion:^{
                
            }];
            
        }
        if (indexPath.section==8) {
            [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            
            if ([MFMailComposeViewController canSendMail] ) {
                EmailVC *emailVC = (EmailVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"EmailVC"];
                
                [self   presentViewController:emailVC animated:NO completion:^{
                    
                }];
                
            } else {
                
                UIAlertView* curr2=[[UIAlertView alloc] initWithTitle:@"This app does not have Login with Account" message:@"You can Add Account from MKOver -> Settings -> Mail,Contacts,Calender -> Add Account -> Google" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Settings", nil];
                
                
                [curr2 show];
                
            }

      }
        
        if (indexPath.section==9) {
          //  [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
            
//            EmailVC *emailVC = (EmailVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"EmailVC"];
//            
//            [self   presentViewController:emailVC animated:NO completion:^{
//                
//            }];
            
        }

        
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   // if (alertView.tag == 121 && buttonIndex == 1)
    
    if (buttonIndex == 1)
    {
        //code for opening settings app in iOS 8
       // [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString]];
    
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
        NSLog(@"%@",UIApplicationOpenSettingsURLString);
    
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strUserType = [NSUD valueForKey:@"user_type"];
    
    //switch (indexPath.section)
   // if ([[NSUD valueForKey:@"pro_id"] isEqualToString:@""])
        
    if([strUserType isEqual:@"1"]){
    
    if (indexPath.section == 0) {
         return 44;
    }
    
    if (indexPath.section == 1) {
        return 0;
    }
    
    if (indexPath.section == 2) {
        return 44;
    }
    
    if (indexPath.section == 3) {
        return 0;
    }
    
    if (indexPath.section == 4) {
        return 44;
    }
    
    if (indexPath.section == 5) {
        return 44;
    }
    
    if (indexPath.section == 6) {
        return 44;
    }
    
    if (indexPath.section == 7) {
        return 44;
    }
    if (indexPath.section == 8) {
        return 44;
    }
        
  
    
    }else{
    
    if (indexPath.section == 0) {
        return 44;
    }
    
    if (indexPath.section == 1) {
        return 44;
    }
    
    if (indexPath.section == 2) {
        return 0;
    }
    
    if (indexPath.section == 3) {
        return 44;
    }
    
    if (indexPath.section == 4) {
        return 44;
    }
    
    if (indexPath.section == 5) {
        return 44;
    }
    
    if (indexPath.section == 6) {
        return 44;
    }
    
    if (indexPath.section == 7) {
        return 44;
     }
//    
    if (indexPath.section == 8) {
        return 44;
    }
        
    }
    
//    {
//        case 0:
//            
//            return 44;
//            
//         case 1:
//            
//            //if ([[NSUD valueForKey:@"pro_id"] isEqualToString:@""]) {  by rd
//            if([[NSUD valueForKey:@"pro_id"] isEqual:nil] || [strUserType isEqual:@"1"])
//            {
//                return 44;
//            }
//            
//            else
//            {
//                return 0;
//           }
//            
//        case 2:
//            
//            if([strUserType isEqual:@"1"])
//            {
//                return 0;
//            }
//            
//            else
//            {
//                return 44;
//            }
//            
//            
//            //  return 44;
//            
//        case 3:
//            
//            if([strUserType isEqual:@"1"])
//            {
//                return 0;
//            }
//            
//            else
//            {
//                return 44;
//            }
//
//        case 4:
//            
//           return 44;
//            
//        case 5:
//            
//            return 44;
//            
//        case 6:
//            
//            return 44;
//            
//        case 7:
//            
//            return 44;
//            
//        case 8:
//            
//            return 44;
//            
//    }
    return 0;
}

#pragma mark - MailComposer Delegate Methods

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)edit_btn:(id)sender {
    
    [elDrawer setDrawerState:KYDrawerControllerDrawerStateClosed animated:YES];
    
    AccountInfo *accountVC = (AccountInfo *) [self.storyboard instantiateViewControllerWithIdentifier:@"AccountInfo"];
    
    [self presentViewController:accountVC animated:NO completion:^{
    }];
}

#pragma mark - call_LogOutAPI
#pragma mark -
- (IBAction)action_Logoutt:(id)sender {
//}
//-(void)call_LogOutAPI{
    
    [HUD show:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    NSString *u_id = [NSUD valueForKey:@"user_id"];
    
    [dict setValue: u_id forKey:@"user_id"];
    
    [WebService call_API:dict andURL:API_LogOut andImage:nil andImageName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status){
        
        //[WebService call_API:nil andURL:API_LogOut andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status){
        
        [NSUD setValue:@"5" forKey:@"IS_LOGIN"];
        
        [NSUD removeObjectForKey:@"user_type"];
        
        [NSUD synchronize];
        
        SignInVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInVC"];
        [self presentViewController:vc animated:NO completion:nil];
        
        
        [HUD hide:YES];
        
    }];
    
}

@end

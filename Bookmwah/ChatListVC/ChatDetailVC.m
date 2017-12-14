//
//  Menu.m
//  Bookmwah
//
//  Created by admin on 23/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "ChatDetailVC.h"
#import "Constant.h"
#import "ChatDetailTableViewCell.h"
#import "SWNinePatchImageFactory.h"


@interface ChatDetailVC ()
{
    
    MBProgressHUD *HUD;
    ChatDetailTableViewCell *cell;
    NSString *receive_id;
    UIImage *image;
    
}

@end

@implementation ChatDetailVC
@synthesize textView;
#pragma mark - View Lifecycle Methods
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tv.rowHeight = UITableViewAutomaticDimension;
    _tv.estimatedRowHeight = 80;
    
  //  [_userImage setImage:[UIImage imageNamed:_strUserImg]];
    
    [_userImage setImageWithURL:[NSURL URLWithString:_strUserImg] placeholderImage:[UIImage imageNamed:@"service_provider_icon"]];
    
    _userName.text = _strUserName;
    
    [self call_ChatAPI];
 
   // [self call_ChatMessageAPI];
    
}

-(void)viewDidAppear:(BOOL)animated
{
   
}
-(void)viewWillAppear:(BOOL)animated
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - call_ChatAPI
#pragma mark -

-(void)call_ChatAPI{
    
    [HUD show:YES];
    
    NSString *user_id =[NSUD valueForKey:@"user_id"];
    NSLog(@"User id %@",user_id);
    
    NSString *user_type = [NSUD valueForKey:@"user_type"];
    
    if ([user_type  isEqual: @"2"]) {
        
        receive_id = [NSUD valueForKey:@"u_id"];
        NSLog(@"receive_id %@",receive_id);
        
    }else{
        
        receive_id  = [NSUD valueForKey:@"pro_u_id"];
        NSLog(@"receive_id %@",receive_id);
        
    }
    
   
    
    NSMutableDictionary *user_dic = [NSMutableDictionary new];
    [user_dic setValue:user_id forKey:@"sender_id"];
    [user_dic setValue:receive_id forKey:@"receive_id"];
    
    NSLog(@"%@",user_dic);
    
    //[WebService call_API:user_dic andURL:API_CHAT_LIST andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status){
    
    [WebService call_API:user_dic andURL:API_CHAT_LIST andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
        
        if([[response valueForKey:@"status"] isEqualToString:@"true"])
        {
            
            NSLog(@"%@",response);
            
            notificationArray = [NSMutableArray new];
            notificationArray = [response valueForKey:@"records"];
            //count = notificationArray.count;
            [self.tv reloadData];
            [HUD hide:YES];
        }else{
            
            NSString *strMsg = [response objectForKey:@"message"];
            
            if ([strMsg  isEqual: @"There is no data"]) {
                
                
            }else{
            
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
                
            }
          [HUD hide:YES];
        }
        
    }];
    
}



#pragma mark - call_ChatMessageAPI
#pragma mark -

-(void)call_ChatMessageAPI{
    
    [HUD show:YES];
    
    NSString *user_id =[NSUD valueForKey:@"user_id"];
    NSLog(@"User id %@",user_id);
    
    NSString *user_type = [NSUD valueForKey:@"user_type"];
    
    if ([user_type  isEqual: @"2"]) {
        
        receive_id = [NSUD valueForKey:@"u_id"];
        NSLog(@"receive_id %@",receive_id);
        
    }else{
        
        receive_id  = [NSUD valueForKey:@"pro_u_id"];
        NSLog(@"receive_id %@",receive_id);
        
    }

//    NSString *receive_id =[NSUD valueForKey:@"u_id"];
//    NSLog(@"receive_id %@",receive_id);
    
    NSMutableDictionary *user_dic = [NSMutableDictionary new];
    //[user_dic setValue:receive_id forKey:@"sender_id"];
    //[user_dic setValue:user_id forKey:@"receive_id"];
    [user_dic setValue:textView.text forKey:@"message"];
    
    [user_dic setValue:user_id forKey:@"sender_id"];
    [user_dic setValue:receive_id forKey:@"receive_id"];
    
    NSLog(@"%@",user_dic);
    
  [WebService call_API:user_dic andURL:API_Send_Chat_Message andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status){
      
      
        if([[response valueForKey:@"status"] isEqualToString:@"true"])
        {
            NSLog(@"%@",response);
            
            [self call_ChatAPI];
            textView.text = @"";
            
            [HUD hide:YES];
            
        }else{
            
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
            
            [HUD hide:YES];
            
        }
        
    }];
    
}

#pragma mark - Tableview Delegate Methods
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
        return 1;
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return notificationArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cell";
    static NSString *customCellIdentifier = @"cell1";
    
    
    NSDictionary * dicMsg = [notificationArray objectAtIndex:indexPath.row];
  
    NSString *user_id =[NSUD valueForKey:@"user_id"];
    
    NSString *Sender_id = [dicMsg valueForKey:@"sender_id"];
    
    if ([user_id isEqualToString:Sender_id]) {
        
     
        cell = (ChatDetailTableViewCell*)[_tv dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        cell.lblLeftMsg.text = [dicMsg valueForKey:@"message"];
        cell.lblLeftMsg.textColor = [UIColor blackColor];
        
        UIImage* resizableImage = [SWNinePatchImageFactory createResizableNinePatchImageNamed:@"comment_box.9"];
        [cell.imgLeft setImage:resizableImage];
        
       // cell.chatView.frame = cell.lblLeftMsg.frame;
       // cell.chatViewWidth.constant = [cell.lblLeftMsg.text.length + 10];
       // cell.chatView.frame.size.width = cell.lblLeftMsg.frame.size.width;
        
        
    }else{
        
        cell = (ChatDetailTableViewCell*)[_tv dequeueReusableCellWithIdentifier:customCellIdentifier forIndexPath:indexPath];
            
        cell.lblRightMsg.text = [dicMsg valueForKey:@"message"];
        cell.lblRightMsg.textColor = [UIColor blackColor];
        
        UIImage* resizableImage = [SWNinePatchImageFactory createResizableNinePatchImageNamed:@"right_chat.9"];
        [cell.imgRight setImage:resizableImage];
        
    }

    return cell;
    
}


//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 80;
//}



-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   // - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
   // {
       // tableView.estimatedRowHeight = 80;
    return UITableViewAutomaticDimension;
   // }
    
}



- (IBAction)btn_Send:(id)sender {
    
    if (textView.text.length == 0) {
       
        _AlertView_WithOut_Delegate(@"Warning!", @"Please Enter Message", @"OK", nil);
        
    }else{
        
        [self call_ChatMessageAPI];
        
    }
    
}


- (IBAction)Back_btn:(id)sender {
    
     [self dismissViewControllerAnimated:NO completion:nil];
    
   }


- (IBAction)btn_Attachment:(id)sender {
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
   // img.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end

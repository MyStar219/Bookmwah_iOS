//
//  Menu.m
//  Bookmwah
//
//  Created by admin on 23/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "ChatListVC.h"
#import "Constant.h"
#import "ChatListTableViewCell.h"
#import "ChatDetailVC.h"

@interface ChatListVC ()
{
    
    MBProgressHUD *HUD;
    
}

@end

@implementation ChatListVC

#pragma mark - View Lifecycle Methods
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self call_ChatAPI];
    
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
    
    NSString *user_id =[NSUD valueForKey:@"user_id"];
    NSLog(@"User id %@",user_id);
    
    NSString *receive_id =[NSUD valueForKey:@"u_id"];
    NSLog(@"receive_id %@",receive_id);
    
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
        }else{
            
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
            
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

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatListTableViewCell *cell ;
    
    cell = [_tv dequeueReusableCellWithIdentifier:@"chatcell" forIndexPath:indexPath];
    

    NSDictionary *dict = [notificationArray objectAtIndex:indexPath.row];
    
    cell.lblMsg.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"message"]];
    cell.lblDate.text = [NSString stringWithFormat:@"%@",[dict valueForKey:@"datetime"]];
    
    [cell.lblDate sizeToFit];
    
     cell.lblName.text = @"Megon Troy";
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   ChatDetailVC *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatDetailVC"];
    NSDictionary *dict = [notificationArray objectAtIndex:indexPath.row];
    //tabBarVC.dic = dict;
  //  notificationArray
    [self presentViewController:tabBarVC animated:NO completion:nil];
    
    
}


- (IBAction)Back_btn:(id)sender {
    
     [self dismissViewControllerAnimated:NO completion:nil];
    
   }

@end

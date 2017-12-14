//
//  NotificationsVC.m
//  Bookmwah
//
//  Created by admin on 04/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "NotificationsVC.h"

@interface NotificationsVC ()
{
    NSString *btnName;
}


@end

@implementation NotificationsVC

@synthesize arrayData,tv;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_notificationArray!=nil) {
        NSLog(@"data");
        [self.tv reloadData];
    }
    else
    {
        NSLog(@"nil");
    }

}

-(void)viewDidAppear:(BOOL)animated
{
    btnName = @"Cancel";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _notificationArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSString *cellIdentifier = @"NotificationsTVCell";
    
    NotificationsTVCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NotificationsTVCell" owner:self options:nil];
    
    cell = [nib objectAtIndex:0];
    
    NSMutableDictionary *dic = [_notificationArray objectAtIndex:indexPath.row];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.img setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"u_image"]] placeholderImage:[UIImage imageNamed:@"small_default_img"]];
    cell.lbl_Name.text =[dic valueForKey:@"u_fullname"];
    cell.lbl_BookingTime.text = [dic valueForKey:@"book_time"];
    cell.lbl_ServiceType.text = [dic valueForKey:@"s_name"];
    if ([[dic valueForKey:@"noti_msg"] isEqualToString:@"Your booking has been accepted"]) {
        cell.lblMessage.textColor = [WebService colorWithHexString:@"#26ac4c"];
    }
    else
    {
        cell.lblMessage.textColor = [WebService colorWithHexString:@"#ef2e2e"];
    }
    cell.lblMessage.text = [dic valueForKey:@"noti_msg"];
    cell.btn_cancel.tag = indexPath.row;
    [cell.btn_cancel addTarget:self action:@selector(callMethods) forControlEvents:UIControlEventTouchDown];
    
    return cell;
}



/*
 {
 "book_date" = "15-06-2016";
 "book_id" = 14;
 "book_time" = "11:51 am";
 "noti_id" = 26;
 "noti_msg" = "Your booking has been accepted";
 "noti_status" = 2;
 "s_cat_name" = "Hair Cut Specialists";
 "s_name" = "Hair styler";
 "u_fullname" = "Tushar Thorat";
 "u_image" = "http://expertteam.in/bookmwah/uploads/user_image/14658239381465823918.831937.jpeg";
 }
 */
-(void)callMethods{
    if ([btnName isEqualToString:@"Cancel"]) {
        [self cancel];
    }
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancel
{
    NSLog(@"Cancel ");
}
@end

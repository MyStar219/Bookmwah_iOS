//
//  AppointmentsVC.m
//  Bookmwah
//
//  Created by Developer on 13/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "AppointmentsVC.h"
#import "Constant.h"

@interface AppointmentsVC ()
{
    ListCell *dropDowncell;
    NSString *btnName;
}
@end

@implementation AppointmentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = [NSMutableArray new];
    listArray = [NSMutableArray new];

    
//    [self initializeTableArray];
    [self call_AppointmentDetailsAPI];
    
    [_btnUpcoming addTarget:self action:@selector(changeList:) forControlEvents:UIControlEventTouchDown];
    
    [_btnCompleted addTarget:self action:@selector(changeList:) forControlEvents:UIControlEventTouchDown];
    [_dropDownTV setHidden:true];
    _txtReview.contentInset = UIEdgeInsetsMake(0,8,0,0);
    _starRating.maxRating = 5;
    _starRating.rating = 0;
    _starRating.canEdit = YES;
    
    isShow = @"true";
}

-(void)viewDidAppear:(BOOL)animated
{
    btnName = @"Cancel";
    [_rateView setHidden:true];
    _txtReview.text = @"Write your review...";
    _txtReview.layer.borderColor = [WebService colorWithHexString:@"#ebebeb"].CGColor;
    _txtReview.layer.borderWidth = 1.0f;
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

#pragma mark - Textview Delegate Methods
#pragma mark -

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Write your review..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        textView.text = @"Write your review...";
        textView.textColor = [WebService colorWithHexString:@"#dddddd"];
    }
    [textView resignFirstResponder];
}

#pragma mark - call_AppointmentDetails_API
#pragma mark -

-(void)call_AppointmentDetailsAPI{
    [HUD show:YES];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSLog(@"user id %@",[NSUD objectForKey:@"user_id"]);
    [dict setObject:[NSUD objectForKey:@"user_id"] forKey:@"user_id"];
   // [dict setObject:@"13" forKey:@"user_id"];

    [WebService call_API:dict andURL:API_APPOINTMENTS andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {

        
        [HUD hide:YES];
        dataArray = [response valueForKey:@"appointments"];
        NSArray *array  = [NSArray arrayWithArray:dataArray];
        NSSet *set = [NSSet setWithArray:[array valueForKey:@"s_cat_name"]];
        count = [[NSCountedSet alloc] initWithArray:[array valueForKey:@"s_cat_name"]];
        listArray = [NSMutableArray arrayWithArray:[set allObjects]];
        NSLog(@" data %@",dataArray);
        NSLog(@"%@",listArray);
        [_dropDownTV reloadData];
        [_tableView reloadData];
    }];
    
}

#pragma mark - Upcoming & Completed Method
#pragma mark -
-(void)changeList:(UIButton *)button
{
    if(button.tag==1)
    {
        [_btnUpcoming setBackgroundColor:[WebService colorWithHexString:@"#00afdf"]];
        [_btnUpcoming setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnCompleted setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnCompleted setBackgroundColor:[WebService colorWithHexString:@"#f6f6f6"]];
        isFilter = false;
        btnName = @"Cancel";
        [self.tableView reloadData];
    }
    else if(button.tag==2)
    {
        [_btnUpcoming setBackgroundColor:[WebService colorWithHexString:@"#f6f6f6"]];
        [_btnUpcoming setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnCompleted setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnCompleted setBackgroundColor:[WebService colorWithHexString:@"#00afdf"]];//BB1538
        isFilter = true;
        btnName = @"Rate";
        [self filterContentForList:@"Completed" WithKey:@"status"];
    }
}

#pragma mark - Content Filtering
#pragma mark -

-(void)filterContentForSearchText:(NSString*)searchText WithKey :(NSString *)key{
    
    [tvArray removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.%@ contains %@",key,searchText];
    tvArray = [NSMutableArray arrayWithArray:[dataArray filteredArrayUsingPredicate:predicate]];
    isFilter = false;
    [_tableView reloadData];
}

-(void)filterContentForList:(NSString *)value WithKey :(NSString *)key
{
    
    [newFilterArray removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.%@ contains %@",key,value];
    newFilterArray = [NSMutableArray arrayWithArray:[tvArray filteredArrayUsingPredicate:predicate]];
    [_tableView reloadData];
}

#pragma mark - Tableview Delegate
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_dropDownTV) {
        return listArray.count;
    }
    if (isFilter)
        return newFilterArray.count;
    else
        return tvArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_dropDownTV) {
        UINib *nib = [UINib nibWithNibName:@"ListCell" bundle:nil];
        [self.dropDownTV registerNib:nib forCellReuseIdentifier:@"list"];
        dropDowncell = [_dropDownTV dequeueReusableCellWithIdentifier:@"list" forIndexPath:indexPath];
        dropDowncell.lblWork.text = [listArray objectAtIndex:indexPath.row];
        NSUInteger *total = [count countForObject:[listArray objectAtIndex:indexPath.row]];
        dropDowncell.lblCount.text= [NSString stringWithFormat:@"%lu", (unsigned long)total];
        if (_dropDownTV.tag==indexPath.row) {
            [dropDowncell.btnCheck setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
            [self filterContentForSearchText:dropDowncell.lblWork.text WithKey:@"s_cat_name"];
            strWork = dropDowncell.lblWork.text;
        }
        else
        {
            [dropDowncell.btnCheck setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        return dropDowncell;
    }
    else
    {
        NSMutableDictionary *dic;
        UINib *nib = [UINib nibWithNibName:@"BookingCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:@"booking"];
        BookingCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"booking" forIndexPath:indexPath];
        
        if (isFilter) {
            dic = [newFilterArray objectAtIndex:indexPath.row];
        }
        else{
            dic = [tvArray objectAtIndex:indexPath.row];
        }
        if ([btnName isEqualToString:@"Cancel"]) {
            [cell.btnCancel setTitle:btnName forState:UIControlStateNormal];
            [cell.lblRating setHidden:true];
            [cell.imageRating setHidden:true];
            [cell.btnCancel setHidden:false];
        }
        else if ([btnName isEqualToString:@"Rate"])
        {
            if (![[dic objectForKey:@"book_rating"] isEqualToString:@""]) {
                [cell.imageRating setHidden:false];
                cell.lblRating.text = [dic objectForKey:@"book_rating"];
                [cell.btnCancel setHidden:true];
                [cell.lblRating setHidden:false];
            }
            else
            {
                [cell.btnCancel setTitle:btnName forState:UIControlStateNormal];
                [cell.lblRating setHidden:true];
                [cell.imageRating setHidden:true];
            }
            
        }
        [cell.btnCancel addTarget:self action:@selector(callMethods) forControlEvents:UIControlEventTouchUpInside];
        
        cell.lblName.text = [dic objectForKey:@"pro_name"];
        cell.lblType.text = [dic objectForKey:@"s_cat_name"];
        cell.lblTime.text = [NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"book_date"],[dic objectForKey:@"book_time"]];
        
        cell.btnChat.tag = indexPath.row ;
        [cell.btnChat addTarget:self action:@selector(action_chat:) forControlEvents:UIControlEventTouchUpInside];
        
        NSURL *url = [NSURL URLWithString:[dic objectForKey:@"pro_image"]];
        [cell.personImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"small_default_img"]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_dropDownTV)
        return 26;
    else
        return 87;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_dropDownTV) {
        _dropDownTV.tag=indexPath.row;
        [_dropDownTV reloadData];
        [_dropDownTV setHidden:true ];
    }
    if (tableView==self.tableView) {
        [_dropDownTV setHidden:true];
        isShow = @"true";
        NSLog(@"call");
    }

}

#pragma mark - Open Dropdown List View
#pragma mark -

- (IBAction)filter:(id)sender {
    if ([isShow isEqualToString:@"true"]) {
        [_dropDownTV setHidden:false];
        isShow = @"false";
    }
    else
    {
        [_dropDownTV setHidden:true];
        isShow = @"true";
    }
}


-(void)action_chat:(UIButton *)btn
{
    NSMutableDictionary *dic;
    if (isFilter) {
        dic = [newFilterArray objectAtIndex:btn.tag];
    }
    else{
        dic = [tvArray objectAtIndex:btn.tag];
    }
    
  //  NSArray *sectionRows = [_aryFinalSameDate  objectAtIndex:btn.tag];
    
    ChatDetailVC *Chat = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatDetailVC"];
    
    NSString *imgURL = [dic objectForKey:@"pro_image"];
    
    NSString *strName = [dic objectForKey:@"pro_name"];
    
    [NSUD setObject:[dic objectForKey:@"pro_u_id"] forKey:@"pro_u_id"];
   
    
    Chat.strUserImg = imgURL;
    Chat.strUserName = strName;
    //Chat.userDetail = sectionRows;
    [self presentViewController:Chat animated:NO completion:nil];
    
    // ChatVC
    
}

#pragma mark - Call cancelBooking/rateBooking Methods
#pragma mark -

-(void)callMethods{
    if ([btnName isEqualToString:@"Cancel"]) {
        [self cancelBookings];
    }
    else if ([btnName isEqualToString:@"Rate"]){
        [self rateBookings];
    }
}

#pragma mark - Cancel Bookings
#pragma mark -

-(void)cancelBookings
{
    NSLog(@"Cancel Bookings");
}

#pragma mark - Rate Person
#pragma mark -

-(void)rateBookings{
    [_rateView setHidden:false];
}

#pragma mark - Set Ratings & Review
#pragma mark -

- (IBAction)rateAction:(id)sender {
    NSLog(@"%f",_starRating.rating);
    [_rateView setHidden:true];
}
@end

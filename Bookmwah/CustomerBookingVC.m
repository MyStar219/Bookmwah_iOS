//
//  CustomerBookingVC.m
//  Bookmwah
//
//  Created by admin on 24/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "CustomerBookingVC.h"

@interface CustomerBookingVC ()
{
    IBOutlet UIView *vw_Search;
    IBOutlet UITableView *tbl_Search;
    NSMutableArray *arr;
    IBOutlet UITextField *txt_Search;
//    IBOutlet UITextView *txt_Address;
    int int_Provider;
}
@end

@implementation CustomerBookingVC
@synthesize lblName,lblCharges,lblServiceType,img,viewDatePicker,datePicker,timePicker,btnDone,btnCancel,datepicker,timepicker,shView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    int_Provider = 1;
    
    //Round Image
    img.layer.cornerRadius = img.frame.size.height/2;
    img.layer.cornerRadius = img.frame.size.width/2;
    img.clipsToBounds=YES;
    
    lblName.text = [NSUD valueForKey:@"pro_name"];
    
    lblServiceType.text = [NSUD valueForKey:@"s_name"];
    
    lblCharges.text = [NSString stringWithFormat:@"$%@",[NSUD valueForKey:@"s_cost"]];
    NSURL *url = [NSURL URLWithString:[NSUD valueForKey:@"pro_image"]];
    [img setImageWithURL:url placeholderImage:[UIImage imageNamed:@"big_default_img"]];
    
    _txtAddress.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    _txtAddress.layer.borderWidth = 1.0f;
    _txtAddress.textColor = [WebService colorWithHexString:@"777777"];
    timepicker.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    self.timepicker.layer.borderWidth = 1.0;

    datepicker.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    
    self.datepicker.layer.borderWidth = 1.0;
    
    [shView setHidden:true];
    
    _txtAddress.textContainerInset = UIEdgeInsetsMake(10, 30, 0, 20);

    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(on_Address:)];
    tap.numberOfTapsRequired = 1;
    [_txtAddress addGestureRecognizer:tap];
    tbl_Search.delegate = self;
    tbl_Search.dataSource = self;
    [self load_MBProgressHUD];
    
    defaults = [NSUserDefaults standardUserDefaults];

}

-(void)load_MBProgressHUD
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading...";
    //HUD.detailsLabelText = @"Pdf..";
    HUD.square = YES;
    [self.view addSubview:HUD];
    
}


#pragma mark - Validation
#pragma mark -
-(BOOL)validation
{
    if ([datepicker.titleLabel.text isEqualToString:@"dd/mm/yyyy"]) {
        _AlertView_WithOut_Delegate(@"Message", @"Please select date", @"OK", nil);
        return NO;
    }
    else if ([timepicker.titleLabel.text isEqualToString:@"hh:mm:a"])
    {
        _AlertView_WithOut_Delegate(@"Message", @"Please select time", @"OK", nil);
        return NO;
    }
    return YES;
}

#pragma mark - call_BookingAPI
#pragma mark - 

-(void)call_BookingAPI{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    
    [dict setValue:_txtAddress.text forKey:@"addr"];
    NSString *u_id = [NSUD valueForKey:@"user_id"];
    NSString *s_id = [NSUD valueForKey:@"s_id"];
    
    [dict setValue:timepicker.titleLabel.text forKey:@"time"];
    [dict setValue:datepicker.titleLabel.text forKey:@"date"];

    [dict setValue:[NSUD valueForKey:@"s_cost"] forKey:@"amount"];
    [dict setValue:[NSString stringWithFormat:@"%d",int_Provider] forKey:@"house_call"];
    [dict setValue:u_id forKey:@"user_id"];
    [dict setValue:s_id forKey:@"s_id"];
    
    PaymentVC *paymentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PaymentVC"];
    paymentVC.booking_details = dict;
    [self.navigationController pushViewController:paymentVC animated:NO];
    
}

- (IBAction)btnPayment:(id)sender {
    
    if ([self validation]) {
        [self call_BookingAPI];
    }
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Done:(id)sender {
    
    if (btnDone.tag==1) {
        NSDate *dat= datePicker.date;
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"dd-MM-yyyy"];
        date =[formatter stringFromDate:dat];
        NSLog(@"%@",date);
        [datepicker setTitle:date forState:UIControlStateNormal];
    }else if (btnDone.tag==2) {
        NSDate *tim= timePicker.date;
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"hh:mm a"];
        time = [formatter stringFromDate:tim];
        NSLog(@"%@",time);
        [timepicker setTitle:time forState:UIControlStateNormal];
    }
    [shView setHidden:true];
}

- (IBAction)Cancel:(id)sender {
    [shView setHidden:true];
}

- (IBAction)btnDatePicker:(id)sender {
    btnDone.tag = 1;
    [shView setHidden:false];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setMinimumDate: [NSDate date]];
    _datePickerTitle.text = @"Choose Date";
}

- (IBAction)btnTimePicker:(id)sender {
    btnDone.tag = 2;
    [shView setHidden:false];
    [timePicker setDatePickerMode:UIDatePickerModeTime];
    _datePickerTitle.text = @"Choose Time";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [tbl_Search setTableFooterView:[UIView new]];
    
    vw_Search.translatesAutoresizingMaskIntoConstraints = YES;
    
    vw_Search.frame=CGRectMake(0,1024, vw_Search.frame.size.width, vw_Search.frame.size.height);
    
    vw_Search.hidden = false;
    
}

-(void)on_Address:(id )gesture{
    
    arr = [[NSMutableArray alloc]init];
    
    [tbl_Search reloadData];
    
    txt_Search.text = @"";
    
    //   txt_Search.tag = [sender tag];
    
    [UIView animateWithDuration:.5 animations:^{
        
        vw_Search.frame=CGRectMake(0,0, vw_Search.frame.size.width, vw_Search.frame.size.height);
        
    }completion:^(BOOL finished) {
        
    }];
    
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
    tap.cancelsTouchesInView = NO;
}

-(IBAction)on_SelectProvider:(id)sender{
    if (int_Provider == 1) {
        int_Provider = 2;
        [btnRadio_Home setImage:[UIImage imageNamed:@"active_radio"] forState:UIControlStateNormal];
        [btnRadio_Sercice setImage:[UIImage imageNamed:@"inactive_radio"] forState:UIControlStateNormal];
    }else{
        int_Provider =1;
        [btnRadio_Sercice setImage:[UIImage imageNamed:@"active_radio"] forState:UIControlStateNormal];
        [btnRadio_Home setImage:[UIImage imageNamed:@"inactive_radio"] forState:UIControlStateNormal];
    }
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
    //[Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    Cell.textLabel.font =[UIFont systemFontOfSize:12];
//    tap.cancelsTouchesInView = NO;

    return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dict = [arr objectAtIndex:indexPath.row];
    _txtAddress.text=[dict objectForKey:@"formatted_address"];
    [self on_cancel_search:self];

}



@end

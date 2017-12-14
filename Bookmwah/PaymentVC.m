//
//  PaymentVC.m
//  Bookmwah
//
//  Created by admin on 03/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "PaymentVC.h"

// Identifiers of components
#define MONTH ( 0 )
#define YEAR ( 1 )
#define CreditCard ( 16 )
#define CAVV ( 4 )
// Identifies for component views
#define LABEL_TAG 43

@interface PaymentVC ()
{
    NSString *userName,*data;
    NSString *strmonth;
    NSString *stryear;
}


@property (nonatomic, strong) NSIndexPath *todayIndexPath;
@property (nonatomic, strong) NSArray *months;
@property (nonatomic, strong) NSArray *years;

-(NSArray *)nameOfYears;
-(NSArray *)nameOfMonths;
-(CGFloat)componentWidth;

-(UILabel *)labelForComponent:(NSInteger)component selected:(BOOL)selected;
-(NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component;
-(NSIndexPath *)todayPath;
-(NSInteger)bigRowMonthCount;
-(NSInteger)bigRowYearCount;
-(NSString *)currentMonthName;
-(NSString *)currentYearName;
@end

@implementation PaymentVC

const NSInteger mnMonth = 01;
const NSInteger mxMonth = 12;
const NSInteger bigRowCont = 1000;
const NSInteger mnYear = 2008;
const NSInteger mxYear = 2030;
const CGFloat rowHeigh = 44.f;
const NSInteger numberOfComponent = 2;

@synthesize tv;

#pragma mark - View Delegate Methods
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayWalletBal = [[NSMutableArray alloc]initWithObjects:@" ", nil];
    arrayRegisteredCard = [[NSMutableArray alloc]init];
    [self call_GetCardListAPI];
    arrayAddNewCard = [[NSMutableArray alloc]initWithObjects:@" ", nil];
    [tv setTableFooterView:[UIView new]];
    defaults = [NSUserDefaults standardUserDefaults];
    
    [self changeBorderColor];
    [self changePlaceholderColor];
    [self paddingoOfPlaceholder];
    [_background_view setHidden:YES];
    [_btnExpiry addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchDown];
    
    _datePicker.dataSource = self;
    _datePicker.delegate = self;
    if (_booking_details!=nil) {
        NSLog(@"data");
    }
    else
    {
        NSLog(@"nil");
    }
    [_txt_card_holder_name addTarget:self
                        action:@selector(textFieldDidChange:)
              forControlEvents:UIControlEventEditingChanged];
    [_txt_card_number addTarget:self
                              action:@selector(textFieldDidChange:)
                    forControlEvents:UIControlEventEditingChanged];
    [_txt_expiry_date addTarget:self
                              action:@selector(textFieldDidChange:)
                    forControlEvents:UIControlEventEditingChanged];
    [_txt_cavv addTarget:self
                              action:@selector(textFieldDidChange:)
                    forControlEvents:UIControlEventEditingChanged];

}

#pragma mark - changeBorderColor
#pragma mark -

-(void)changeBorderColor
{
    _txt_card_holder_name.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    _txt_card_holder_name.layer.borderWidth = 1.0f;
    
    _txt_expiry_date.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    _txt_expiry_date.layer.borderWidth = 1.0f;
    
    _txt_cavv.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    _txt_cavv.layer.borderWidth = 1.0f;
    
    _txt_expiry_date.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    _txt_expiry_date.layer.borderWidth = 1.0f;
}

-(void)changePlaceholderColor
{
    // txtCardHolderName.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Card Holder Name"attributes:[WebService colorWithHexString:@"eeeeee"]];
    _txt_card_holder_name.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Card Holder Name"attributes:@{NSForegroundColorAttributeName:[WebService colorWithHexString:@"777777"]}];
    
    _txt_card_number.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Card Number"attributes:@{NSForegroundColorAttributeName:[WebService colorWithHexString:@"777777"]}];
    
    _txt_expiry_date.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Expiry Date"attributes:@{NSForegroundColorAttributeName:[WebService colorWithHexString:@"777777"]}];
    
    _txt_cavv.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"CVV"attributes:@{NSForegroundColorAttributeName:[WebService colorWithHexString:@"777777"]}];
    
    //  UIColor  *bgcolor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    
}

-(void)paddingoOfPlaceholder{
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 10, _txt_card_holder_name.frame.size.height)];
    _txt_card_holder_name.leftView = paddingView1;
    _txt_card_holder_name.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 10, _txt_card_number.frame.size.height)];
    _txt_card_number.leftView = paddingView2;
    _txt_card_number.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 10, _txt_expiry_date.frame.size.height)];
    _txt_expiry_date.leftView = paddingView3;
    _txt_expiry_date.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 10, _txt_cavv.frame.size.height)];
    _txt_cavv.leftView = paddingView4;
    _txt_cavv.leftViewMode = UITextFieldViewModeAlways;
    
    
}

#pragma mark - Textfield Text Change Methods
#pragma mark -

-(void)textFieldDidChange:(UITextField *)textfield
{
    if (_txt_card_holder_name.text.length==0&&_txt_card_number.text.length==0&&_txt_expiry_date.text.length==0&&_txt_cavv.text.length==0) {
        isCreateNewCard=false;
    }
    else
    {
        isCreateNewCard = true;
    }
}

#pragma  mark -  show date and year in dabit card.
#pragma  mark -

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.months = [self nameOfMonths];
    self.years = [self nameOfYears];
    self.todayIndexPath = [self todayPath];
    
    //    self.delegate = self;
    //    self.dataSource = self;
    
    // [self selectToday];
}

-(NSDate *)date
{
    NSInteger monthCount = [self.months count];
    NSString *month = [self.months objectAtIndex:([_datePicker selectedRowInComponent:MONTH] % monthCount)];
    
    NSLog(@"%@",month);
    strmonth = month;
    
    NSInteger yearCount = [self.years count];
    NSString *year = [self.years objectAtIndex:([_datePicker selectedRowInComponent:YEAR] % yearCount)];
    stryear = year;
    NSLog(@"%@",year);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; [formatter setDateFormat:@"MMMM:yyyy"];
    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@:%@", month, year]];
    NSLog(@"%@",date);
    return date;
}

#pragma mark - UIPickerViewDelegate
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return [self componentWidth];
}

-(UIView *)pickerView: (UIPickerView *)pickerView
           viewForRow: (NSInteger)row
         forComponent: (NSInteger)component
          reusingView: (UIView *)view
{
    BOOL selected = NO;
    if(component == MONTH)
    {
        NSInteger monthCount = [self.months count];
        NSString *monthName = [self.months objectAtIndex:(row % monthCount)];
        NSString *currentMonthName = [self currentMonthName];
        if([monthName isEqualToString:currentMonthName] == YES)
        {
            selected = YES;
        }
    }
    else
    {
        NSInteger yearCount = [self.years count];
        NSString *yearName = [self.years objectAtIndex:(row % yearCount)];
        NSString *currenrYearName  = [self currentYearName];
        if([yearName isEqualToString:currenrYearName] == YES)
        {
            selected = YES;
        }
    }
    
    UILabel *returnView = nil;
    if(view.tag == LABEL_TAG)
    {
        returnView = (UILabel *)view;
    }
    else
    {
        returnView = [self labelForComponent: component selected: selected];
    }
    
    returnView.textColor = selected ? [UIColor blueColor] : [UIColor blackColor];
    returnView.text = [self titleForRow:row forComponent:component];
    return returnView;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return rowHeigh;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return numberOfComponent;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == MONTH)
    {
        return [self bigRowMonthCount];
    }
    return [self bigRowYearCount];
}

#pragma mark - Util
-(NSInteger)bigRowMonthCount
{
    return [self.months count]  * bigRowCont;
}

-(NSInteger)bigRowYearCount
{
    return [self.years count]  * bigRowCont;
}

-(CGFloat)componentWidth
{
    return 320 / numberOfComponent;
}

-(NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == MONTH)
    {
        NSInteger monthCount = [self.months count];
        
        // [_btn_Year setTitle:_months forState:UIControlStateNormal];
        
        return [self.months objectAtIndex:(row % monthCount)];
    }
    NSInteger yearCount = [self.years count];
    return [self.years objectAtIndex:(row % yearCount)];
    //  [_btn_Year setTitle:_months forState:UIControlStateNormal];
}

-(UILabel *)labelForComponent:(NSInteger)component selected:(BOOL)selected
{
    CGRect frame = CGRectMake(0.f, 0.f, [self componentWidth],rowHeigh);
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = selected ? [UIColor blueColor] : [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:18.f];
    label.userInteractionEnabled = NO;
    
    label.tag = LABEL_TAG;
    
    return label;
}

-(NSArray *)nameOfMonths
{
    NSMutableArray *monthList = [NSMutableArray array];
    for (NSInteger month = mnMonth; month<=mxMonth; month++) {
        if (month<=9) {
            NSString *monthStr = [NSString stringWithFormat:@"%ld",month];
            [monthList addObject:monthStr];
        }
        else
        {
            NSString *monthStr = [NSString stringWithFormat:@"%ld",month];
            [monthList addObject:monthStr];
        }
        
    }
    return monthList;
}

-(NSArray *)nameOfYears
{
    NSMutableArray *years = [NSMutableArray array];
    
    for(NSInteger year = mnYear; year <= mxYear; year++)
    {
        NSString *yearStr = [NSString stringWithFormat:@"%ld", year];
        [years addObject:yearStr];
    }
    return years;
}

-(NSIndexPath *)todayPath // row - month ; section - year
{
    CGFloat row = 0.f;
    CGFloat section = 0.f;
    
    NSString *month = [self currentMonthName];
    NSString *year  = [self currentYearName];
    
    //set table on the middle
    for(NSString *cellMonth in self.months)
    {
        if([cellMonth isEqualToString:month])
        {
            row = [self.months indexOfObject:cellMonth];
            row = row + [self bigRowMonthCount] / 2;
            break;
        }
    }
    
    for(NSString *cellYear in self.years)
    {
        if([cellYear isEqualToString:year])
        {
            section = [self.years indexOfObject:cellYear];
            section = section + [self bigRowYearCount] / 2;
            break;
        }
    }
    
    return [NSIndexPath indexPathForRow:row inSection:section];
}

-(NSString *)currentMonthName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    return [formatter stringFromDate:[NSDate date]];
}

-(NSString *)currentYearName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    return [formatter stringFromDate:[NSDate date]];
}

-(void)load_MBProgressHUD
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading...";
    //HUD.detailsLabelText = @"Pdf..";
    HUD.square = YES;
    [self.view addSubview:HUD];
    
}

#pragma mark - call_PaymentAPI
#pragma mark -

-(void)call_PaymentAPI{
    
    [HUD show:YES];
    [_booking_details setValue:_txt_card_holder_name.text forKey:@"card_holder_name"];
    [_booking_details setValue:_txt_card_number.text forKey:@"card_number"];
    [_booking_details setValue:_txt_expiry_date.text forKey:@"expiry_date"];
    [_booking_details setValue:_txt_cavv.text forKey:@"card_cvv"];
    NSLog(@"Booking Details %@",_booking_details);
    
    [WebService call_API:_booking_details andURL:API_BOOKING andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {

        
        [HUD hide:YES];

        _AlertView_WithOut_Delegate(@"message", [response objectForKey:@"message"], @"ok", nil);
        self.tabBarController.selectedIndex = 0;
    }];

}
#pragma mark - call_GetCardListAPI
#pragma mark -

-(void)call_GetCardListAPI{
    
    [HUD show:YES];
    NSString *user_id = [_booking_details valueForKey:@"user_id"];
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:user_id forKey:@"user_id"];
    
    [WebService call_API:dict andURL:API_GET_CARD_LIST andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
        
        [HUD hide:YES];
        if ([[response objectForKey:@"status"] isEqualToString:@"true"]) {
            
        }
        arrayRegisteredCard = [response objectForKey:@"credit_cards"];

        NSLog(@"Array registerted %@",arrayRegisteredCard);
        [tv reloadData];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    switch (textField.tag) {
        case 100:
            userName = textField.text;
            break;
        default:
            break;
    }
    return YES;
}

#pragma mark - Tableview Delegate Methods
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section==0){
        
        return arrayWalletBal.count;
        
    }if(section==1){
        
        return  arrayRegisteredCard.count;
        
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = @"itemCell ";
    
    PaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSDictionary *dic = [NSDictionary new];
    
    if(indexPath.section==0){
        
        dic = [arrayWalletBal objectAtIndex:indexPath.row];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WalletBalanceCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        cell.lblWalletBal.text  = [dic valueForKey:@"lblWalletBal"];
        
       return cell;
        
    }if(indexPath.section==1) {
        
        dic = [arrayRegisteredCard objectAtIndex:indexPath.row];
        
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"RegisteredCardsCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lblRegisteredCardNo.text = [dic valueForKey:@"card_number"];
 
        return cell;
        
    }

    
    return nil;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    
    if (section==1) {
        
        // Create label with section title
        UILabel *registeredCards = [[UILabel alloc] init];
        registeredCards.frame = CGRectMake(50, 9, 100, 21);
        registeredCards.textColor = [UIColor blackColor];
        registeredCards.font = [UIFont fontWithName:@"Corbel" size:14];
        registeredCards.text = @"Registered Cards";
        registeredCards.backgroundColor = [UIColor clearColor];
        
        // Create Image
        UIImageView *img =[[UIImageView alloc] initWithFrame:CGRectMake(20,9,20,20)];
        img.image=[UIImage imageNamed:@"card_icon"]; [self.view addSubview:img];
        
        
        
        // Create header view and add label as a subview
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        [view setBackgroundColor:[WebService colorWithHexString:@"#eeeeee"]];
        [view addSubview:registeredCards];
        [view addSubview:img];
        return view;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        return 45;
        
    }if (indexPath.section==1) {
        
        return 35;
    }
         return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 35;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - Validation
#pragma mark -

-(BOOL)validation
{
    if (isCreateNewCard)
    {
        if (_txt_card_holder_name.text.length==0) {
            _AlertView_WithOut_Delegate(@"Message", @"Please enter card holder name", @"OK", nil);
            return NO;
        }
        else if(_txt_card_number.text.length==0)
        {
            _AlertView_WithOut_Delegate(@"Message", @"Please enter card number", @"OK", nil);
            return NO;
        }
        else if(!(_txt_card_number.text.length==CreditCard))
        {
            _AlertView_WithOut_Delegate(@"Message", @"Please enter valid card number", @"OK", nil);
            return NO;
        }
        
        else if([_txt_expiry_date.text isEqualToString:@""])
        {
            _AlertView_WithOut_Delegate(@"Message", @"Please select expiry date", @"OK", nil);
            return NO;
        }
        else if(_txt_cavv.text.length==0)
        {
            _AlertView_WithOut_Delegate(@"Message", @"Please enter cavv number", @"OK", nil);
            return NO;
        }
        else if(!(_txt_cavv.text.length==CAVV))
        {
            _AlertView_WithOut_Delegate(@"Message", @"Please enter valid cavv number", @"OK", nil);
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - confirm Booking
#pragma mark -

- (IBAction)confirm_booking:(id)sender {
    
    if([self validation])
    {
        [self call_PaymentAPI];
    }
    else
    {
        NSLog(@"Incorrect");
    }
}

-(void)showPicker
{
    [_background_view setHidden:NO];
}

- (IBAction)done:(id)sender {
    [_background_view setHidden:YES];
    [self date];
    _txt_expiry_date.text = [NSString stringWithFormat:@"%@/%@",strmonth,stryear];
}

- (IBAction)cancel:(id)sender {
    [_background_view setHidden:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

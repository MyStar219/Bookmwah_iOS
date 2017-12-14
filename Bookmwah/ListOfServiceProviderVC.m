//
//  ListOfServiceProviderVC.m
//  Bookmwah
//
//  Created by Developer on 13/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "ListOfServiceProviderVC.h"

@interface ListOfServiceProviderVC ()

@end

@implementation ListOfServiceProviderVC

@synthesize tv,txtSearch;

- (void)viewDidLoad {
    [super viewDidLoad];
 
    txtSearch.delegate = self;
    arrayTVData = [NSMutableArray new];
        [_houseCallView setHidden:true];
    isShow = @"true";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
   
   


}
-(void)viewDidAppear:(BOOL)animated
{
    // self.tabBarController.selectedIndex = 2;
    
    _serviceCategoryID =  [NSUD valueForKey:@"SELECT_CAT_ID"];
    
    if (![_serviceCategoryID isEqualToString:@"nil"]) {
        
        
        [self load_MBProgressHUD];
        [self call_ServiceProviderAPI];
        
    }else{
        
        [self call_AllServiceProviderAPI];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSNotificationCenter Methods
#pragma mark - 

- (void)keyboardDidShow: (NSNotification *) notif{
    tap = [[UITapGestureRecognizer alloc]
           initWithTarget:self
           action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];}

- (void)keyboardDidHide: (NSNotification *) notif{
    // Do something here
    [tap setEnabled:false];
}

#pragma mark - UITapGesture Method
#pragma mark -

- (void) dismissKeyboard {
    [self.view endEditing:YES];
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

#pragma mark - call_ServiceProviderAPI
#pragma mark -

-(void)call_ServiceProviderAPI{
    
    [HUD show:YES];
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:_serviceCategoryID forKey:@"cat_id"];
    
      [WebService call_API:dic andURL:API_SERVICE_PROVIDERS andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status){
        
        [HUD hide:YES];
        arrayTVData = [response objectForKey:@"providers"];
        btnIndex = 0;
        [tv reloadData];
    }];
    
}

#pragma mark - call_AllServiceProviderAPI
#pragma mark -
-(void)call_AllServiceProviderAPI{
    
    [HUD show:YES];
    
   // WebService *api = [[WebService alloc] init];
    
     [WebService call_API:nil andURL:API_ALL_PROVIDERS andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status){
        
        [HUD hide:YES];
        arrayTVData = [response objectForKey:@"providers"];
        NSLog(@"Response %@",response);
        btnIndex = 0;
        [tv reloadData];
    }];
    
}

#pragma mark - UISearchBar Delegate Methods
#pragma mark -

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length==0) {
        
        [searchBar resignFirstResponder];

        isFilter = false;
        [self.tv reloadData];
    }
    else
    {
        isFilter = true;
        filterData = [NSMutableArray new];
        [self filterContentForSearchText:searchText];
        [tv reloadData];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
}


-(void)removeTxtSearchObject:(NSString *)object{
    
    [self.txtSearch resignFirstResponder];

}


-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    return true;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
     [searchBar resignFirstResponder];
}

#pragma mark - Content Filtering
#pragma mark -

-(void)filterContentForSearchText:(NSString*)searchText{
    
    [filterData removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.pro_name contains[c] %@",searchText];
    filterData = [NSMutableArray arrayWithArray:[arrayTVData filteredArrayUsingPredicate:predicate]];
}

#pragma mark - Tableview Delegate Methods
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isFilter)
        return filterData.count;
    else
        return arrayTVData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *dic ;
    
    if (isFilter){
        dic = [filterData objectAtIndex:indexPath.row];
    }
    else{
        dic = [arrayTVData objectAtIndex:indexPath.row];
    }
    
    NSString *cellIdentifier = @"itemCell ";
    
    ListOfServiceProviderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ListOfServiceProviderCell" owner:self options:nil];
    
    cell = [nib objectAtIndex:0];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.lblName.text  = [dic valueForKey:@"pro_name"];
    NSURL *url = [NSURL URLWithString:[dic valueForKey:@"pro_image"] ];
    
    [cell.img setImageWithURL:url placeholderImage:[UIImage imageNamed:@"small_default_img"]];

    cell.btnNext.tag = indexPath.row;
    [cell.btnNext addTarget:self action:@selector(showProviderDetails:) forControlEvents:UIControlEventTouchDown];
    cell.ratView.rating = [[dic valueForKey:@"pro_rating"] floatValue];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_houseCallView setHidden:true];
    isShow = @"true";
    
    NSMutableDictionary *dic;
    if (isFilter) {
        dic = [filterData objectAtIndex:indexPath.row];
    }
    else
    {
        dic = [arrayTVData objectAtIndex:indexPath.row];
    }
    [self.view endEditing:YES];
    NSMutableDictionary *data = [NSMutableDictionary new];
    [data setObject:[dic objectForKey:@"pro_id"] forKey:@"pro_id"];
    [data setObject:@"1" forKey:@"type"];
    if (_serviceCategoryID!=nil) {
        [data setObject:_serviceCategoryID forKey:@"cat_id"];
    }
    ServiceProviderDetailVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceProviderDetailVC"];
    vc.dataDic = data;
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - Show ProviderDetailsView Controller
#pragma mark -

-(void)showProviderDetails :(id)sender
{
    NSMutableDictionary *dic;
    if (isFilter) {
        dic = [filterData objectAtIndex:[sender tag]];
    }
    else
    {
        dic = [arrayTVData objectAtIndex:[sender tag]];
    }
    [self.view endEditing:YES];
    NSMutableDictionary *data = [NSMutableDictionary new];
    [data setObject:[dic objectForKey:@"pro_id"] forKey:@"pro_id"];
    [data setObject:@"1" forKey:@"type"];
    if (_serviceCategoryID!=nil) {
        [data setObject:_serviceCategoryID forKey:@"cat_id"];
    }
    ServiceProviderDetailVC * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceProviderDetailVC"];
    vc.dataDic = data;
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - House Call Action
#pragma mark 

- (IBAction)houseCallAction:(UIButton *)sender {
    [_houseCallView setHidden:true];
    isShow = @"true";
    if ([sender tag]==1) {
        isFilter =true;
        sender.tag = 2;
        [sender setTitleColor:[WebService colorWithHexString:@"#00afdf"] forState:UIControlStateNormal];
        [self filterContentForList:@"1" WithKey:@"pro_house_call"];
    }
    else
    {
        isFilter =false;
        sender.tag = 1;
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.tv reloadData];
    }
    
}

-(void)filterContentForList:(NSString *)value WithKey :(NSString *)key
{
    [filterData removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.%@ contains %@",key,value];
    filterData = [NSMutableArray arrayWithArray:[arrayTVData filteredArrayUsingPredicate:predicate]];
    [self.tv reloadData];
}

#pragma mark - Show House Call View
#pragma mark - 

- (IBAction)showHouseCallView:(id)sender {
    if ([isShow isEqualToString:@"true"]) {
        [_houseCallView setHidden:false];
        isShow = @"false";
    }
    else
    {
        [_houseCallView setHidden:true];
        isShow = @"true";
    }
}

@end

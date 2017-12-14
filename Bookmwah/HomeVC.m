//
//  HomeVC.m
//  Bookmwah
//
//  Created by Developer on 13/05/16.
//  Copyright © 2016 Mahesh Kumar ;. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

#pragma mark - View Lifecycle Methods
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar.delegate = self;
    [self load_MBProgressHUD];
    [self call_ServiceCategoryAPI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
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

#pragma mark - call_ServiceCategoryAPI
#pragma mark -

-(void)call_ServiceCategoryAPI{
    
    [HUD show:YES];
    
    [WebService call_API:nil andURL:API_SERVICE_CATEGORY andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status){
        [HUD hide:YES];
        collectionArray = [response objectForKey:@"service_category"];
        NSLog(@"%@",collectionArray);
        [_collectionView reloadData];
    }];
    
}

#pragma mark - Search Bar Delegate Methods
#pragma mark -

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchText);
    if (searchText.length==0) {
        [self.view endEditing:YES];
        isFilter = false;
        [self.collectionView reloadData];
    }
    else
    {
        isFilter = YES;
        filterArray = [NSMutableArray new];
        [self filterContentForSearchText:searchText];
        [self.collectionView reloadData];

    }//end if-else
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
}

-(void)removeTxtSearchObject:(NSString *)object{
    
    [self.searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) aSearchBar {
    [_searchBar resignFirstResponder];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - Content Filtering
#pragma mark -

-(void)filterContentForSearchText:(NSString*)searchText{
    
    [filterArray removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.s_cat_name contains[c] %@",searchText];
    filterArray = [NSMutableArray arrayWithArray:[collectionArray filteredArrayUsingPredicate:predicate]];
}

#pragma mark - Collection View Delegate Methods
#pragma mark - 

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (isFilter) {
        return filterArray.count;
    }
    else
        return collectionArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dic1;
    
    if (isFilter) {
        dic1 = [filterArray objectAtIndex:indexPath.row];
    }
    else
    {
        dic1 = [collectionArray objectAtIndex:indexPath.row];
    }
    
    HomeVCCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"grid" forIndexPath:indexPath];
    cell.lblTitle.text = [dic1 objectForKey:@"s_cat_name"];

    NSURL *url = [NSURL URLWithString:[dic1 objectForKey:@"s_cat_image"]];

    [cell.imgView setImageWithURL:url placeholderImage:nil];

    return cell;
}




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSMutableDictionary *dic1 = [NSMutableDictionary new];
    
    if (isFilter) {
        dic1 = [filterArray objectAtIndex:indexPath.row];
    }
    else
    {
        dic1 = [collectionArray objectAtIndex:indexPath.row];
    }
    [self.view endEditing:YES];

    [NSUD setObject:[dic1 objectForKey:@"s_cat_id"] forKey:@"SELECT_CAT_ID"];
    [NSUD synchronize];
    
   // [self.tabBarController.delegate tabBarController:self.tabBarController shouldSelectViewController:[[self.tabBarItem viewControllers] objectAtIndex:2]];

    [self.tabBarController setSelectedIndex:2];
    [[TabBarVC new] change_TabBar:2];

   // self.tabBarController.selectedViewController=[self.tabBarController.viewControllers objectAtIndex:2];//or whichever index you want

   // [self.navigationController pushViewController:vc animated:NO];
//    [self.tabBarController setSelectedIndex:2];
//    TabBarVC *tabVC=[TabBarVC new];
//    tabVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
//    tabVC.selectedIndex = 2;
    //[self presentViewController:tabVC animated:NO completion:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE_4_OR_LESS) {
        return CGSizeMake(collectionView.frame.size.width/2-1, 159.f);
    }else if (IS_IPHONE_5) {
        return CGSizeMake(collectionView.frame.size.width/2-1, 159.f);
    }else if (IS_IPHONE_6) {
        return CGSizeMake(collectionView.frame.size.width/2-1, 187.f);
    }else if (IS_IPHONE_6P) {
        return CGSizeMake(collectionView.frame.size.width/2-1, 206.5f);
    }
    return CGSizeMake(collectionView.frame.size.width/2-1, 206.5f);
}

@end

//
//  ListOfServiceProviderVC.h
//  Bookmwah
//
//  Created by Developer on 13/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListOfServiceProviderCell.h"
#import "Constant.h"

@interface ListOfServiceProviderVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate>{
    
    NSMutableArray *arrayTVData,*filterData;
    BOOL isFilter;
    MBProgressHUD *HUD;
    NSString *isShow;
    long btnIndex;
    UITapGestureRecognizer *tap;

}

@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (weak, nonatomic) IBOutlet UISearchBar *txtSearch;
@property NSString *serviceCategoryID;

- (IBAction)showHouseCallView:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *houseCallView;
- (IBAction)houseCallAction:(id)sender;

@end

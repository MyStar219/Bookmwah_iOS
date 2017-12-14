//
//  ServiceProviderDetailVC.h
//  Bookmwah
//
//  Created by admin on 18/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface ServiceProviderDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,MFMailComposeViewControllerDelegate>{
    NSMutableArray *arrayServicesData,*arrayRecommendation,*filterArray,*arrayPortfolio;
    NSMutableDictionary *providerDataDic;
    NSString *providerDescription;
    MBProgressHUD *HUD;
    long segmentIndex;

}
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property NSMutableDictionary * dataDic;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *portfolioCV;

@end

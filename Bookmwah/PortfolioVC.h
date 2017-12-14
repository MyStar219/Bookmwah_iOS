//
//  PortfolioVC.h
//  Bookmwah
//
//  Created by admin on 21/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface PortfolioVC : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
    NSMutableArray *images;
    NSMutableArray *portfolioArray;
    int index;
    MBProgressHUD *HUD;

}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (void)showServices:(id)sender;
- (void)showRecommdation:(id)sender;
- (void)showInfo:(id)sender;
- (void)showPortfolio:(id)sender;
- (void)showBankDetails:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnServices;
@property (weak, nonatomic) IBOutlet UIButton *btnRecommendation;
@property (weak, nonatomic) IBOutlet UIButton *btnInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnPortfolio;
@property (weak, nonatomic) IBOutlet UIButton *btnBankDetails;

@end

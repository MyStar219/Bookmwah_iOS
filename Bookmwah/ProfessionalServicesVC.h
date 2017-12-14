//
//  ProfessionalServicesVC.h
//  Bookmwah
//
//  Created by admin on 20/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "ProfessionalServicesTVCell.h"
@interface ProfessionalServicesVC : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *arrayTVData;
    NSMutableArray *arrayPopUp;
    MBProgressHUD *HUD;
    NSUserDefaults *defaults;
    
   
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *sv;
@property (weak, nonatomic) IBOutlet UIView *viewShadow;
@property (weak, nonatomic) IBOutlet UITableView *tv;

@property (weak, nonatomic) IBOutlet UIButton *btnPopup;

@property (weak, nonatomic) IBOutlet UITableView *tvPopUp;

@property (weak, nonatomic) IBOutlet UIButton *btnServices;
@property (weak, nonatomic) IBOutlet UIButton *btnRecommendation;
@property (weak, nonatomic) IBOutlet UIButton *btnInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnPortfolio;
@property (weak, nonatomic) IBOutlet UIButton *btnBankDetails;
- (IBAction)Services:(id)sender;
- (IBAction)Recommendation:(id)sender;
- (IBAction)Info:(id)sender;
- (IBAction)Portfolio:(id)sender;
- (IBAction)BankDetails:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *svBtn;


@end

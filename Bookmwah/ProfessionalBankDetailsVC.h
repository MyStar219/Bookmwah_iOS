//
//  ProfessionalBankDetailsVC.h
//  Bookmwah
//
//  Created by admin on 09/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface ProfessionalBankDetailsVC : UIViewController{
    
    MBProgressHUD *HUD;
    NSUserDefaults *defaults;
    
    NSMutableArray *array;
}
@property (weak, nonatomic) IBOutlet UITextField *txtHolderName;
@property (weak, nonatomic) IBOutlet UITextField *txtBankName;
@property (weak, nonatomic) IBOutlet UITextField *txtAccNo;

- (IBAction)Save:(id)sender;
- (IBAction)Cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *svBtn;

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

@end

//
//  AppointmentsVC.h
//  Bookmwah
//
//  Created by Developer on 13/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface AppointmentsVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    NSMutableArray *dataArray,*tvArray,*listArray,*newFilterArray;
    NSCountedSet *count;
    BOOL isFilter;
    MBProgressHUD *HUD;
    NSString *strWork,*isShow;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnUpcoming;
@property (weak, nonatomic) IBOutlet UIButton *btnCompleted;
@property (weak, nonatomic) IBOutlet UITableView *dropDownTV;
- (IBAction)filter:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *rateView;
- (IBAction)rateAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtReview;
@property (weak, nonatomic) IBOutlet ASStarRatingView *starRating;

@end
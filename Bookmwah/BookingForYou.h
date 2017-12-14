//
//  BookingForYou.h
//  Bookmwah
//
//  Created by admin on 10/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookingForYouCell.h"
#import "Constant.h"

@interface BookingForYou : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property BookingForYouCell *booking;
@property (weak, nonatomic) IBOutlet UITableView *table_view;
@property NSMutableDictionary *dictRespon;
@property NSMutableArray *arrybooking;
@property NSSet *set;
@property NSMutableArray *aryFinalSameDate;
@property NSMutableArray *aryCellIndex;
- (IBAction)back:(id)sender;
@property NSUInteger table_section;
@end

//
//  NotificationsVC.h
//  Bookmwah
//
//  Created by admin on 04/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "NotificationsTVCell.h"

@interface NotificationsVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property NSMutableArray *arrayData;
@property NSMutableArray *notificationArray;


@property (weak, nonatomic) IBOutlet UITableView *tv;

@end

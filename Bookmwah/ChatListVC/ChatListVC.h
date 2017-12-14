//
//  Menu.h
//  Bookmwah
//
//  Created by admin on 23/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"


@interface ChatListVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary *dic ;
    NSMutableArray *notificationArray;
}
//@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITableView *tv;

- (IBAction)Back_btn:(id)sender;
//@property (weak, nonatomic) IBOutlet UILabel *lblName;

@end

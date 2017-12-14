//
//  MenuTableViewCell.h
//  Bookmwah
//
//  Created by admin on 24/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblWallet;
@property (weak, nonatomic) IBOutlet UILabel *lblNotification;

@property (weak, nonatomic) IBOutlet UIButton *btnService;

@property (weak, nonatomic) IBOutlet UIButton *btnProfession;

@end

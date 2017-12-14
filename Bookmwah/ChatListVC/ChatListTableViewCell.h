//
//  MenuTableViewCell.h
//  Bookmwah
//
//  Created by admin on 24/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@property (weak, nonatomic) IBOutlet UIImageView *User_img;

@end

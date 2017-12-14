//
//  ProfessionalServicesTVCell.h
//  Bookmwah
//
//  Created by admin on 20/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfessionalServicesTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblServices;
@property (weak, nonatomic) IBOutlet UILabel *lblCost;

@property (weak, nonatomic) IBOutlet UIButton *showPopUp;
@property (weak, nonatomic) IBOutlet UIButton *showSave;
@property (weak, nonatomic) IBOutlet UIButton *showCancel;




@end

//
//  PaymentCell.h
//  Bookmwah
//
//  Created by admin on 03/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblWalletBal;

@property (weak, nonatomic) IBOutlet UILabel *lblRegisteredCardNo;

@property (weak, nonatomic) IBOutlet UITextField *txtCardHolderName;
@property (weak, nonatomic) IBOutlet UITextField *txtCardName;
@property (weak, nonatomic) IBOutlet UITextField *txtDate;
@property (weak, nonatomic) IBOutlet UITextField *txtCAVV;

@property (weak, nonatomic) IBOutlet UIButton *btnCBooking;
@property (weak, nonatomic) IBOutlet UIButton *selectionImage;

@end

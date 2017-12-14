

//
//  DiscountVC.h
//  Bookmwah
//
//  Created by admin on 21/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface DiscountVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UITextField *txtTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtRate;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;
- (IBAction)btnPublish:(id)sender;
- (IBAction)btnCancel:(id)sender;
- (IBAction)btnBack:(id)sender;

@end

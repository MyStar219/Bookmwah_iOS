//
// ListOfServiceProviderCell.h
//  Bookmwah
//
//  Created by admin on 17/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Constant.h"
#import "ASStarRatingView.h"

@interface ListOfServiceProviderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet ASStarRatingView *ratView;
@end

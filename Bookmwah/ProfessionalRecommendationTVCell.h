//
//  ProfessionalRecommendationTVCell.h
//  Bookmwah
//
//  Created by admin on 10/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface ProfessionalRecommendationTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet ASStarRatingView *ratView;
@property (weak, nonatomic) IBOutlet UILabel *lblLike;

@end

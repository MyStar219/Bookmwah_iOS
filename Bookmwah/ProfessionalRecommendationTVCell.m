//
//  ProfessionalRecommendationTVCell.m
//  Bookmwah
//
//  Created by admin on 10/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "ProfessionalRecommendationTVCell.h"

@implementation ProfessionalRecommendationTVCell
@synthesize img,lblName,lblLike,ratView;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    img.layer.cornerRadius = img.layer.frame.size.width/2;
    img.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

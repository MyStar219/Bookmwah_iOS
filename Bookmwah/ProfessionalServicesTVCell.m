//
//  ProfessionalServicesTVCell.m
//  Bookmwah
//
//  Created by admin on 20/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "ProfessionalServicesTVCell.h"

@implementation ProfessionalServicesTVCell
@synthesize lblServices,lblCost,showPopUp,showSave,showCancel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    showPopUp.layer.cornerRadius = 5;
    showPopUp.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end

//
//  ListOfServiceProviderCell.m
//  Bookmwah
//
//  Created by admin on 17/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "ListOfServiceProviderCell.h"

@implementation ListOfServiceProviderCell

@synthesize lblName,img,ratView;


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //Round Image
    img.layer.cornerRadius = img.frame.size.height/2;
    img.layer.cornerRadius = img.frame.size.width/2;
    img.clipsToBounds=YES;
    
   // ratView.ra = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

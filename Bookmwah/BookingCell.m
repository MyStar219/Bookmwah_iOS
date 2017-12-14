//
//  BookingCell.m
//  Bookmwah
//
//  Created by admin on 18/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "BookingCell.h"

@implementation BookingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.personImage.layer.cornerRadius = self.personImage.frame.size.width/2;
    
    self.personImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)cancelBooking:(id)sender {
}
@end

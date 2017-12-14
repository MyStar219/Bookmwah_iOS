//
//  ListCell.m
//  Bookmwah
//
//  Created by admin on 19/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "ListCell.h"
#import "Constant.h"

@implementation ListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lblCount.layer.cornerRadius = _lblCount.frame.size.height/2;
    _lblCount.layer.cornerRadius = _lblCount.frame.size.width/2;
    _lblCount.clipsToBounds = YES;
    
    _lblCount.layer.borderColor = [WebService colorWithHexString:@"#a1a1a1"].CGColor;
    _lblCount.layer.borderWidth = 1.0;
    
    [_lblCount setTextColor:[WebService colorWithHexString:@"#00afdf"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end

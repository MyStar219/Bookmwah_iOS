//
//  PaymentCell.m
//  Bookmwah
//
//  Created by admin on 03/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "PaymentCell.h"
#import "Constant.h"

@implementation PaymentCell
@synthesize txtCAVV,txtDate,txtCardName,txtCardHolderName;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    txtCardHolderName.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtCardHolderName.layer.borderWidth = 1.0f;
    
    txtCAVV.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtCAVV.layer.borderWidth = 1.0f;
    
    txtDate.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtDate.layer.borderWidth = 1.0f;
    
    txtCardName.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtCardName.layer.borderWidth = 1.0f;
    
    [self changePlaceholderColor];
    
    [self paddingoOfPlaceholder];
    
    
    
}

-(void)changePlaceholderColor
{

 txtCardHolderName.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Card Holder Name"attributes:@{NSForegroundColorAttributeName:[WebService colorWithHexString:@"777777"]}];
    
 txtCardName.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Card Name"attributes:@{NSForegroundColorAttributeName:[WebService colorWithHexString:@"777777"]}];
    
 txtDate.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"Expiry Date"attributes:@{NSForegroundColorAttributeName:[WebService colorWithHexString:@"777777"]}];
    
 txtCAVV.attributedPlaceholder =[[NSAttributedString alloc]initWithString:@"CVV"attributes:@{NSForegroundColorAttributeName:[WebService colorWithHexString:@"777777"]}];
    

    
}


-(void)paddingoOfPlaceholder{
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 10, txtCardHolderName.frame.size.height)];
    txtCardHolderName.leftView = paddingView1;
    txtCardHolderName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 10, txtCardName.frame.size.height)];
    txtCardName.leftView = paddingView2;
    txtCardName.leftViewMode = UITextFieldViewModeAlways;
    
//    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 10, txtDate.frame.size.height)];
//    txtDate.leftView = paddingView3;
//    txtDate.leftViewMode = UITextFieldViewModeAlways;
//    
//    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 10, txtCAVV.frame.size.height)];
//    txtCAVV.leftView = paddingView4;
//    txtCAVV.leftViewMode = UITextFieldViewModeAlways;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

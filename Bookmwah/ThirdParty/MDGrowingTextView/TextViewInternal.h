//
//  TextViewInternal.h
//
//  Created by Mahesh Kumar Dhakad on 03/03/15.
//  Copyright (c) 2012 MKD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TextViewInternal : UITextView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic) BOOL displayPlaceHolder;

@end

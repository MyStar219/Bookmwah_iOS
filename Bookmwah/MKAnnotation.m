//
//  MKAnnotation.m
//  Bookmwah
//
//  Created by admin on 19/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "MKAnnotation.h"

@implementation MKAnnotation

@synthesize title,coordinate,officeAddress;

-(id)initWithTitle:(NSString *)title1 coordinate:(CLLocationCoordinate2D)coordinate1 address:(NSString *)officeAddress1
{
    
    self->title=title1;
    
    self->coordinate=coordinate1;
    
    self->officeAddress=officeAddress1;
    
    return self;
}

@end

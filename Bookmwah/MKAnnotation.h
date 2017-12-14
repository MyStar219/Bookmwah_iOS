//
//  MKAnnotation.h
//  Bookmwah
//
//  Created by admin on 19/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKAnnotation : NSObject<MKAnnotation>

@property NSString *officeAddress;

-(id)initWithTitle:(NSString *)title1
        coordinate:(CLLocationCoordinate2D)coordinate1
           address:(NSString *)officeAddress1;

@end

//
//  MapLocationVC.h
//  Bookmwah
//
//  Created by admin on 19/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface MapLocationVC : UIViewController<MKMapViewDelegate,MKAnnotation>

@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
- (IBAction)back:(id)sender;
@property NSMutableDictionary * mapData;
@end

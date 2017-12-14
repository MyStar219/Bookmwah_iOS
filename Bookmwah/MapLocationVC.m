//
//  MapLocationVC.m
//  Bookmwah
//
//  Created by admin on 19/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "MapLocationVC.h"

@interface MapLocationVC ()

@end

@implementation MapLocationVC

@synthesize myMapView;


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    myMapView.delegate=self;
    [myMapView setShowsUserLocation:true];
    
    if (_mapData!=nil) {
        NSString *latitude = @"22.728115";//[_mapData valueForKey:@"pro_lat"];
        NSString *longitude = @"75.877478";//[_mapData valueForKey:@"pro_long"];
        NSLog(@"%@",_mapData);
        double lat1 = [latitude doubleValue];
        double long1 = [longitude doubleValue];
        CLLocationCoordinate2D office1=CLLocationCoordinate2DMake(lat1,long1);
        
      //  MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(office1, 0, 0);
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(office1, 0.5*5000,0.5*5000);
        
        [myMapView setRegion:viewRegion];
        
       /// [myMapView setRegion:viewRegion animated:YES];
        
      //  [myMapView regionThatFits:viewRegion];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        
        [annotation setCoordinate:office1];
        myMapView.delegate=self;
        [annotation setTitle:[_mapData valueForKey:@"pro_addr"]];
        
        [myMapView addAnnotation:annotation];

    }
    
}

#pragma mark -
#pragma mark MKMapView delegate
-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
   
    MKAnnotationView *pinView = nil;
    
    static NSString *defaultPinID = @"com.invasivecode.pin";
    
    pinView = (MKAnnotationView *)[myMapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    
    if ( pinView == nil )
       
    pinView = [[MKAnnotationView alloc]
      initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    pinView.canShowCallout = YES;
    pinView.image = [UIImage imageNamed:@"map_pin"];
    
    return pinView;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

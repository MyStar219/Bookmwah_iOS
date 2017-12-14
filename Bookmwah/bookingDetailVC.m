//
//  bookingDetailVC.m
//  Bookmwah
//
//  Created by admin on 16/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "BookingDetailVC.h"
#import "Constant.h"

@interface BookingDetailVC ()

@end

@implementation BookingDetailVC
@synthesize arrayDetail,index;
- (void)viewDidLoad {
    [super viewDidLoad];
      NSLog(@"Arry Detail _______%@",arrayDetail);
    
    
      _lbl_serviceType.text = [[arrayDetail objectAtIndex:index.row] valueForKey:@"s_name"];
      _lbl_name.text = [[arrayDetail objectAtIndex:index.row] valueForKey:@"u_fullname"];
      _lbl_Email.text = [[arrayDetail objectAtIndex:index.row] valueForKey:@"u_email"];
       NSString *str = [[arrayDetail objectAtIndex:index.row] valueForKey:@"u_gender"];
    
      if([str isEqualToString:@"1"])
          _lbl_gender.text =@"Male";
      else
          _lbl_gender.text=@"Female";
          _lbl_MobileNumber.text = [[arrayDetail objectAtIndex:index.row] valueForKey:@"u_mobile_no"];
         _lbl_BookingTime.text = [[arrayDetail objectAtIndex:index.row] valueForKey:@"book_time"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated {

  _image_Profile.layer.cornerRadius = _image_Profile.frame.size.width / 2;
  _image_Profile.clipsToBounds = YES;
   
}

@end

//
//  ServiceProviderTabBarVC.h
//  Bookmwah
//
//  Created by admin on 15/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"


@interface ServiceProviderTabBarVC : UITabBarController<UITabBarDelegate,UITabBarControllerDelegate,UIAlertViewDelegate>

-(void)change_TabBar:(NSInteger)selectedIndex;
@end

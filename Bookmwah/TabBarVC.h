//
//  TabBarVC.h
//  Bookmwah
//
//  Created by Developer on 13/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYDrawerController.h"
#import "Constant.h"


@interface TabBarVC : UITabBarController<UITabBarDelegate,UITabBarControllerDelegate,UIAlertViewDelegate>{

}

-(void)change_TabBar:(NSInteger)selectedIndex;

@end

//
//  ServiceProviderTabBarVC.m
//  Bookmwah
//
//  Created by admin on 15/06/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "ServiceProviderTabBarVC.h"

@interface ServiceProviderTabBarVC ()

@end

@implementation ServiceProviderTabBarVC

static NSInteger lastIndex1 = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[(UITabBarController*)self.navigationController.topViewController setSelectedIndex:2];
    
    if (lastIndex1 == 2) {
        [(UITabBarController*)self.navigationController.topViewController setSelectedIndex:2];
    }
  
    //----------Tabbar------------
    [self setDelegate:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    return true;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

    
    if (tabBarController.selectedIndex == 3) {
        
        [tabBarController setSelectedIndex:lastIndex1];
        
        KYDrawerController *elDrawer = (KYDrawerController*)self.navigationController.parentViewController;
        elDrawer.drawerDirection = KYDrawerControllerDrawerDirectionRight;
        //    [elDrawer setDrawerState:DrawerStateOpened animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.01f * NSEC_PER_SEC),dispatch_get_main_queue(), ^{
            [elDrawer setDrawerState: KYDrawerControllerDrawerStateOpened animated: YES];
        });
        
    }
    
//     if (tabBarController.selectedIndex == 2) {
//     [(UITabBarController*)self.navigationController.topViewController setSelectedIndex:2];
//     }

    
    lastIndex1 = tabBarController.selectedIndex;
}
-(void)change_TabBar:(NSInteger)selectedIndex{
    
    
    
    NSLog(@"%ld",(long)selectedIndex);
    
    [self.tabBarController setSelectedIndex:selectedIndex];
    
    lastIndex1 = selectedIndex;
}

@end

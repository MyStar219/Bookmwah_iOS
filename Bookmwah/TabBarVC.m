//
//  TabBarVC.m
//  Bookmwah
//
//  Created by Developer on 13/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "TabBarVC.h"

@interface TabBarVC ()

@end

@implementation TabBarVC


static    NSInteger lastIndex = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //lastIndex = 0;
    
    
    if (lastIndex == 1){
        
        [self.tabBarController setSelectedIndex:1];
      //  [self.tabBarController setSelectedViewController:self.tabBarController.viewControllers[1]];
        
        self.navigationController.tabBarController.selectedViewController = [self.navigationController.tabBarController.viewControllers objectAtIndex:1];
        
       // [self.tabBarController]
        
        //[tabBarController setSelectedViewController:self.tabBarController.viewControllers[1]];
        
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

-(void)willChange:(NSKeyValueChange)changeKind valuesAtIndexes:(NSIndexSet *)indexes forKey:(NSString *)key{
    
}



-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    if (item.tag == 2) {
        
        [NSUD setObject:@"nil" forKey:@"SELECT_CAT_ID"];
        [NSUD synchronize];
        
    }
    
}

-(void)change_TabBar:(NSInteger)selectedIndex{
    
    [self.tabBarController setSelectedIndex:selectedIndex];
    
    lastIndex = selectedIndex;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    
    if (tabBarController.selectedIndex == 2) {
        // ListOfServiceProviderVC *lospVC = [ListOfServiceProviderVC new];
        // lospVC.serviceCategoryID = nil;
        [NSUD setObject:@"nil" forKey:@"SELECT_CAT_ID"];
        [NSUD synchronize];
        // [self.tabBarController setSelectedIndex:2];
        
      //   [tabBarController setSelectedViewController:self.tabBarController.viewControllers[2]];
    }
    
    if (tabBarController.selectedIndex == 3) {
        
        [tabBarController setSelectedIndex:lastIndex];
        
        KYDrawerController *elDrawer = (KYDrawerController*)self.navigationController.parentViewController;
        elDrawer.drawerDirection = KYDrawerControllerDrawerDirectionRight;
        //    [elDrawer setDrawerState:DrawerStateOpened animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.01f * NSEC_PER_SEC),dispatch_get_main_queue(), ^{
            [elDrawer setDrawerState: KYDrawerControllerDrawerStateOpened animated: YES];
        });

        
        
    }
    lastIndex = tabBarController.selectedIndex;
}

@end

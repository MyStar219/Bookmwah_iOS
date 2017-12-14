//
//  AppDelegate.m
//  Bookmwah
//
//  Created by Developer on 13/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "AppDelegate.h"
#import "Constant.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
    
    if ([FIRApp defaultApp] == nil) {
        
        [FIRApp configure];
        
    }

    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSDictionary *userInfo = [launchOptions valueForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    
    NSDictionary *apsInfo = [userInfo objectForKey:@"apps"];
    
    //Accept push notification when app is not open
    if (apsInfo) {
        
        [self application:application didReceiveRemoteNotification:userInfo];
    }
    
    [self registerForPushNotification];

    //Set Tabbar Text Color
    [UITabBarItem.appearance setTitleTextAttributes:@{
                                                      NSForegroundColorAttributeName : [UIColor blackColor] } forState:UIControlStateNormal];
    
    [UITabBarItem.appearance setTitleTextAttributes:@{
                                                      NSForegroundColorAttributeName : [WebService colorWithHexString:@"#00afdf"] }     forState:UIControlStateSelected];//e21a45
    //IQkeyboardmanager method
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:YES];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    if (![NSUD boolForKey:@"IS_APP_INSTALLED"])
    {
        [NSUD setBool:YES forKey:@"IS_APP_INSTALLED"];
        [NSUD setValue:@"0" forKey:@"IS_LOGIN"];

        [NSUD synchronize];
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        SignInVC *home = (SignInVC *) [mainStoryboard instantiateViewControllerWithIdentifier:@"SignInVC"];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:home];
        self.window.rootViewController = navController;
        navController.navigationBar.hidden = YES;
        
    }else{
        
       // if ([[NSUD valueForKey:@"IS_LOGIN"] isEqualToString:@"0"])
          if ([[NSUD valueForKey:@"IS_LOGIN"] isEqualToString:@"0"] || [[NSUD valueForKey:@"IS_LOGIN"] isEqualToString:@"5"])
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            SignInVC *home = (SignInVC *) [mainStoryboard instantiateViewControllerWithIdentifier:@"SignInVC"];
            UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:home];
            self.window.rootViewController = navController;
            navController.navigationBar.hidden = YES;
            
        }else{
            
            
            if ([[NSUD valueForKey:@"user_type"] isEqualToString:@"1"]){
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                TabBarVC *TabBarVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"TabBarVC"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:TabBarVC];
                self.window.rootViewController = navController;
                navController.navigationBar.hidden = YES;
                
            }else{
                
                
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                ServiceProviderTabBarVC *tabBarVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"ServiceProviderTabBarVC"];
                //[self presentViewController:tabBarVC animated:NO completion:nil];
                // tabBarVC.tabBarController.selectedIndex = 0;
                // [[ServiceProviderTabBarVC new] change_TabBar:2];
                
             //   [tabBarVC.tabBarController setSelectedIndex:0];
                
                tabBarVC.tabBarController.selectedIndex = 0;
                [[ServiceProviderTabBarVC new] change_TabBar:0];
                
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:tabBarVC];
                self.window.rootViewController = navController;
                navController.navigationBar.hidden = YES;
                
                
            }
            
           
            
        }
        
    }

    return YES;
}
//fb
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}



//------------------------------------------------------------------------------


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
   
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Push Notifications
#pragma mark -


- (void) registerForPushNotification
{
    NSLog(@"registerForPushNotification");
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0 //
        
        NSLog(@"registerForPushNotification: For iOS >= 8.0");
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:
          (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                           categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
        
    }else{
        NSLog(@"registerForPushNotification: For iOS < 8.0");
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

//#if  def __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:@"031110a45662027d71b57e8326da3f28ffd50f251fdba26b1973bc1c4eee955" forKey:@"GCMId"];
    
    if (error.code == 3010){
        
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    }else{
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}


// For GCM_ID
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    // [def setObject:@"6031110a45662027d71b57e8326da3f28ffd50f251fdba26b1973bc1c4eee955" forKey:@"GCMId"];
    [def setObject:token forKey:@"GCMId"];
    
}

#pragma mark - didReceiveRemoteNotification
#pragma mark -

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    //  NSArray *aps = [userInfo objectForKey:@"aps"];
    // NSString *alert = [aps valueForKey:@"alert"];
    
    NSUserDefaults *nsud=[NSUserDefaults standardUserDefaults];
    [nsud setInteger:4 forKey:@"PrevScreen"];
    [nsud synchronize];
    
    // NSString *msg = [aps valueForKey:@"msg"];
    // NSError *error;
    // NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    //NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    // NSString *sts = [jsonResponse objectForKey:@"status"];
    
    // NSString *message = [jsonResponse objectForKey:@"message"];
    
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString   *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}

@end

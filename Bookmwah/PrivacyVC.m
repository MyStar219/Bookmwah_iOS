//
//  PrivacyVC.m
//  Bookmwah
//
//  Created by admin on 19/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "PrivacyVC.h"
#import "Constant.h"

@interface PrivacyVC (){
    

    MBProgressHUD *HUD;
    
}

@end

@implementation PrivacyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self load_MBProgressHUD];
    
    // Do any additional setup after loading the view.
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://expertteam.in/bookmwah/contact.html"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)load_MBProgressHUD {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading...";
    //HUD.detailsLabelText = @"Pdf..";
    HUD.square = YES;
    [self.view addSubview:HUD];
}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
     [HUD hide:true];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [HUD hide:true];
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    [HUD show:true];
    
    return true;
}


@end

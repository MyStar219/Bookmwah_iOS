//
//  TermsVC.m
//  Bookmwah
//
//  Created by admin on 19/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "TermsVC.h"
#import "Constant.h"

@interface TermsVC (){
    
     MBProgressHUD *HUD;
    
}

@end

@implementation TermsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self load_MBProgressHUD];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://expertteam.in/bookmwah/terms_conditions.html"]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
   // [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];

}

-(void)load_MBProgressHUD {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading...";
    //HUD.detailsLabelText = @"Pdf..";
    HUD.square = YES;
    [self.view addSubview:HUD];
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

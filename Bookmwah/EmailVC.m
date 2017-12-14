//
//  EmailVC.m
//  Bookmwah
//
//  Created by admin on 18/11/17.
//  Copyright © 2017 Mahesh Kumar Dhakad. All rights reserved.
//

#import "EmailVC.h"

@interface EmailVC ()

@end

@implementation EmailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setToRecipients:@[@"support@bookmwah.com"]];
    if ([MFMailComposeViewController canSendMail] && picker) {
    [self presentViewController:picker animated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - MailComposer Delegate Methods

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end

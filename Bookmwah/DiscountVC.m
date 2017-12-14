//
//  DiscountVC.m
//  Bookmwah
//
//  Created by admin on 21/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "DiscountVC.h"
#import "MBProgressHUD.h"
@interface DiscountVC ()

{
    MBProgressHUD *HUD;
    NSUserDefaults *defaults;
    NSString *category;
}
@property NSMutableArray *array;
@end

@implementation DiscountVC
@synthesize  img,txtRate,txtDescription,txtTitle,array,lblTitle;
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
    txtTitle.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtTitle.layer.borderWidth = 1.0f;
    
    txtRate.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtRate.layer.borderWidth = 1.0f;
    
    txtDescription.layer.borderColor = [WebService colorWithHexString:@"777777"].CGColor;
    txtDescription.layer.borderWidth = 1.0f;

    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    dic = [defaults valueForKey:@"sc"];
    NSString *strImg = [dic valueForKey:@"s_cat_image"];
    [img setImageWithURL:[NSURL URLWithString:strImg]
               placeholderImage:[UIImage imageNamed:@"98x100.png"]];
    lblTitle.text = [dic valueForKey:@"s_cat_name"];
    category = [dic valueForKey:@"s_cat_id"];
    
    [self call_UPDATEAPI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)load_MBProgressHUD
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading...";
    //HUD.detailsLabelText = @"Pdf..";
    HUD.square = YES;
    [self.view addSubview:HUD];
    
}

-(void)call_DiscountAPI{
    
    [HUD show:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:txtTitle.text forKey:@"name"];
    [dict setValue:txtRate.text forKey:@"cost"];
    [dict setValue:txtDescription.text forKey:@"description"];
    NSString *pro_id = [defaults valueForKey:@"pro_id"];
    [dict setValue:pro_id forKey:@"pro_id"];

   [dict setValue:category forKey:@"category"];
    
    [WebService call_API:dict andURL:API_ADD_SERVICES andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {

        
        [HUD hide:YES];
        
        NSString *sts = [response objectForKey:@"status"];
        
        if ([sts isEqualToString:@"true"]) {
            
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
            
        }else{
            
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
        }
        
    }];
    
}


-(void)call_UPDATEAPI{
    
    [HUD show:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:txtTitle.text forKey:@"name"];
    [dict setValue:txtRate.text forKey:@"cost"];
    [dict setValue:txtDescription.text forKey:@"description"];
    NSString *pro_id = [defaults valueForKey:@"pro_id"];
    [dict setValue:pro_id forKey:@"pro_id"];
    NSString *s_id = [defaults valueForKey:@"pro_id"];
    [dict setValue:s_id forKey:@"s_id"];
    
    [dict setValue:category forKey:@"category"];
    
    [WebService call_API:dict andURL:API_ADD_SERVICES andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {

        
        [HUD hide:YES];
        
        NSString * sts = [response objectForKey:@"status"];
        
        if ([sts isEqualToString:@"true"]) {
            
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
            
        }else{
            
            _AlertView_WithOut_Delegate(@"Message",[response objectForKey:@"message"], @"OK", nil);
        }
        
    }];
    
}



- (IBAction)btnPublish:(id)sender {
    
    [self call_DiscountAPI];
}


- (IBAction)btnBack:(id)sender {
    
    ProfessionalServicesVC *professionalServicesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalServicesVC"];
    
    [self presentViewController:professionalServicesVC animated:false completion:nil];
}
@end

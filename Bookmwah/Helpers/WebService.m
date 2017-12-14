//
//  WebService.m
//  Mahesh Kumar Dhakad

//  Created by Mahesh Kumar Dhakad on 08/07/15.
//  Copyright (c) 2015 Mahesh Kumar Dhakad. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "WebService.h"

@implementation WebService : NSObject

+(void)call_API:(NSMutableDictionary *)dict andURL:(NSString *)url andImage:(UIImage *)image andImageName:(NSString *)imageName andFileName:(NSString *)fileName OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock{
    
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    
    if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"false" forKey:@"status"];
        
        [dict setValue:@"No Internet Connection, try later!" forKey:@"msg"];
        
        OnResultBlock(dict,resultData,@"failure");
    }
    else
    {
        
        NSURL *baseURL = [NSURL URLWithString:url];
        
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
        NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:nil parameters:dict constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
            
            if (image) {
                
                 NSData *imageData = UIImageJPEGRepresentation(image,0.5f);
                
                 [formData appendPartWithFileData:imageData name:imageName fileName:fileName mimeType:@"image/jpeg"];
            }
          
        }];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSInteger statusCode = operation.response.statusCode;
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            
            if(statusCode  == 200)
            {
                
                NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers                       error:nil];
                
                OnResultBlock(dict,resultData,@"Success");
                
            }else{
                
                [dict setValue:@"false" forKey:@"status"];
                [dict setValue:@"Connection timeout, try later!" forKey:@"msg"];
                
                OnResultBlock(dict,resultData,@"failure");
            }
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setValue:@"false" forKey:@"status"];
            
            [dict setValue:@"Connection timeout, try later!" forKey:@"msg"];
            OnResultBlock(dict,resultData,@"failure");
        }];
        
        [operation start];
        
    }

    
    
}




+(void)call_API:(NSDictionary *)dict andURL:(NSString *)url andImage:(UIImage *)image andImageName:(NSString *)imageName  OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock{
    
    
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    
    if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue:@"false" forKey:@"status"];
        
        [dict setValue:@"No Internet Connection, try later!" forKey:@"msg"];
        
        OnResultBlock(dict,resultData,@"failure");
    }
    else
    {
        NSURL *baseURL = [NSURL URLWithString:url];
        
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
        
        NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:nil parameters:dict constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
            
            if(image){
                
                NSData *imageData = UIImageJPEGRepresentation(image,0.5f);
                
                NSString *fileName = [NSString stringWithFormat:@"%f.jpeg",[[NSDate date]timeIntervalSince1970]];
                
                [formData appendPartWithFileData:imageData name:imageName fileName:fileName mimeType:@"image/jpeg"];
            }
            
        }];
        
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSInteger statusCode = operation.response.statusCode;
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            
            if(statusCode  == 200)
            {
                
                NSMutableDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers                       error:nil];
                
                if(!dict){
                    
                    NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    
                    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"bool(true)" withString:@""];
                    
                    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                    
                    dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers                       error:nil];
                }
                
                OnResultBlock(dict,resultData,@"Success");
                
            }else{
                
                [dict setValue:@"false" forKey:@"status"];
                
                [dict setValue:@"Connection timeout, try later!" forKey:@"message"];
                
                OnResultBlock(dict,resultData,@"failure");
                
            }
            
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setValue:@"false" forKey:@"status"];
            
            [dict setValue:@"Connection timeout, try later!" forKey:@"message"];
            
            OnResultBlock(dict,resultData,@"failure");
            
        }];
        
        
        
        [operation start];
        
    }
    
}







-(void)call_API:(NSString *)url OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock
{
    
    NSURL *baseUrl=[NSURL URLWithString:url];
    NSURLRequest *req=[NSURLRequest requestWithURL:baseUrl];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse *resp, NSData *data, NSError *err){
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) resp;
         NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
         NSString *code = [NSString stringWithFormat:@"%ld",(long)[httpResponse statusCode]];
         NSMutableDictionary *dictionary1 =[NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
         OnResultBlock(dictionary1,resultData,code);
         
     }];
}




-(void)stop_Loading:(UIViewController *)viewController{
    
    for ( UIView *subview in viewController.view.subviews ) {
        
        if ([subview  isKindOfClass:[MBProgressHUD class]] ) {
            
             MBProgressHUD *hud = (MBProgressHUD *)[subview viewWithTag:444];
            
            [hud hide:YES];
            
        }
    }
   
}



// For Call APi where you want



/*
 
 
 NSURL *baseUrl=[NSURL URLWithString:url];
 NSURLRequest *req=[NSURLRequest requestWithURL:baseUrl];
 [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:
 ^(NSURLResponse *resp, NSData *data, NSError *err){
 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) resp;
 NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
 NSString *code = [NSString stringWithFormat:@"%ld",(long)[httpResponse statusCode]];
 NSMutableDictionary *dictionary1 =[NSJSONSerialization JSONObjectWithData:data
 options:NSJSONReadingMutableContainers
 error:nil];
 OnResultBlock(dictionary1,resultData,code);
 
 
 
 
 }];
 

 
 
 
 
 WebService *api = [WebService alloc];
 
 [api call_API:dict andURL:GET_CATEGORY_API OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
 
 NSDictionary *dic = response ;
 
 NSString *sts=[dic objectForKey:@"status"];
 
 if ([sts isEqualToString:@"true"]) {
 
 }else{
 
 }
 }];
 
 */





#pragma mark - colorWithHexString Methods
#pragma mark -


+(UIColor *)colorWithHexString:(NSString *)colorString
{
    colorString = [colorString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    if (colorString.length == 3)
        colorString = [NSString stringWithFormat:@"%c%c%c%c%c%c",
                       [colorString characterAtIndex:0], [colorString characterAtIndex:0],
                       [colorString characterAtIndex:1], [colorString characterAtIndex:1],
                       [colorString characterAtIndex:2], [colorString characterAtIndex:2]];
    
    if (colorString.length == 6)
    {
        int r, g, b;
        sscanf([colorString UTF8String], "%2x%2x%2x", &r, &g, &b);
        return [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0];
    }
    return nil;
}



#pragma mark - For Border / CALayer Set Methods
#pragma mark -

+(CALayer *)setBorderWithFrame:(CGRect)frame andColor:(UIColor *)color{
    
    CALayer *border = [CALayer layer];
    border.frame = frame;
    //CGRectMake(0.0f, 0, self.frame.size.width, 1.0f);
    border.backgroundColor = color.CGColor;
    return border;
    
    // [self.view.layer addSublayer:border];

}



#pragma mark - Get TextHeight
#pragma mark -

+ (CGFloat)get_TextHeight:(NSString *)text minimumHeight:(CGFloat)minimumHeight textViewFrame:(CGRect)textViewFrame{
    
    CGRect textViewSize = [text boundingRectWithSize:CGSizeMake(285, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:16]} context:nil];
    
    const CGFloat additionalSpace = minimumHeight - textViewFrame.size.height + 10;
    
    CGFloat rowHeight = textViewSize.size.height + additionalSpace;
    
    return rowHeight;
}


#pragma mark - Hide / Show Shadow
#pragma mark -

+ (UIView *)show_Shadow:(BOOL)isShow OnView:(UIView *)view{
    
    if (isShow) {
        
    }else{
        
    }
    
    // shadowView View
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) ];
                                                                  
    [shadowView setBackgroundColor:[UIColor darkGrayColor]];
    
    //[view addSubview:shadowView];
    
    return shadowView;
}

#pragma mark - Scale Image
#pragma mark - 

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

#pragma mark - @end

#pragma mark -

@end


@implementation Global : NSObject




@end



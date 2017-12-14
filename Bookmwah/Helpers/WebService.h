//
//  WebService.h
//  Mahesh Kumar Dhakad 

//  Created by Mahesh Kumar Dhakad on 08/07/15.
//  Copyright (c) 2015 Mahesh Kumar Dhakad. All rights reserved.
//

#include "Constant.h"



typedef enum {
    resultData=0,
    
    errorData,
    
    timeOut,
    
    resultOk
    
} MDDataTypes;

@interface WebService : NSObject
{
   //MBProgressHUD *HUD;
    
    UIView *shadowView;
}



+(void)call_API:(NSMutableDictionary *)dict andURL:(NSString *)url andImage:(UIImage *)image andImageName:(NSString *)imageName andFileName:(NSString *)fileName OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock;

+(void)call_API:(NSDictionary *)dict andURL:(NSString *)url andImage:(UIImage *)image andImageName:(NSString *)imageName  OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock;



+(UIColor *)colorWithHexString:(NSString *)colorString;

+(CALayer *)setBorderWithFrame:(CGRect)frame andColor:(UIColor *)color;

//+ (NSString *)show_Shadow:(BOOL)status;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;


@end



@interface Global : NSObject

@end

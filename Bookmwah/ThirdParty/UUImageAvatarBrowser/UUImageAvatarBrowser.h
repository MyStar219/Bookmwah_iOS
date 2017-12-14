//
//  UUImageAvatarBrowser.h
//  Actually
//  Copyright © 2015 MKD,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UUImageAvatarBrowser : NSObject <UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIScrollView *zoomScrollView;
    UIImageView *zoomImageView;
}
+ (UUImageAvatarBrowser *)sharedInstance;

//show imageView for ZoomView

+ (void)showImageForZoomView:(UIViewController *)superView withImage:(id)sender ;
- (void)showImageFullView:(UIViewController *)superView withImage:(id)sender;
- (void)hideImageZoomView:(UITapGestureRecognizer*)tap;


//show imageView on the keyWindow
+(void)showImage:(UIImageView*)avatarImageView;
+(void)play_Movie:(NSString *)URLString;

+(void)showImageFromButton:(UIButton *)avatarImageView;

+(void)hideButtonImage:(UITapGestureRecognizer*)tap;

@end

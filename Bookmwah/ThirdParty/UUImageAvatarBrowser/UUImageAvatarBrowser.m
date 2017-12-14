//
//  UUImageAvatarBrowser.m
//  Actually
//  Copyright © 2015 MKD,Inc. All rights reserved.
//

#import "UUImageAvatarBrowser.h"
#import "Constant.h"

static UUImageAvatarBrowser *sharedInstance = nil;

static UIImageView *orginImageView;
static UIButton *orginButton;
static UIView *backgroundView;
static id senders;
static id superViews;

@implementation UUImageAvatarBrowser

// Get the shared instance and create it if necessary.
+ (UUImageAvatarBrowser *)sharedInstance {
    
    if (sharedInstance != nil) {
        return sharedInstance;
    }
    sharedInstance = [[super allocWithZone:NULL] init];
    
    return sharedInstance;
}

-(void)dealloc
{
}

// We don't want to allocate a new instance, so return the current one.
+ (id)allocWithZone:(NSZone*)zone {
    return [self sharedInstance];
}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

+(void)showImage:(UIImageView *)avatarImageView{
    
    UIImage *image = avatarImageView.image;
    orginImageView = avatarImageView;
    orginImageView.alpha = 0;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    CGRect oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
    backgroundView.alpha=1;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag=1;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [backgroundView addSubview:imageView];
    
    UIButton *btn_Cancel = [[UIButton alloc] initWithFrame:CGRectMake(backgroundView.frame.size.width-64, 0, 64, 64)];
    [btn_Cancel setImage:[UIImage imageNamed:@"cncl.png"] forState:UIControlStateNormal];
    [btn_Cancel setBackgroundColor:[UIColor clearColor]];
    //[btn_Cancel addTarget:self action:@selector(hide_FullStoryImage:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn_Cancel];
    
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [btn_Cancel addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}



+(void)showImageFromButton:(UIButton *)avatarImageView{
    
    // UIImage *image=avatarImageView.image;
    UIImage *image= [avatarImageView imageForState:UIControlStateNormal];
    orginButton = avatarImageView;
    orginButton.alpha = 0;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    CGRect oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:1];
    backgroundView.alpha=1;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [backgroundView addSubview:imageView];
    
    UIButton *btn_Cancel = [[UIButton alloc] initWithFrame:CGRectMake(backgroundView.frame.size.width-64, 0, 64, 64)];
    [btn_Cancel setImage:[UIImage imageNamed:@"cncl.png"] forState:UIControlStateNormal];
    [btn_Cancel setBackgroundColor:[UIColor clearColor]];
    //[btn_Cancel addTarget:self action:@selector(hide_FullStoryImage:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn_Cancel];
    
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideButtonImage:)];
    [btn_Cancel addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}


+(void)hideButtonImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView1=tap.view;
    UIImageView *imageView=(UIImageView*)[backgroundView viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        [backgroundView1 removeFromSuperview];
        
        imageView.frame=[orginButton convertRect:orginButton.bounds toView:[UIApplication sharedApplication].keyWindow];
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
        orginButton.alpha = 1;
        backgroundView.alpha=0;
    }];
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView1=tap.view;
    UIImageView *imageView=(UIImageView*)[backgroundView viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        [backgroundView1 removeFromSuperview];
        
        imageView.frame=[orginImageView convertRect:orginImageView.bounds toView:[UIApplication sharedApplication].keyWindow];
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
        orginImageView.alpha = 1;
        backgroundView.alpha=0;
    }];
}

+(void)play_Movie:(NSString *)URLString{
    
    orginImageView.alpha = 0;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    backgroundView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:1];
    backgroundView.alpha = 1;
    
    
    NSURL *_urlToLoad = [NSURL URLWithString:URLString];
    
    if (_urlToLoad) {
        
        // MPMoviePlayerViewController *
        MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:_urlToLoad];
        moviePlayer.view.frame = backgroundView.frame;
        //moviePlayer.moviePlayer.controlStyle = MPMovieControlStyleDefault;
        moviePlayer.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
        moviePlayer.moviePlayer.shouldAutoplay = YES;
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer.moviePlayer];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification                object:moviePlayer.moviePlayer];
        
        [backgroundView addSubview:moviePlayer.view];
        backgroundView.tag = 222;
    }
    
    
    [window addSubview:backgroundView];
    
    //UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    // [btn_Cancel addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    MPMoviePlayerViewController *moviePlayer = [notification object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
    
    if ([moviePlayer respondsToSelector:@selector(setFullscreen:animated:)])
    {
        // the transition should be around here... (fade out)
        [moviePlayer.view removeFromSuperview];
    }
    if (moviePlayer) {
        
        [backgroundView removeFromSuperview];
    }
}

#pragma mark - showImageForZoomView
#pragma mark - 

+ (void)showImageForZoomView:(UIViewController *)superView withImage:(id)sender {

    
   [[UUImageAvatarBrowser new] showImageFullView:superView withImage:sender];

}

- (void)showImageFullView:(UIViewController *)superView withImage:(id)sender{
    
    superViews = superView;

    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [superView setNeedsStatusBarAppearanceUpdate];
    
    UIImage *senderImage = [UIImage new];
    
    senders = sender;
    
    // Do any additional setup after loading the view, typically from a nib.
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
   CGRect oldframe = window.frame ;
    
    if ([sender isKindOfClass:[UIImageView class]]) {
        
        UIImageView *avatarImageView = sender;
        senderImage = avatarImageView.image;
        orginImageView = avatarImageView;
        orginImageView.alpha = 0;
        
        oldframe = [sender convertRect:[sender bounds] toView:window];

        
    }else if ([sender isKindOfClass:[UIButton class]]){
        
        UIButton *avatarImageView = sender;
        
        senderImage = [avatarImageView imageForState:UIControlStateNormal];
        
        //senderImage = [avatarImageView backgroundImageForState:UIControlStateNormal];

        orginButton = avatarImageView;
        orginButton.alpha = 0;

         oldframe = [sender convertRect:[sender bounds] toView:window];

    }
    
    if (senderImage == nil) {
        
        return;
    }
    
    backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:1];
    backgroundView.alpha=1;
    
    UIButton *btn_Cancel = [[UIButton alloc] initWithFrame:CGRectMake(backgroundView.frame.size.width-64, 0, 64, 64)];
    [btn_Cancel setImage:[UIImage imageNamed:@"cncl.png"] forState:UIControlStateNormal];
    [btn_Cancel setBackgroundColor:[UIColor clearColor]];
    //[btn_Cancel addTarget:self action:@selector(hide_FullStoryImage:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImageZoomView:)];
    [btn_Cancel addGestureRecognizer: tap];
    
    
    zoomScrollView = [[UIScrollView alloc]initWithFrame:backgroundView.frame];
    [zoomScrollView setBackgroundColor:[UIColor blackColor]];
    [zoomScrollView setUserInteractionEnabled:YES];
    
    // Creates a view Dictionary to be used in constraints
    NSDictionary *viewsDictionary;
    
    // Creates an image view with a test image
    zoomImageView = [[UIImageView alloc] initWithFrame:oldframe];
    UIImage *turnImage = senderImage;
    [zoomImageView setImage:turnImage];
    zoomImageView.tag = 1;

    // Add the imageview to the scrollview
    [zoomScrollView addSubview:zoomImageView];
    
    // self.zoomScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    // self.zoomImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Sets the scrollview delegate as self
    zoomScrollView.delegate = self;
    
    // Creates references to the views
    UIScrollView *scrollView = zoomScrollView;
    
    // Sets the image frame as the image size
    //zoomImageView.frame = CGRectMake(0, 0, turnImage.size.width, turnImage.size.height);
    
    // Tell the scroll view the size of the contents
    zoomScrollView.contentSize = turnImage.size;
    
    // Set the constraints for the scroll view
    viewsDictionary = NSDictionaryOfVariableBindings(scrollView);
    //[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:0 views:viewsDictionary]];
    // [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]-(50)-|" options:0 metrics: 0 views:viewsDictionary]];
    
    // Add doubleTap recognizer to the scrollView
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [zoomScrollView addGestureRecognizer:doubleTapRecognizer];
    
    
    
    // Add two finger recognizer to the scrollView
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [zoomScrollView addGestureRecognizer:twoFingerTapRecognizer];
    
    
    
    [backgroundView addSubview:zoomScrollView];

    [backgroundView addSubview:btn_Cancel];
    
    [window addSubview:backgroundView];

    
    [UIView animateWithDuration:0.3 animations:^{
        zoomImageView.frame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height-senderImage.size.height*[UIScreen mainScreen].bounds.size.width/senderImage.size.width)/2, [UIScreen mainScreen].bounds.size.width, senderImage.size.height*[UIScreen mainScreen].bounds.size.width/senderImage.size.width);
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
    [self setupScales];
}



#pragma mark - Scroll View scales setup and center
#pragma mark -

-(void)setupScales {
    
    // Set up the minimum & maximum zoom scales
    CGRect scrollViewFrame = zoomScrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / zoomScrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / zoomScrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    zoomScrollView.minimumZoomScale = 1;
    zoomScrollView.maximumZoomScale = 4.0f;
    zoomScrollView.zoomScale = minScale;
    zoomScrollView.zoomScale = 1;
    
    [self centerScrollViewContents];
}

- (void)centerScrollViewContents {
    // This method centers the scroll view contents also used on did zoom
    CGSize boundsSize = zoomScrollView.bounds.size;
    CGRect contentsFrame = zoomImageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    zoomImageView.frame = contentsFrame;
}


#pragma mark - ScrollView Delegate methods
#pragma mark -

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    return zoomImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}


#pragma mark - ScrollView gesture methods
#pragma mark -


- (void)scrollViewDoubleTapped123:(UITapGestureRecognizer*)recognizer {
    // Get the location within the image view where we tapped
    CGPoint pointInView = [recognizer locationInView:zoomImageView];
    
    // Get a zoom scale that's zoomed in slightly, capped at the maximum zoom scale specified by the scroll view
    CGFloat newZoomScale = zoomScrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, zoomScrollView.maximumZoomScale);
    
    // Figure out the rect we want to zoom to, then zoom to it
    CGSize scrollViewSize = zoomScrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    [zoomScrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer *)recognizer {
    
    
    CGFloat scaleHeight = zoomScrollView.frame.size.height /zoomScrollView.contentSize.height;
    CGFloat scaleWidth = zoomScrollView.frame.size.width / zoomScrollView.contentSize.width;
    
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    UIScrollView *scrollView = (UIScrollView*)recognizer.view;
    float scale = scrollView.zoomScale;
    scale += 1.0;
    if(scale > 2.0) scale = minScale;
    [scrollView setZoomScale:scale animated:YES];
    
}



- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = zoomScrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, zoomScrollView.minimumZoomScale);
    [zoomScrollView setZoomScale:newZoomScale animated:YES];
}

#pragma mark - Rotation
#pragma mark -


-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    // When the orientation is changed the contentSize is reset when the frame changes. Setting this back to the relevant image size
    zoomScrollView.contentSize = zoomImageView.image.size;
    // Reset the scales depending on the change of values
    [self setupScales];
}



#pragma mark - Rotation
#pragma mark -

- (void)hideImageZoomView:(UITapGestureRecognizer*)tap{
    
    [self setupScales];

    UIView *bgView = tap.view;
   // UIImageView *imageView = (UIImageView*)[zoomScrollView viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        [bgView removeFromSuperview];
        
        if ([senders isKindOfClass:[UIImageView class]]) {
            
            zoomImageView.frame = [orginImageView convertRect:orginImageView.bounds toView:[UIApplication sharedApplication].keyWindow];

        }else if ([senders isKindOfClass:[UIButton class]]){
            
            zoomImageView.frame = [orginButton convertRect:orginButton.bounds toView:[UIApplication sharedApplication].keyWindow];
        }
        
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
        orginButton.alpha    = 1;
        orginImageView.alpha = 1;
        backgroundView.alpha = 0;
    }];
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [superViews setNeedsStatusBarAppearanceUpdate];
}

// Add this method
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end

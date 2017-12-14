//
//  Constant.h
//

//const NSString *email_ID =@"support@bookmwah.com";

#define MOBILE_NO (10)


// ********* All Alert ********* //

#define _AlertView_With_Delegate(title, msg, button, buttons...) {UIAlertView *__alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:button otherButtonTitles:buttons];[__alert show];}

#define _AlertView_WithOut_Delegate(title, msg, button, buttons...) {UIAlertView *__alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:button otherButtonTitles:buttons];[__alert show];}

#define _AlertViewIOS9_With_Delegate(title, msg, button){UIAlertController *__alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];UIAlertAction* __ok = [UIAlertAction actionWithTitle:button style:UIAlertActionStyleDefault handler:nil];alertController addAction:__ok];[self presentViewController:alertController animated:YES completion:nil];}

// ********* FB App ID ********* //


#define FB_APP_ID @"751139751658667"



#define NSUD ([NSUserDefaults standardUserDefaults])


// ********* Define App All Color ********* \\


// ********* IPhone Size ********* \\

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


// *********IMPORT  Frameworks  ********* \\

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UITableView.h>
#import <UIKit/UIKitDefines.h>
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


#import "MDGrowingTextView.h"
#import "TextViewInternal.h"


// ********* IMPORT ALL TableView Custom Cell ********* \\

#import "BookingCell.h"
#import "ListCell.h"
#import "ServiceProviderDetailTVCell.h"
#import "ListOfServiceProviderCell.h"
#import "ProfessionalServicesTVCell.h"
#import "ProfessionalRecommendationTVCell.h"
#import "NotificationsTVCell.h"
#import "ChatListTableViewCell.h"

// ********* IMPORT ALL Collection Custom Cell ********* \\

#import "HomeVCCell.h"
#import "PortfolioCVCell.h"
#import "PortfolioCell.h"
//  ********* IMPORT External Class ********* \\

#import "AFNetworking.h"
#import "MBProgressHUD.h"
//#import "CALayer+ViewBorder.h"
#import "IQKeyboardManager.h"
//#import "UUImageAvatarBrowser.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "KYDrawerController.h"
#import "ASStarRatingView.h"
//#import "UUImageAvatarBrowser.h"
#import <MessageUI/MessageUI.h>
#import "Reachability.h"


#import "SWNinePatchImageFactory.h"
#import "SWNinePatchImageView.h"
#import "UUImageAvatarBrowser.h"


//#import <UIImageView+UIActivityIndicatorForSDWebImage.h>


// ********* IMPORT GLOBLE / HELPERs CLASSES ********* \\

#import "WebService.h"

// ********* IMPORT ALL CONTROLLER ********* \\

#import "AppDelegate.h"
#import "SignInVC.h"
#import "HomeVC.h"
#import "TabBarVC.h"
#import "MoreVC.h"
#import "BrowsVC.h"
#import "AppointmentsVC.h"
#import "TermsVC.h"
#import "AboutUsVC.h"
#import "PrivacyVC.h"
#import "MenuVC.h"
#import "ListOfServiceProviderVC.h"
#import "ServiceProviderDetailVC.h"
#import "MapLocationVC.h"
#import "PaymentVC.h"
#import "CustomerBookingVC.h"
#import "MKAnnotation.h"
#import "AccountInfo.h"
#import "PortfolioVC.h"
#import "BookingDetailVC.h"
#import "BookingForYou.h"
#import "DiscountVC.h"
#import "NotificationsVC.h"

#import "ChatListVC.h"
#import "ChatDetailVC.h"


#import "TabBarVC.h"
// ********* Service Provider Tabbar ********* \\

#import "ServiceProviderTabBarVC.h"

#import "ProfessionalInfoVC.h"
#import "ProfessionalServicesVC.h"
#import "ProfessionalBankDetailsVC.h"
#import "ProfessionalRecommendationVC.h"

//
#import "EmailVC.h"
#import "OTPVerificationVC.h"


#import <FirebaseAuth/FirebaseAuth.h>
#import "Firebase.h"
#import <FirebaseInstanceID/FirebaseInstanceID.h>


// ********* Web Services URLs ********* \\

#define BASE_URL @"http://expertteam.in/bookmwah/webservices/"

#define API_LOGIN ([NSString stringWithFormat:@"%@user_login.php",BASE_URL])

#define API_SIGNUP ([NSString stringWithFormat:@"%@user_signup.php",BASE_URL])

#define API_SERVICE_CATEGORY ([NSString stringWithFormat:@"%@service_category.php",BASE_URL])

#define API_SERVICE_PROVIDERS ([NSString stringWithFormat:@"%@service_providers.php",BASE_URL])

#define API_ALL_PROVIDERS ([NSString stringWithFormat:@"%@all_providers.php",BASE_URL])

#define API_PROVIDERS_DETAILS ([NSString stringWithFormat:@"%@provider_details.php",BASE_URL])

#define API_APPOINTMENTS ([NSString stringWithFormat:@"%@appointments.php",BASE_URL])

#define API_BOOKING ([NSString stringWithFormat:@"%@booking.php",BASE_URL])

#define API_PROFILE_INFO ([NSString stringWithFormat:@"%@profile_info.php",BASE_URL])

#define API_GET_CARD_LIST ([NSString stringWithFormat:@"%@get_card_list.php",BASE_URL])

#define API_EDIT_PROFILE ([NSString stringWithFormat:@"%@edit_profile.php",BASE_URL])

#define API_ADD_PROVIDER_INFO ([NSString stringWithFormat:@"%@add_provider_info.php",BASE_URL])

#define API_ADD_BANK_DETAILS ([NSString stringWithFormat:@"%@add_bank_details.php",BASE_URL])

#define API_ADD_SERVICES ([NSString stringWithFormat:@"%@add_service.php",BASE_URL])

#define API_NOTIFICATION_LIST ([NSString stringWithFormat:@"%@notification_list.php",BASE_URL])

#define API_REMOVE_SERVICE ([NSString stringWithFormat:@"%@remove_service.php",BASE_URL])

#define API_BOOKING4U ([NSString stringWithFormat:@"%@booking4u.php",BASE_URL])

#define API_BOOKING_ACCEPT_REJECT ([NSString stringWithFormat:@"%@accept_reject.php",BASE_URL])

#define API_CANCEL_BOOKING ([NSString stringWithFormat:@"%@cancel_booking.php",BASE_URL])


#define API_ADD_PORTFOLIO_IMAGE ([NSString stringWithFormat:@"%@add_portfolio_image.php",BASE_URL])

//
#define API_OTPVERIFICATION ([NSString stringWithFormat:@"%@user_verification.php",BASE_URL])


//////////////////// by rd


#define API_LogOut ([NSString stringWithFormat:@"%@user_logout.php",BASE_URL])


#define API_CHAT_LIST ([NSString stringWithFormat:@"%@chat_list.php",BASE_URL])

#define API_Send_Chat_Message ([NSString stringWithFormat:@"%@send_chat_message.php",BASE_URL])


#define SUCCESS_RESPONSE @"A"

//
//  Menu.h
//  Bookmwah
//
//  Created by admin on 23/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"


@interface ChatDetailVC : UIViewController<UITableViewDelegate,UITableViewDataSource,MDGrowingTextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSDictionary *dic ;
    
    NSMutableArray *notificationArray;
}

@property (weak, nonatomic)  NSArray *userDetail;
@property (weak, nonatomic)  NSString *strUserImg;
@property (weak, nonatomic)  NSString *strUserName;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UITableView *tv;

@property (weak, nonatomic)  MDGrowingTextView *commentTextView;

@property (weak, nonatomic) IBOutlet UILabel *lblFrame;

@property (weak, nonatomic)  NSDictionary *dicComment;

@property (weak, nonatomic)  UIButton *btn_Send;

@property (weak, nonatomic)  UIImageView *bgImage;

@property (weak, nonatomic)  UIView *containerView;

@property (weak, nonatomic) IBOutlet UITextView *textView;


- (IBAction)Back_btn:(id)sender;
//@property (weak, nonatomic) IBOutlet UILabel *lblName;

@end

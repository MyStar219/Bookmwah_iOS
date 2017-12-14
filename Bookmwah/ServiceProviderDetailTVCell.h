//
//  ServiceProviderDetailTVCell.h
//  Bookmwah
//
//  Created by admin on 18/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "MapLocationVC.h"
#import "ASStarRatingView.h"

@interface ServiceProviderDetailTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblProviderName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblRating;
@property (weak, nonatomic) IBOutlet UIButton *showMap;

@property (weak, nonatomic) IBOutlet UILabel *lblServicesName;
@property (weak, nonatomic) IBOutlet UILabel *lblCost;
@property (weak, nonatomic) IBOutlet UIButton *showBook;
@property (weak, nonatomic) IBOutlet UIButton *btnEmail;


@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (weak, nonatomic) IBOutlet UIButton *btnCalling;


//RecommendationCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UILabel *lblFeedback;
@property (weak, nonatomic) IBOutlet ASStarRatingView *viewRating;
@property (weak, nonatomic) IBOutlet UICollectionView *collection_view;

//InfoCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_business_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_business_address;
@property (weak, nonatomic) IBOutlet UILabel *lbl_business_role;
@property (weak, nonatomic) IBOutlet UILabel *lbl_business_email;

@property (weak, nonatomic) IBOutlet UILabel *lbl_business_mobile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_business_website;
@property (weak, nonatomic) IBOutlet UILabel *lbl_business_zipcode;

@property (weak, nonatomic) IBOutlet UILabel *lbl_business_state;
@property (weak, nonatomic) IBOutlet UILabel *lbl_business_other_notes;
@property (weak, nonatomic) IBOutlet UILabel *lbl_business_cancel_policy;





















@end

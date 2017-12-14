//
//  ServiceProviderDetailTVCell.m
//  Bookmwah
//
//  Created by admin on 18/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "ServiceProviderDetailTVCell.h"
#import "WebService.h"

@implementation ServiceProviderDetailTVCell
@synthesize lblProviderName,lblAddress,lblTime,img,lblRating,lblServicesName,lblCost;
- (void)awakeFromNib {
    [super awakeFromNib];
    //Round Image
    img.layer.cornerRadius = img.frame.size.height/2;
    img.layer.cornerRadius = img.frame.size.width/2;
    img.clipsToBounds=YES;
    
    _lblCategory.layer.cornerRadius = _lblCategory.layer.frame.size.width/7;
    _lblCategory.clipsToBounds = YES;

    [self changeSegmentProperties];
    [self circularImageView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0,20);
    [_collection_view setCollectionViewLayout:flowLayout];
}

#pragma mark - Change Segment Properties
#pragma mark

-(void)changeSegmentProperties
{
    _segment.tintColor = [WebService colorWithHexString:@"#00afdf"];
    NSDictionary *selectedAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"Corbel" size:10], NSFontAttributeName,
                                        [UIColor whiteColor], NSForegroundColorAttributeName,
                                       nil];
    [_segment setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
    NSDictionary *unSelectedAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"Corbel" size:10], NSFontAttributeName,
                                        [UIColor blackColor], NSForegroundColorAttributeName,
                                        nil];
    [_segment setTitleTextAttributes:unSelectedAttributes forState:UIControlStateNormal];
}

#pragma mark - Circular ImageView(Recommendation)
#pragma mark 

-(void)circularImageView
{
    _imageView1.layer.cornerRadius = _imageView1.layer.frame.size.width/2;
    _imageView1.clipsToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

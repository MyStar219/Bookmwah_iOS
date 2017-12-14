//
//  HomeVC.h
//  Bookmwah
//
//  Created by Developer on 13/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface HomeVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
{
    NSMutableArray *collectionArray,*filterArray;
    NSMutableDictionary *dic_images,*dic;
    BOOL isFilter;
    MBProgressHUD *HUD;
    UITapGestureRecognizer *tap;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end

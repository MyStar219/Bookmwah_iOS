//
//  PortfolioVC.m
//  Bookmwah
//
//  Created by admin on 21/05/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "PortfolioVC.h"
#import "Constant.h"

@interface PortfolioVC ()

@end

@implementation PortfolioVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    images = [NSMutableArray new];
    portfolioArray = [NSMutableArray new];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(20,20,20,20);
    [_collectionView setCollectionViewLayout:flowLayout];
    
    //load MBProgressHUD
//    [self load_MBProgressHUD];
    
    //Connect scrollview button's methods
    [self connectMethods];
    
    [self changeButtonColor];
    [self call_GetPorfolioImageAPI];
    
}

-(void)viewDidAppear:(BOOL)animated
{
  _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width+_btnPortfolio.frame.size.width+_btnBankDetails.frame.size.width,_scrollView.contentSize.height);
      [_scrollView setContentOffset:CGPointMake((_btnPortfolio.frame.origin.x-self.view.frame.size.width+_btnPortfolio.frame.size.width), _scrollView.frame.size.height) animated:TRUE];
   
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_scrollView])
    {
        if (scrollView.contentOffset.y > 0  ||  scrollView.contentOffset.y < 0 )
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
    
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

#pragma mark - Connect Methods on scroll view button
#pragma mark -
-(void)connectMethods
{
    [_btnInfo addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchDown];
    [_btnServices addTarget:self action:@selector(showServices:) forControlEvents:UIControlEventTouchDown];
    [_btnPortfolio addTarget:self action:@selector(showPortfolio:) forControlEvents:UIControlEventTouchDown];
    [_btnBankDetails addTarget:self action:@selector(showBankDetails:) forControlEvents:UIControlEventTouchDown];
    [_btnRecommendation addTarget:self action:@selector(showRecommdation:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - Change Button Color
#pragma mark -

-(void)changeButtonColor
{
    _btnPortfolio.layer. backgroundColor =[WebService colorWithHexString:@"00afdf"].CGColor;
    
    [_btnPortfolio setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _btnServices.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [_btnServices setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _btnBankDetails.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [_btnBankDetails setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _btnInfo.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [_btnInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _btnRecommendation.layer. backgroundColor =[WebService colorWithHexString:@"eeeeee"].CGColor;
    
    [_btnRecommendation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

#pragma mark - call_GetPorfolioImageAPI
#pragma mark - 

-(void)call_GetPorfolioImageAPI
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[NSUD valueForKey:@"pro_id"] forKey:@"pro_id"];
    [dict setObject:@"2" forKey:@"type"];
//    [dic setObject:[NSUD valueForKey:@"s_cat_id"] forKey:@"cat_id"];
   
    [WebService call_API:dict andURL:API_PROVIDERS_DETAILS andImage:nil andImageName:nil andFileName:nil OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {

        NSMutableDictionary *providerDetails = [response valueForKey:@"provider_details"];
        portfolioArray = [providerDetails valueForKey:@"portfolio"];
        [self.collectionView reloadData];
    }];
}

#pragma mark - Image Picker Delegate Methods
#pragma mark -

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[NSUD valueForKey:@"pro_id"] forKey:@"pro_id"];
    
    //Image Upload Webservice
    [WebService call_API:dic andURL:API_ADD_PORTFOLIO_IMAGE andImage:image andImageName:@"image" OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status) {
        
        if ([[response valueForKey:@"status"] isEqualToString:@"true"]) {
            _AlertView_WithOut_Delegate(@"Message", [response valueForKey:@"message"], @"OK", nil);
            portfolioArray = [response valueForKey:@"portfolio"];
            [self.collectionView reloadData];
        }
        else
        {
            _AlertView_WithOut_Delegate(@"Message", [response valueForKey:@"message"], @"OK", nil);
        }
    }];
    [self.collectionView reloadData];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Collection View Delegate Methods
#pragma mark -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return portfolioArray.count+1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PortfolioCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if(portfolioArray.count==indexPath.row)
    {
        cell.imgView.image = [UIImage imageNamed:@"add_img"];
    }
    else
    {
        NSMutableDictionary *dic = [portfolioArray objectAtIndex:indexPath.row];
        [cell.imgView setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"pp_image"]]   placeholderImage:[UIImage imageNamed:@"big_default_img.png"]];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handelTapGestureRecognizer:)];
         [cell.imgView addGestureRecognizer:tapGR];
        tapGR.numberOfTapsRequired = 1;
    }
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2; // This is the minimum inter item spacing, can be more
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *lastIndex = [self indexPathForLastRow];

    if(lastIndex.row==indexPath.row)
    {
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:nil      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                    message:nil
                                    preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* button0 = [UIAlertAction
                                  actionWithTitle:@"Cancel"
                                  style:UIAlertActionStyleCancel
                                  handler:^(UIAlertAction * action)
                                  {
                                      //  UIAlertController will automatically dismiss the view
                                  }];
        
        UIAlertAction* button1 = [UIAlertAction
                                  actionWithTitle:@"Take Photo From Camera"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      //  The user tapped on "Take a photo"
                                      UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                      imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                      imagePickerController.delegate = self;
                                      [self presentViewController:imagePickerController animated:YES completion:^{}];
                                  }];
        
        UIAlertAction* button2 = [UIAlertAction
                                  actionWithTitle:@"Take Photo From Gallery"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      //  The user tapped on "Choose existing"
                                      UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                      imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                      imagePickerController.delegate = self;
                                      imagePickerController.allowsEditing = YES;
                                      [self presentViewController:imagePickerController animated:YES completion:^{}];
                                  }];
        
        [alert addAction:button0];
        [alert addAction:button1];
        [alert addAction:button2];
        
        [self presentViewController:alert animated:YES completion:nil];
    }

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
        return CGSizeMake(((collectionView.frame.size.width/2)-25), ((collectionView.frame.size.width/2)-25));
}


#pragma  mark - Show / Hide Full Story Image
#pragma  mark -

-(void)handelTapGestureRecognizer:(UITapGestureRecognizer *)sender{
    
    UIImageView *imgView = (UIImageView *)sender.view;
    
    [UUImageAvatarBrowser showImageForZoomView:self withImage:imgView];
    
}



-(void)show_FullStoryImage:(UIButton *)sender{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0]; // if section is 0
    
    PortfolioCVCell *cell = (PortfolioCVCell*)[_collectionView cellForItemAtIndexPath:indexPath];
    //[UUImageAvatarBrowser showImage:cell.imgView_Story];
    [UUImageAvatarBrowser showImageForZoomView:self withImage:cell.imageView];
    
}

#pragma mark - Get Last Cell Index
#pragma mark - 

-(NSIndexPath *)indexPathForLastRow
{
    NSInteger section = [self numberOfSectionsInCollectionView:self.collectionView] - 1;
    NSInteger item = [self collectionView:self.collectionView numberOfItemsInSection:section] - 1;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
    return lastIndexPath;
}


#pragma mark - Open Service View
#pragma mark -

- (void)showServices:(id)sender {
    ProfessionalServicesVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalServicesVC"];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - Open Recommendation View
#pragma mark -

- (void)showRecommdation:(id)sender {
    ProfessionalRecommendationVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalRecommendationVC"];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - Open Info View
#pragma mark -

- (void)showInfo:(id)sender {
    ProfessionalInfoVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalInfoVC"];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - Open Porfolio View
#pragma mark -

- (void)showPortfolio:(id)sender {
    PortfolioVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PortfolioVC"];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - Open Bank Details View
#pragma mark -

- (void)showBankDetails:(id)sender {
    ProfessionalBankDetailsVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfessionalBankDetailsVC"];
    [self.navigationController pushViewController:vc animated:NO];
}
@end

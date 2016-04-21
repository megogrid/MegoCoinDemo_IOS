//
//  Historyclass.h
//
//  Created by David on 7/13/15.
//

#import <UIKit/UIKit.h>





/*!
 @class         MewardHistoryclasss
 @brief         The ViewController class
 @discussion    This class is designed and implemented for history of purchase Campaigns  .
 @superclass    SuperClass: UIViewController\n
 @classdesign   No special design is applied here.
 @helps         It helps no other classes.
 @helper        NO helper exists for this class.
 */


@interface MegoHistoryclasss : UIViewController
{
    UIView               *MainView;
   
    NSMutableArray       *RequestParamArray;
    NSMutableArray       *TabArray;
    NSMutableArray       *ThemeDataArray;
    CGRect               collectionRect;
    UICollectionView     *ThemeCollectionView;
    UICollectionViewFlowLayout *layout;
    NSString              *myimage;
    NSMutableArray        *Buttonimage;
    UIImageView           *Header;
    UIView                *myview;
   
}

/*!
 @brief this method is used for fetch Campaigns history list.
 @remark This is a super method for ask from the server for history Campaigns list .
 */
-(void)AuthenticationServiceSuccessHandller;

/*!
 @brief this method tell the user to get all history Campaigns list.
 @remark This is a super method for save  history Campaigns list that come from the server .
 */
-(void)ServiceSuccessHandller:(NSData*)data;

/*!
 @brief this method tell the user for warnings.
 */
-(void)ServieFailedHandller:(NSString*)ErrorDescription;




@property(nonatomic,strong)NSString *myName;
@property(nonatomic,strong)NSString*colorString;

@property(nonatomic,strong)UIImage *myImage;
@property(nonatomic)int myThemeType;
@property(nonatomic,strong)NSMutableArray *TableImages;
@property(nonatomic,strong)NSMutableArray *Buttonimage;
-(void)GetHeader:(NSString *)GetCreditvalue;
@end

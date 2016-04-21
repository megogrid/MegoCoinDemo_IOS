//
//
//  Created by David-iphone on 7/9/15.
//

#import <UIKit/UIKit.h>
#import "HistorySegmentedHeader.h"
#import "MegoHistoryCredit.h"
#import "MegoHistoryServerModel.h"


//@class MewardCreditclass;


/*!
 @typedef NSViewtype
 @brief   A enum about type of Campaigns permotion .
 @discussion The values of this enum represent how many type to permote your product .
*/
typedef enum _viewtype
{
    /*! Banner View */
    Banner= 0,
     /*! Application View */
    Application = 1,
     /*! Text View*/
    Text=2,
    /*! TextICON View */
    TextICON=3,
   
    
} NSViewtype;


/*!
 @typedef NSButtontype
 @brief   A enum about how to permote Campaigns  .
 @discussion The values of this enum represent  a way  to permote your product .
 */
typedef enum _Buttontype
{
    /*! Action*/
    Action= 0,
     /*! Install */
    Install = 1,
     /*! Share*/
    Share =2,
     /*! Twoway Share */
    share1=5,
     /*! Videos */
    Videos=3,
    
} NSButtontype;


extern NSViewtype viewtype;
extern NSButtontype Buttontype;



/*!
 @class         HistoryGetCredits
 @brief         The ViewController class
 @discussion    This class is designed and implemented  for palce a uiview at collection cells that are make in MewardCreditclass .
 @superclass    SuperClass: UIViewController\n
 @classdesign   No special design is applied here.
 @helps         It helps no other class.
 @helper        MeWardServerModel helper exists for responses from the server side.
 */

@interface HistoryGetCredits : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
   
    UIView                 *MainView;
    HistorySegmentedHeader   *GetcreditsClassObj;
    MegoHistoryCredit      *dataView;
    NSMutableArray         *RequestParamArray;
    NSMutableArray         *TabArray;
    CGRect                 collectionRect;
    UICollectionView       *ThemeCollectionView;
    NSString               *myimage;
    NSMutableArray         *Buttonimage;
    UIImageView            *Header;
    UIView                 *myview;
   
    UILabel                *GetCrdtvalue;
    UILabel                *GetCredit;
    UIView                 *segmentview;
   
    UICollectionViewFlowLayout      *layout;

   
}



/*!
 @brief this method to update the coin the user coins.
   @remark This is a super method for update coin .
 */
-(void)CoinUpdated:(NSDictionary*)Response;

/*!
 @brief this method is used for fetch Campaigns list.
 @remark This is a super method for ask from the server for Campaigns list .
 */
-(void)AuthenticationServiceSuccessHandller;
/*!
 @brief this method tell the user to get all Campaigns for permotion  .
 @remark This is a super method for save  Campaigns list that come from the server .
 */
-(void)ServiceSuccessHandller:(NSData*)data;

/*!
 @brief this method tell the user for warnings.
 */
-(void)ServieFailedHandller:(NSString*)ErrorDescription;




@property (strong, nonatomic) MegoHistoryServerModel *ObjMewardServerModel;

@property(nonatomic,strong)NSString *myName;
@property(nonatomic,strong)UIImage *myImage;
@property(nonatomic)int ItemType;
@property(nonatomic)int Buttontype;
@property(nonatomic)int myThemeType;
@property(nonatomic,strong)NSMutableArray *TableImages;
@property(nonatomic,strong)NSMutableArray *Buttonimage;
@property(nonatomic,retain)NSMutableArray  *ThemeDataArray;
-(void)GetHeader:(NSString *)GetCreditvalue;
@end

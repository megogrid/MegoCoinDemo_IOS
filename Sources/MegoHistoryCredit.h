//
//
//  Created by David on 7/10/15.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MegoHistoryServerModel.h"

/*!
  @protocol ButtonClickDelegate
  @brief This is Campagion list  protocol
  @discussion When click at download,share and action  button Campaigns list open landing page .
 */
@protocol ButtonClickDelegate <NSObject>
@required
-(void)ButtonClick:(UIButton*)Button;
@end


/*!
 @class         MewardHistoryCredit
 @brief         The UIView class
 @discussion    This class is designed and implemented  for the  User Interface .
 @superclass    UIView
 @classdesign   No special design is applied here.
 @helps         It helps no other classes.
 @helper        MeWardServerModel  helper exists for this class.
 */


@interface MegoHistoryCredit : UIView<UIGestureRecognizerDelegate>
{
    UIImageView *viewImage;
    MegoHistoryServerModel *DownloadImage;
}

@property(nonatomic)BOOL IsThumbnailLoaded;
@property(retain,nonatomic,readwrite)UIView *creditview;
@property(nonatomic,strong)NSString *CreditName;
@property(nonatomic,strong)NSString *CreditDescription;
@property(nonatomic,strong)UIImage *CreditImage;
@property(nonatomic,strong)NSString *CoinsCount;
@property(nonatomic,strong)UIImage *DollarImage;
@property(nonatomic,strong)NSString *CreditDollarCount;
@property(nonatomic,strong)UIImage *buttonImage;
@property(nonatomic,strong)NSString *HistoryName;
@property(nonatomic,strong)NSString *HistoryDate;
@property(nonatomic,strong)UIImage *HistoryImage;
@property(nonatomic,strong)NSString *InAppId;
@property(nonatomic,strong)NSString *CampaignID;
@property(nonatomic,strong)NSString *HistoryShareCount;
@property(nonatomic)int ItemType;
@property(nonatomic)int Buttontype;
@property(nonatomic)int HistoryButtontype;
@property(nonatomic)int LandingPageStatus;
@property(nonatomic,strong)  NSString* PackageId;
@property(nonatomic,strong)NSDictionary *Landingloading_page_template;
@property(nonatomic,strong)NSString *DeepLinkUrl;
@property(nonatomic,strong)NSString *ImageUrl;
@property(nonatomic,strong)NSString *ContentUrl;
@property(nonatomic,strong)NSString *contenttype;
@property(nonatomic,strong)NSString *RedeemedName;
@property(nonatomic,strong)NSString *RedeemedDate;
@property(nonatomic,strong)UIImage *RedeemedImage;
@property(nonatomic,strong)NSString *RedeemedShareCount;
@property (strong) id <ButtonClickDelegate>ButtonClickDelegate;
@property(nonatomic,strong)NSString *HeaderName;
@property(nonatomic,strong)UIImage *HeaderImage;
@property(nonatomic,strong)NSString *HeaderShareCount;


/*!
 @brief this method is used for create a  Meward Cross Promotion Campaigns.
 @param pass some initial value to a method for Meward Campaigns list.
 @return It return uiview that place at table view cell.
 @code
return [[MewardHistoryCredit alloc]initWithgetCredit:CreditName CreditDescription:CreditDescription  CreditShareCount:CreditShareCount CreditImage:CreditImage headerColor:headerColor  itemtype:itemtype Buttontype:Buttontype];
 @endcode
 @remark This is a super method for Meward Campaigns list .
 */



+ (id)dataWithgetCredit:(NSString *)CreditName CreditDescription:(NSString *)CreditDescription  CreditShareCount:(NSString*)CreditShareCount CreditImage:(UIImage*)CreditImage headerColor:(NSString *)headerColor itemtype:(int)itemtype Buttontype:(int)Buttontype;



/*!
 @brief this method is used for create a  Meward Cross Promotion Campaigns history list.
 @param pass some initial value to a method for Meward Campaigns  history  list.
 @return It return uiview that place at table view cell.
 @code
   return [[MewardHistoryCredit alloc]initWithHistory:HistoryName HistoryDate:HistoryDate  HistoryShareCount:HistoryShareCount HistoryImage:HistoryImage headerColor:headerColor HistoryButtontype:HistoryButtontype];
 @endcode
 @remark This is a super method for Meward Campaigns history list .
 */

+ (id)dataWithHistory:(NSString *)HistoryName HistoryDate:(NSString *)HistoryDate  HistoryShareCount:(NSString*)HistoryShareCount HistoryImage:(UIImage*)HistoryImage headerColor:(NSString *)headerColor HistoryButtontype:(int)HistoryButtontype;



+ (id)dataWithBuyCredit:(NSString*)CreditShareCount CreditDollarCount:(NSString*)CreditDollarCount DollarImage:(UIImage*)DollarImage;

+ (id)dataWithRedeemed:(NSString *)RedeemedName RedeemedDate:(NSString *)RedeemedDate  RedeemedShareCount:(NSString*)RedeemedShareCount RedeemedImage:(UIImage*)RedeemedImage ;

+ (id)dataWithHeaderRedeemed:(NSString *)HeaderName HeaderShareCount:(NSString*)HeaderShareCount HeaderImage:(UIImage*)HeaderImage ;



-(void)DownloadImage;



@end

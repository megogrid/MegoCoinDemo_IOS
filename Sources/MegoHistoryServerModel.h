//
//
//  Created by David on 7/13/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@protocol MegoServerDataHandller
@required
-(void)ServiceSuccessHandller:(NSData*)Response;
-(void)ServieFailedHandller:(NSString*)ErrorDescription;
-(void)getImage:(UIImage*)DownloadedImage;
-(void)CoinUpdated:(NSDictionary*)Response;
-(void)ConfigHandller:(NSDictionary*)Response;
-(void)Authenticated:(NSString*)tokenKey;
-(void)AuthenticationServiceSuccessHandller;
-(void)RecivegiftHandler:(NSDictionary*)Response;
-(void)SendgiftHandler:(NSDictionary*)Response;
-(void)NotifyActionHandler:(NSDictionary*)Response;
@end

/*!
 @class         MeWardHistoryServerModel
 @brief         The NSObject class
 @discussion    This class is designed and implemented for send a request to server and get response from the server  .
 @classdesign   This class is design for Spically  to handle server request from the server and from the user.
 @helps         It helps no other classes.
 @helper        No helper exists for this class.
 */
@interface MegoHistoryServerModel : NSObject
{
   
}

@property (strong, nonatomic) id <MegoServerDataHandller> _delegate;
@property(nonatomic,strong)NSString *AppID;
@property(nonatomic,strong)NSString *AppSecrate;
@property(nonatomic,strong)NSString *DeveloperID;
@property(nonatomic,strong)NSString *ServerPath;
@property(nonatomic,strong)NSString *AuthenticationServerPath;
@property(nonatomic,strong) NSString *devicetoken;
@property(nonatomic,strong)NSString  *campname;
@property(nonatomic,strong)NSString *MinGiftValue;
@property(nonatomic)int IsAllowGifting;
@property(nonatomic,strong)NSString *MewardID;
@property(nonatomic,strong)NSString *AppTokenKey;
@property(nonatomic,strong)NSString *AppInstallationDate;
@property(nonatomic,strong)NSString *AppDataSavedKey;
@property(nonatomic,strong)NSString *MewardCoinblanaceKey;




-(void)FetchCampaigns;
-(void)SingleImageDownloadService:(NSString*)ImageUrl;
-(NSMutableArray*)ParseJsonToInstallShareView:(NSData*)data;
-(void)FetchCreditsToPurchase;
-(NSString*)GetRemainingCoinBalance;
-(void)SaveandUpdateCoinBalance;
-(void)GetDataFromLocalBundle :(NSString*)File;
-(void)FetchEarnedHistory;
-(void)FetchReadeamPointsDetails;
-(void)SaveRemainingCoin:(NSString*)UsersCoinBalance;
-(void)GetPurchasableCoinList;
-(void)UpdateCointoServer:(NSString*)PackageId CampaignId:(NSString*)CampaignId Coins:(NSString*)Coins type:(NSString*)type  type1:(NSString*)type1;
-(void)InitializeMewardConfig;
-(void)SendGift:(NSString*)EmailId CreditsPoints:(NSString*)CreditsPoints;
-(void)ReceiveGift:(NSString*)promoCode;
-(void)NotifyAction:(NSString*)eventId :(NSDictionary*)DicConditions;
-(void)GetCreditBalance;
-(NSMutableArray*)ParseJsonEarnedHistoryView:(NSData*)data;
-(NSMutableArray*)ParseJsonBuyView:(NSData*)data;
-(NSMutableArray*)ParseReadeamedPointsView:(NSData*)data;
+(void)NotifyInstallRefferal:(NSString*)RefferalDetails;

+(UIImage*)getImageFromBundle:(NSString*)imageName;





-(void)GetCampaigns;
-(void)GetCampaignsForUser;
-(void)AppDataParser:(NSDictionary*)Json;
-(void)IntializeSDK;




@end

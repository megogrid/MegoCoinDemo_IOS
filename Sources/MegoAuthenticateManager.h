//
//  ServerJsonModel.h
//  MigitalStoreSDK
//
//  Created by David on 2/16/15.
//

#import <Foundation/Foundation.h>

@protocol ServerDataHandller
@required
-(void)AuthenticationSuccess;
-(void)ServiceSuccessHandller:(NSString*)Response;
-(void)ServieFailedHandller:(NSError*)ErrorDescription;
-(void)GethostHandller;

@end

@interface MegoAuthenticateManager:NSObject
{
    NSURLConnection *conn;
    NSData *resumeSavedData;
    NSDictionary *plistData;
}


@property(nonatomic,strong)NSString *AppID;
@property(nonatomic,strong)NSString *AppSecret;
@property(nonatomic,strong)NSString *DeveloperID;
@property(nonatomic,strong)NSString *ServerPath;
@property(nonatomic,strong)NSString *MewardID;
@property(nonatomic,strong)NSString *AppTokenKey;
@property(nonatomic,strong)NSString *AppInstallationDate;
@property(nonatomic,strong)NSString *AppDataSavedKey;

@property(nonatomic,strong)NSError *MegoErrors;
@property(nonatomic,strong)NSMutableDictionary *MegoErrorDic;


@property(nonatomic)bool IsAuthenticated;

@property (strong, nonatomic) id <ServerDataHandller> _delegate;

-(void)AuthenticateUser;
-(void)GetHost;



@end




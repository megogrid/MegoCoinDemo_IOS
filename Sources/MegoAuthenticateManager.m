//
//  ServerJsonModel.m
//  MigitalStoreSDK
//
//  Created by David on 2/16/15.
//  Copyright (c) 2015 migital. All rights reserved.
//



#import "MegoAuthenticateManager.h"
#import "MegoGridSDKManager.h"




extern BOOL IsTestingModeEnable;

@interface MegoAuthenticateManager()
{
    
}

@end
@implementation MegoAuthenticateManager

- (id)init
{
    self = [super init];
    if (self)
    {
        
        NSMutableArray *appSecretKey=[[NSUserDefaults standardUserDefaults]objectForKey:@"meuserAppSecretKey"];
        _MegoErrorDic=[[NSMutableDictionary alloc]init];
        if([appSecretKey count]>0)
        {
            self.AppID= [appSecretKey objectAtIndex:0];
            self.AppSecret= [appSecretKey objectAtIndex:1];
            self.DeveloperID=[appSecretKey objectAtIndex:2];
        }
        else
        {
            NSString *path = [[NSBundle mainBundle] bundlePath];
            NSString *finalPath = [path stringByAppendingPathComponent:@"Info.plist"];
            
            plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
            self.DeveloperID = [plistData objectForKey:@"DevID"];
            self.AppID = [plistData objectForKey:@"AppID"];
            self.AppSecret = [plistData objectForKey:@"SecretKey"];
        
        
        }
        
    
    }
    return self;
}




-(void)GetHost
{
    NSError *error =nil;
    
    //{"action":"GetHostName","devid":"1","appid":"JXEYZAV8B","secretkey":"PZE76ZHZ7"}


    if (!self.AppID) {
         [_MegoErrorDic setValue:@"please fill AppID in info.plist" forKey:@"AppID" ];
         _MegoErrors= [NSError errorWithDomain:@"please fill AppID in info.plist" code:6001 userInfo:_MegoErrorDic];
        
         [__delegate ServieFailedHandller:_MegoErrors];
        
         return;
    }
    if (!self.AppSecret ) {
        
        [_MegoErrorDic setValue:@"please fill AppID in info.plist" forKey:@"AppID" ];
        _MegoErrors= [NSError errorWithDomain:@"please fill AppID in info.plist" code:6002 userInfo:_MegoErrorDic];
        
        [__delegate ServieFailedHandller:_MegoErrors];
        return;
    }
    if (!self.DeveloperID) {
        
        [_MegoErrorDic setValue:@"please fill AppID in info.plist" forKey:@"AppID" ];
        _MegoErrors= [NSError errorWithDomain:@"please fill AppID in info.plist" code:6003 userInfo:_MegoErrorDic];
        
        [__delegate ServieFailedHandller:_MegoErrors];
        return;
    }
   
    
    NSMutableDictionary *dictionaryJSON = [[NSMutableDictionary alloc]init];
    [dictionaryJSON setObject:@"GetHostName" forKey:@"action"];
    [dictionaryJSON setObject:self.DeveloperID forKey:@"devid"];
    [dictionaryJSON setObject:self.AppID forKey:@"appid"];
    [dictionaryJSON setObject:self.AppSecret forKey:@"secretkey"];
    NSData* postData = [NSJSONSerialization dataWithJSONObject:dictionaryJSON options:kNilOptions error:&error];
    NSString *PostString= [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"jason====%@",PostString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://gethost.megogrid.com/host_manager/HostName/GetHostName"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"json" forHTTPHeaderField: @"Content-Type"];
    [request setHTTPBody:postData];
    [request setTimeoutInterval:10];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if(!connectionError)
         {
             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
             
             if(httpResponse.statusCode==200)
             {
                 if(data.length)
                 {
                     NSError* error;
                     NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions  error:&error];
                                          
                     [[NSUserDefaults standardUserDefaults]setObject:[json objectForKey:@"serverlinks"] forKey:@"MewoServerLink"];
                     
                     
                     [[NSUserDefaults standardUserDefaults]setObject:[json objectForKey:@"version"]forKey:@"MewoVersion"];
                     [[NSUserDefaults standardUserDefaults]synchronize];
                      [__delegate GethostHandller];
                 }
                 
                 else
                 {
                     
                     
                     [_MegoErrorDic setValue:[connectionError description] forKey:@"connectionError"];
                      _MegoErrors= [NSError errorWithDomain:@"Invalid Responce from MegoAuth Server" code:6004 userInfo:_MegoErrorDic];
                     

                     
                     [__delegate ServieFailedHandller:_MegoErrors];
                     return ;

                     
                 }
             }
             
             else
             {
                 [_MegoErrorDic setValue:[connectionError description] forKey:@"connectionError"];
                 _MegoErrors= [NSError errorWithDomain:@"Mego Server Error" code:6005 userInfo:_MegoErrorDic];
                 [__delegate ServieFailedHandller:_MegoErrors];return ;             }
            }
             else
                 
             {
                 [_MegoErrorDic setValue:[connectionError description] forKey:@"connectionError"];
                 _MegoErrors= [NSError errorWithDomain:@"The Internet connection appears to be offline" code:6006 userInfo:_MegoErrorDic];
                 [__delegate ServieFailedHandller:_MegoErrors];return ;
             }
     }];
    
}




-(void )CacheAppData:(NSString*)key :(id)Value
{
    [MegoGridSDKManager.ApplicationDataCache setObject:Value forKey:key];
}

-(id)GetCachedAppData:(NSString*)key
{
    NSData *ResponseData=[MegoGridSDKManager.ApplicationDataCache objectForKey:key];
    return ResponseData;
}

-(NSString*)GetTimeZone
{
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSString *tzName = [sourceTimeZone name];
    return  tzName;
}
-(NSString*)GetCountryCode
{
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    return countryCode;
}


-(NSString*)NetworkConnectionType
{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetworkItemView = nil;
    NSString *ConnectionType = nil;
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]])
        {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue]) {
        case 0:
            ConnectionType=@"no wifi or cellular";
            break;
            
        case 1:
            ConnectionType=@"2g";
            break;
            
        case 2:
            ConnectionType=@"3g";
            break;
            
        case 3:
            ConnectionType=@"4g";
            break;
            
        case 4:
            ConnectionType=@"lte";
            break;
            
        case 5:
            ConnectionType=@"wifi";
            break;
            
        default:
            break;
    }
    return ConnectionType;
}


-(void)AuthenticateUser
{

    NSString *IOSVersion=[[UIDevice currentDevice] systemVersion];
    NSLog(@"IOSVersion-->%@", IOSVersion);
    
    if (!self.AppID) {
        
        [_MegoErrorDic setValue:@"please fill AppID in info.plist" forKey:@"AppIDKey" ];
        _MegoErrors= [NSError errorWithDomain:@"please fill AppID in info.plist" code:6001 userInfo:_MegoErrorDic];
        [__delegate ServieFailedHandller:_MegoErrors];
        return;
    }
    if (!self.AppSecret ) {
        
        [_MegoErrorDic setValue:@"please fill Secret in info.plist" forKey:@"SecretKey" ];
        _MegoErrors= [NSError errorWithDomain:@"please fill Secret in info.plist" code:6002 userInfo:_MegoErrorDic];
        [__delegate ServieFailedHandller:_MegoErrors];
        return;
    }
    if (!self.DeveloperID) {
        
        [_MegoErrorDic setValue:@"please fill DevID in info.plist" forKey:@"DevIDKey" ];
        _MegoErrors= [NSError errorWithDomain:@"please fill DevID in info.plist" code:6003 userInfo:_MegoErrorDic];;
        [__delegate ServieFailedHandller:_MegoErrors];
        return;
    }

    NSString*deviceID=nil;
    deviceID=[[NSUserDefaults standardUserDefaults]objectForKey:@"deviceIdKey"];
    
    
    if (deviceID==nil) {
        deviceID=@"missing";
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    NSString *ISO639_1LanguageCode = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    NSMutableDictionary *JasonDictionary=[[NSMutableDictionary alloc]init];
    [JasonDictionary setObject:self.AppID forKey:@"appid" ];
    [JasonDictionary setObject:self.AppSecret forKey:@"secretkey"];
    [JasonDictionary setObject:[self GetTimeZone] forKey:@"timezone"];
    [JasonDictionary setObject:deviceID forKey:@"deviceid" ];
    //[JasonDictionary setObject:@"3BCF082B-7B7B-45B1-9322-28EC37F2A33D" forKey:@"macid"];
    [JasonDictionary setObject:[self GetUdid] forKey:@"macid"];
    [JasonDictionary setObject:@"iPhone" forKey:@"os"];
    [JasonDictionary setObject:self.DeveloperID forKey:@"devid" ];
    [JasonDictionary setObject:@"6" forKey:@"store" ];
    [JasonDictionary setObject:[self GetCountryCode] forKey:@"countrycode"];
    [JasonDictionary setObject:IOSVersion forKey:@"osversion"];
    [JasonDictionary setObject:[self NetworkConnectionType] forKey:@"connectiontype"];
    [JasonDictionary setObject:@"Authentication" forKey:@"action"];
    [JasonDictionary setObject:ISO639_1LanguageCode forKey:@"language"];
    [JasonDictionary setObject:[NSString stringWithFormat:@"%f",screenWidth] forKey:@"width"];
    [JasonDictionary setObject:[NSString stringWithFormat:@"%f",screenHeight] forKey:@"height"];
    

    NSError *error =nil;
    NSData* postData = [NSJSONSerialization dataWithJSONObject:JasonDictionary options:kNilOptions error:&error];
    NSString *PostString= [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"jason====%@",PostString);
    
    NSMutableDictionary *serverpath = [[NSUserDefaults standardUserDefaults]valueForKey:@"MewoServerLink"];
    self.ServerPath = [serverpath objectForKey:@"unified"];
    self.ServerPath = [self.ServerPath stringByAppendingString:@"/MasterService/megogrid"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.ServerPath]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"json" forHTTPHeaderField: @"Content-Type"];
    [request setHTTPBody:postData];
    [request setTimeoutInterval:120];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if(!connectionError)
         {
             
             {
                 if(data.length)
                 {
                    // NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                     //NSLog(@"response==%@",str);
                     {
                         NSError* error;
                         NSDictionary* json = [NSJSONSerialization
                                               JSONObjectWithData:data
                                               options:kNilOptions
                                               error:&error];
                         {
                              [[NSUserDefaults standardUserDefaults]setObject:json forKey:@"MewoCredentials"];
                              [[NSUserDefaults standardUserDefaults]synchronize];
                            
                             //NSLog(@"value of json 1%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"MewoServerLink"]);
                             //NSLog(@"value of json 2%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"MewoVersion"]);
                             //NSLog(@"value of json 3%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"MewoCredentials"]);
                            
                             NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
                            
                             [dataDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"MewoServerLink"] forKey:@"mewoserverlink"];
                            
                             [dataDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"MewoVersion"] forKey:@"mewoversion"];
                             
                             [dataDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"MewoCredentials"] forKey:@"mewocredentials"];
                           
                              [dataDict setObject:[NSNumber numberWithBool:[self isMeuserLogin]] forKey:@"MeuserAuthentication"];


                             NSLog(@"MewoCredentials Details===%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"MewoCredentials"]);
                             
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"Authenticated" object:dataDict userInfo:nil];
                             
                             
                         }
                         
                     }
                 }
                    else
                      {   
                          [_MegoErrors setValue:[connectionError description] forKey:@"connectionError"];
                          
                          _MegoErrors= [NSError errorWithDomain:@"Mego Server Error"code:6004 userInfo:_MegoErrorDic];
                          
                          [__delegate ServieFailedHandller:_MegoErrors];
                          return;
                       }
             }
         }
         
         
         else
         {
             [_MegoErrors setValue:[connectionError description] forKey:@"connectionError"];
             
             _MegoErrors= [NSError errorWithDomain:@"The Internet connection appears to be offline" code:6005 userInfo:_MegoErrorDic];
             [__delegate ServieFailedHandller:_MegoErrors];
             return;
         }
    }];
  
}


-(BOOL)isMeuserLogin{
    
    BOOL isLogin=[[NSUserDefaults standardUserDefaults]boolForKey:@"meUserIsUserLogin"];
    
    if (isLogin) {
        
        return TRUE;
    }else{
        
        return FALSE;
        
    }
}

-(NSString *)GetUdid
{
    NSString *udid=nil;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)])
    {
        
        udid =[[[UIDevice currentDevice] identifierForVendor] UUIDString];
       
    }
    else
    {
        
        NSString *getId=[[NSUserDefaults standardUserDefaults]objectForKey:@"UIDID"];
        
        if (getId==nil)
        {
            CFUUIDRef identifierObject = CFUUIDCreate(kCFAllocatorDefault);
            NSString *identifierString = ( NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, identifierObject));
            CFRelease((CFTypeRef) identifierObject);
            udid=identifierString;
            [[NSUserDefaults standardUserDefaults]setObject:identifierString forKey:@"UIDID"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else
        {
            udid=getId;
        }
    }
        return udid;
}


@end

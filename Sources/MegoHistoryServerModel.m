
#import "MegoHistoryServerModel.h"
#import "MegoHistoryCredit.h"
#import "SDKHistoryManager.h"
#import "MegoHistroyAccounts.h"
#import "HistoryGetCredits.h"


@implementation MegoHistoryServerModel

{
    NSDictionary *DicThemeItem1;
    NSString* updateCoins ;
    NSDictionary *plistData;
    NSString *Ip;
}




- (id)init
{
    self = [super init];
    
    if (self)
    {
        NSLog(@"INITT");
        _AppDataSavedKey=@"MeWardData";
        _MewardCoinblanaceKey=@"RemainingKey";
        
        
    }
    return self;
}

-(void)IntializeSDK
{
    NSLog(@"IntializeSDK");
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"Authenticated" object:nil];
}



- (void)receiveNotification:(NSNotification *) notification
{
    
    
      NSLog(@"POST ");
     MegoHistroyAccounts *acc=[[MegoHistroyAccounts alloc]init];
     NSLog(@"ACCCC=%@",acc);
     NSLog(@"_AppDataSavedKey==%@",_AppDataSavedKey);
     NSLog(@"_MewardCoinblanaceKey==%@",_MewardCoinblanaceKey);
    
     [[NSUserDefaults standardUserDefaults] setObject:@"http://mgservices.migsites.com/me_wards/Mewards/mewards"forKey:@"ServerPath"];
     [[NSUserDefaults standardUserDefaults] setObject:@"http://mgservices.migsites.com/MasterService/megogrid"forKey:@"AuthenticationServerPath"];
    
    
    if([[notification name] isEqualToString:@"Authenticated"])
    {
    
          NSDictionary *dict = [notification object];
        
          NSLog(@"FULL DICT===%@",dict);
        
          NSMutableDictionary *mewocredentials=[dict valueForKey:@"mewocredentials"];
        
          NSLog(@"DICT1===%@", mewocredentials);
        
        if( [[NSUserDefaults standardUserDefaults] objectForKey:_AppDataSavedKey]==nil)
        {
        
          [self AppDataParser:mewocredentials];
        }
        
        else
        {
            
             NSLog(@"ELSE");
            [self AppDataParser:mewocredentials];
            [self GetMewardConfig];
            
        }
        
          NSLog(@"SAVE IN DEFAULT");
         [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"mewocredentials"]forKey:_AppDataSavedKey];
          NSLog(@"SAVE VALUE=%@",[[NSUserDefaults standardUserDefaults] objectForKey:_AppDataSavedKey]);
        
    }
    
    else
        
    {
         NSLog(@"FATAAAAA");
    }
    
}





-(void )CacheAppData:(id)key :(id)Value
{
    [SDKHistoryManager.ApplicationDataCache setObject:Value forKey:key];
}

-(id)GetCachedAppData:(id)key
{
    NSData *ResponseData=[SDKHistoryManager.ApplicationDataCache objectForKey:key];
    return ResponseData;
}



-(NSString*)GetCountryCode
{
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    return countryCode;
}



-(void)AppDataParser:(NSDictionary*)json
{
    NSLog(@"AppDataParser");
    self.AppTokenKey=[json objectForKey:@"tokenkey"];
    self.MewardID=[json objectForKey:@"mewardid"];
    self.AppInstallationDate=[json objectForKey:@"app_installed_date"];
    if([[NSUserDefaults standardUserDefaults] objectForKey:_AppDataSavedKey]!=nil)
    {
        
        [self FetchCreditsPointsBalanceFromServer];
    }
    
    [__delegate AuthenticationServiceSuccessHandller];
    
     NSLog(@"OUT AppDataParser");
}



-(void)FetchCreditsPointsBalanceFromServer
{
    
    [self  GetCreditBalance];
}

-(void)GetCreditBalance
{
    NSMutableDictionary *dictionaryJSON=[[NSMutableDictionary alloc]init];
    [dictionaryJSON setObject:self.MewardID  forKey:@"mewardid" ];
    [dictionaryJSON setObject:self.AppTokenKey forKey:@"tokenkey" ];
    [dictionaryJSON setObject:@"Getcoins" forKey:@"action"];
    NSError *error =nil;
    NSData* postData = [NSJSONSerialization dataWithJSONObject:dictionaryJSON options:kNilOptions error:&error];
    NSString *PostString= [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"jason====%@",PostString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_AuthenticationServerPath]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"json" forHTTPHeaderField: @"Content-Type"];
    [request setHTTPBody:postData];
    [request setTimeoutInterval:120];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if(!connectionError)
                               {
                                   NSString *strResponse=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                   NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                                   if(httpResponse.statusCode==200)
                                   {
                                       
                                       if(data.length)
                                       {
                                           
                                           NSLog(@"Response======%@",strResponse);
                                           NSError* error;
                                           NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions
                                                                                                      error:&error];
                                           
                                           [[NSUserDefaults standardUserDefaults] setObject:[jsonData objectForKey:@"coins"] forKey:_MewardCoinblanaceKey];
                                           [[NSUserDefaults standardUserDefaults]synchronize];
                                           [__delegate CoinUpdated:jsonData];
                                           
                                       }
                                   }
                                   else
                                   {
                                       
                                   }
                               }
                               else
                               {
                                   [__delegate ServieFailedHandller:[connectionError description]];
                                   NSLog(@"Error in connection : %@",[connectionError description]);
                               }
                           }];
}




-(void)GetMewardConfig
{
    
    NSMutableDictionary *JasonDictionary=[[NSMutableDictionary alloc]init];
    [JasonDictionary setObject:@"MewardsConfig" forKey:@"action"];
    [JasonDictionary setObject:self.MewardID  forKey:@"mewardid" ];
    [JasonDictionary setObject:self.AppTokenKey forKey:@"tokenkey" ];
    NSError *error =nil;
    NSData* postData = [NSJSONSerialization dataWithJSONObject:JasonDictionary options:kNilOptions error:&error];
    NSString *PostString= [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"jason====%@",PostString);
    
   
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"ServerPath"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"json" forHTTPHeaderField: @"Content-Type"];
    [request setHTTPBody:postData];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
            if(!connectionError)
            
            {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                if(httpResponse.statusCode==200)
                {
                if(data.length)
                    {
                NSMutableDictionary* ResponseDictionary = [NSJSONSerialization JSONObjectWithData:data
                            options:kNilOptions error:nil];
              
                NSLog(@"value of BeginDownloadService %@",ResponseDictionary);
                        
                        
                        
                        
                self.IsAllowGifting=[[ResponseDictionary objectForKey:@"allowgifting"]intValue];
                self.MinGiftValue=[ResponseDictionary objectForKey:@"mingiftcredits"];
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"allowgifting"];
//                self.IsAllowGifting=1;
                        
                        
                }
            
                else
                {
                    [__delegate ServieFailedHandller:@"Invalid"];
                }
                    
                }
        
            }
                else
                {
                    [__delegate ServieFailedHandller:[connectionError description]];
                     NSLog(@"Error in connection : %@",[connectionError description]);
                }
                 }];
  }




-(void)SendGift:(NSString*)EmailId CreditsPoints:(NSString*)CreditsPoints
{
    
    NSMutableDictionary *JasonDictionary=[[NSMutableDictionary alloc]init];
    
    NSMutableDictionary *meWardTokenDict=[[NSMutableDictionary alloc]init];
    meWardTokenDict =[[NSUserDefaults standardUserDefaults] objectForKey:_AppDataSavedKey];
    _MewardID=[meWardTokenDict objectForKey:@"mewardid"];
    _AppTokenKey=[meWardTokenDict objectForKey:@"tokenkey"];
    
    
    [JasonDictionary setObject:@"SendGift" forKey:@"action"];
    [JasonDictionary setObject:EmailId forKey:@"email"];
    [JasonDictionary setObject:CreditsPoints forKey:@"coins"];
    [JasonDictionary setObject:self.MewardID  forKey:@"mewardid" ];
    [JasonDictionary setObject:self.AppTokenKey forKey:@"tokenkey" ];
    NSError *error =nil;
    NSData* postData = [NSJSONSerialization dataWithJSONObject:JasonDictionary options:kNilOptions error:&error];
    NSString *PostString= [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"jason====%@",PostString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"ServerPath"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"json" forHTTPHeaderField: @"Content-Type"];
    [request setHTTPBody:postData];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        
    if(!connectionError)
    {
         NSString *resposne=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"Response=====%@",resposne);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        
      if(httpResponse.statusCode==200)
          
        {
          if(data.length)
           {
            NSMutableDictionary* ResponseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"value of BeginDownloadService %@",ResponseDictionary);
            [self DuductUserCreditBalance:CreditsPoints];
            [__delegate SendgiftHandler:ResponseDictionary];
            [__delegate CoinUpdated:ResponseDictionary];
            }
            
         else
           {
              [__delegate ServieFailedHandller:@"Invalid"];
           }
            
        }
    else
       {
         [__delegate ServieFailedHandller:@"Failed to send Gift Please try again."];
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"Failed!" message:@"Failed to send Gift, Please try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [Alert show];
       }
       }
    else
     {
        [__delegate ServieFailedHandller:[connectionError description]];
        NSLog(@"Error in connection : %@",[connectionError description]);
    }
                           }];
}


-(void)DuductUserCreditBalance:(NSString*)GiftedCredits
{
    NSString *UsersRemainingPoints=[[NSUserDefaults standardUserDefaults]objectForKey:_MewardCoinblanaceKey];
    NSString *RemainingBalance=[NSString stringWithFormat:@"%d",[UsersRemainingPoints intValue]-[GiftedCredits intValue]];
    [[NSUserDefaults standardUserDefaults]setObject:RemainingBalance forKey:_MewardCoinblanaceKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)UpdateUserCoinCreditBalance:(NSString*)Coins
{
    [[NSUserDefaults standardUserDefaults]setObject:Coins forKey:_MewardCoinblanaceKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


-(void)ReceiveGift:(NSString*)promoCode
{
   
     NSLog(@"ReceiveGift====%@",promoCode);
    NSMutableDictionary *JasonDictionary=[[NSMutableDictionary alloc]init];
    
    
    NSMutableDictionary *meWardTokenDict=[[NSMutableDictionary alloc]init];
    meWardTokenDict =[[NSUserDefaults standardUserDefaults] objectForKey:_AppDataSavedKey];
    _MewardID=[meWardTokenDict objectForKey:@"mewardid"];
    _AppTokenKey=[meWardTokenDict objectForKey:@"tokenkey"];
    
    
    [JasonDictionary setObject:@"ReciveGift" forKey:@"action"];
    [JasonDictionary setObject:promoCode forKey:@"promocode"];
    [JasonDictionary setObject:self.MewardID  forKey:@"mewardid" ];
    [JasonDictionary setObject:self.AppTokenKey forKey:@"tokenkey" ];
    NSError *error =nil;
    NSData* postData = [NSJSONSerialization dataWithJSONObject:JasonDictionary options:kNilOptions error:&error];
    NSString *PostString= [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"jason====%@",PostString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"ServerPath"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"json" forHTTPHeaderField: @"Content-Type"];
    [request setHTTPBody:postData];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    if(!connectionError)
    {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    if(httpResponse.statusCode==200)
    {
    if(data.length)
    {
        NSMutableDictionary* ResponseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
      NSLog(@"value of BeginDownloadService %@",ResponseDictionary);

     [__delegate RecivegiftHandler:ResponseDictionary];
    }
    else
    {
        [__delegate ServieFailedHandller:@"Invalid"];
   }
    }
    else
    {
      [__delegate ServieFailedHandller:@"Invalid"];
    }
    }
    else
    {
     [__delegate ServieFailedHandller:[connectionError description]];
     NSLog(@"Error in connection : %@",[connectionError description]);
    }
        }];
}



-(void)AuthenticationServieFailedHandller:(NSData*)data
{
    UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"@Failed" message:@"Authentication Failed!!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Try Again", nil];
    [Alert show];
}


-(void)FetchEarnedHistory
{
    
    [self FetchEarnedHistoryFromServer];
   
}



-(void)FetchEarnedHistoryFromServer
{
    NSMutableDictionary *dictionaryJSON=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *meWardTokenDict=[[NSMutableDictionary alloc]init];
    

    meWardTokenDict =[[NSUserDefaults standardUserDefaults] objectForKey:@"MewoCredentials"];
    _MewardID=[meWardTokenDict objectForKey:@"mewardid"];
    _AppTokenKey=[meWardTokenDict objectForKey:@"tokenkey"];
    [dictionaryJSON setObject:@"EarnHistory" forKey:@"action"];
    [dictionaryJSON setObject:self.MewardID  forKey:@"mewardid"];
    [dictionaryJSON setObject:self.AppTokenKey forKey:@"tokenkey"];
    [self FetchDataFromServer :dictionaryJSON:[[NSUserDefaults standardUserDefaults] objectForKey:@"AuthenticationServerPath"]];
   
}



-(NSString*)GetRemainingCoinBalance
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:_AppDataSavedKey]!=nil)
    {
      return [[NSUserDefaults standardUserDefaults] objectForKey:_MewardCoinblanaceKey];
    }
    else
    {
        
        return @"0";
    }
}


-(void)SaveRemainingCoin:(NSString*)UsersCoinBalance
{
    [[NSUserDefaults standardUserDefaults] setObject:UsersCoinBalance forKey:_MewardCoinblanaceKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)FetchCreditsToPurchase
{
   
    [self GetPurchasableCoinList];
}

-(void)FetchCampaigns
{
   
        [self GetCampaigns];
}

-(void)GetCampaigns
{
    
    NSMutableDictionary *dictionaryJSON=[[NSMutableDictionary alloc]init];
    
    NSMutableDictionary *meWardTokenDict=[[NSMutableDictionary alloc]init];
    meWardTokenDict =[[NSUserDefaults standardUserDefaults] objectForKey:_AppDataSavedKey];
    _MewardID=[meWardTokenDict objectForKey:@"mewardid"];
    _AppTokenKey=[meWardTokenDict objectForKey:@"tokenkey"];
    NSLog(@"ID TOKEN===%@,%@ ",_MewardID,_AppTokenKey);
    
    [dictionaryJSON setObject:self.MewardID  forKey:@"mewardid" ];
    [dictionaryJSON setObject:self.AppTokenKey forKey:@"tokenkey" ];
    [dictionaryJSON setObject:[self GetCountryCode] forKey:@"countrycode" ];
    [dictionaryJSON setObject:@"GetCampaignList" forKey:@"action"];
     NSLog(@"req %@",dictionaryJSON);
     NSLog(@"req %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ServerPath"]);
    [self FetchDataFromServer:dictionaryJSON:[[NSUserDefaults standardUserDefaults] objectForKey:@"ServerPath"]];
    
}




-(void)UpdateCointoServer:(NSString*)PackageId CampaignId:(NSString*)CampaignId Coins:(NSString*)Coins type:(NSString*)type type1:(NSString *)type1
{
   
    NSMutableDictionary *JasonDictionary=[[NSMutableDictionary alloc]init];
    
    NSMutableDictionary *meWardTokenDict=[[NSMutableDictionary alloc]init];
    meWardTokenDict =[[NSUserDefaults standardUserDefaults] objectForKey:_AppDataSavedKey];
    _MewardID=[meWardTokenDict objectForKey:@"mewardid"];
    _AppTokenKey=[meWardTokenDict objectForKey:@"tokenkey"];
    
    
    
    [JasonDictionary setObject:@"UpdateCoins" forKey:@"action"];
    [JasonDictionary setObject:self.MewardID  forKey:@"mewardid" ];
    [JasonDictionary setObject:self.AppTokenKey forKey:@"tokenkey" ];
    [JasonDictionary setObject:CampaignId forKey:@"campaignid"];
    int coin =[Coins intValue]+[[[NSUserDefaults standardUserDefaults] objectForKey:_MewardCoinblanaceKey ] intValue];
     updateCoins = [@(coin) stringValue];
    [[NSUserDefaults standardUserDefaults] setObject:updateCoins forKey:_MewardCoinblanaceKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSError *error =nil;
    NSData* postData = [NSJSONSerialization dataWithJSONObject:JasonDictionary options:kNilOptions error:&error];
    NSString *PostString= [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"jason====%@",PostString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"ServerPath"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"json" forHTTPHeaderField: @"Content-Type"];
    [request setHTTPBody:postData];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
    if(!connectionError)
    {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
     if(httpResponse.statusCode==200)
    {
      if(data.length)
    {
        NSMutableDictionary* DicResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions  error:nil];
        NSLog(@"Update Coin Response String %@",DicResponse);
    if([[DicResponse objectForKey:@"status"] intValue]== 1)
        
    {
         NSString *msg=[NSString stringWithFormat:@"You have earned %d credits %@ by %@",[Coins  intValue],type1,type];
          UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Wow" message:@"" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
         UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
         lbl.numberOfLines=2;
         lbl.font=[UIFont boldSystemFontOfSize:12];
         NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:msg];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor  colorWithRed:76/255.f green:132/255.f blue:249/255.f alpha:1] range:NSMakeRange(16,12)];
        lbl.attributedText = attributedStr;
        lbl.textAlignment = NSTextAlignmentCenter;
        [alert setValue:lbl forKey:@"accessoryView"];
        [alert show];
        [__delegate CoinUpdated:DicResponse];
        [[NSUserDefaults standardUserDefaults] setObject:updateCoins forKey:_MewardCoinblanaceKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
           
             
    }
                                           
                                           
    else if([[DicResponse objectForKey:@"status"] intValue]== 0)
    {
         int lesscoin=[updateCoins intValue]-[Coins intValue];
         NSString *coinn=[@(lesscoin) stringValue];
        [[NSUserDefaults standardUserDefaults] setObject:coinn forKey:_MewardCoinblanaceKey];
            
            if ([[DicResponse objectForKey:@"msg" ]isEqualToString:@"You have earn your today's share coins"])
            {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"hoho !"
                                      message:@"You have earn your today's share coins"
                                      delegate:nil
                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
            }
            
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"hoho !"
                                      message:@"You have exceed the share limit of 10"                                      delegate:nil
                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
            }
        
            }
        
          }
          else
              
           {
             [__delegate ServieFailedHandller:@"Invalid"];
            }
        }
            else
            {
                [__delegate ServieFailedHandller:@"Invalid"];
             }
    }
            else
            {
                [__delegate ServieFailedHandller:[connectionError description]];
                                   NSLog(@"Error in connection : %@",[connectionError description]);
            }
        }];
}


-(void)FetchReadeamPointsDetails
{
    [self FetchREadeamedPointsFromServer];
}

-(void)FetchREadeamedPointsFromServer
{
    
    NSMutableDictionary *dictionaryJSON=[[NSMutableDictionary alloc]init];
    
    
    
    NSMutableDictionary *meWardTokenDict=[[NSMutableDictionary alloc]init];
    meWardTokenDict =[[NSUserDefaults standardUserDefaults] objectForKey:_AppDataSavedKey];
    _MewardID=[meWardTokenDict objectForKey:@"mewardid"];
    _AppTokenKey=[meWardTokenDict objectForKey:@"tokenkey"];
    
    [dictionaryJSON setObject:@"RedeemHistory" forKey:@"action"];
    [dictionaryJSON setObject:_MewardID forKey: @"mewardid"];
    [dictionaryJSON setObject:_AppTokenKey forKey: @"tokenkey"];
    NSLog(@"PATH=====%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"AuthenticationServerPath"]);
    
    [self FetchDataFromServer :dictionaryJSON:@"http://megogridservices.migsites.com/MasterService/megogrid"];
    
}



-(void)FetchDataFromServer:(NSMutableDictionary*)JasonDictionary :(NSString*)ServerPath
{

    NSError *error =nil;
    NSData* postData = [NSJSONSerialization dataWithJSONObject:JasonDictionary options:kNilOptions error:&error];
    NSString *PostString= [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"jason====%@",PostString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ServerPath]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"json" forHTTPHeaderField: @"Content-Type"];
    [request setHTTPBody:postData];
    //[request setTimeoutInterval:120];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    if(!connectionError)
     {
        NSString *strResponse=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        if(httpResponse.statusCode==200)
        {
         if(data.length)
        {
            NSLog(@"Response======%@",strResponse);
            [__delegate ServiceSuccessHandller:data];
            [SDKHistoryManager.ApplicationDataCache setObject:data forKey:JasonDictionary];
            
        }
        }
        else
        {
          [__delegate ServieFailedHandller:strResponse];
          NSLog(@"Response======%@",strResponse);
        
        }
     }
        else
        {
                [__delegate ServieFailedHandller:[connectionError description]];
                NSLog(@"Error in connection : %@",[connectionError description]);
            }
    }];
}





-(NSMutableArray*)ParseJsonEarnedHistoryView:(NSData*)data
{
    
   
    NSMutableArray *DataArray=[[NSMutableArray alloc]init];
    
    @try
    {
    
    NSError* error;
    NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    int CType=0,EnumContentType=0;
       
    for( DicThemeItem1 in jsonData)
    {
        
        NSLog(@"IN LOOP");
        NSString * Title=[DicThemeItem1 objectForKey:@"title"];
        NSString * ImageUrl=[DicThemeItem1 objectForKey:@"icon"];
        NSString * CampaignType= [DicThemeItem1 objectForKey:@"campaigntype"];
        NSString * contentUrl= [DicThemeItem1 objectForKey:@"mediacontent"];
        NSString * actiontype= [DicThemeItem1 objectForKey:@"type"];
        NSString * creditPoints= [DicThemeItem1 objectForKey:@"coins"];
        NSString * DateTime= [self TimeIntervalToDateDDMMYYYY:[DicThemeItem1 objectForKey:@"datetime"]];

        if([actiontype isEqualToString:@"Video"])
        {
            EnumContentType=Videos;
        }
        else if([actiontype isEqualToString:@"onewayShare"])
        {
            EnumContentType=Share;
        }
        else if([actiontype isEqualToString:@"twowayShare"])
        {
            EnumContentType=Share;
        }

        else if([actiontype isEqualToString:@"install"])
        {
            EnumContentType=Install;
        }
        else if([actiontype isEqualToString:@"action"])
        {
            EnumContentType=Action;
        }
        if([CampaignType isEqualToString:@"Banner"])
            CType=Banner;
        else
            CType=Application;

        MegoHistoryCredit *dataview=[MegoHistoryCredit dataWithHistory:Title HistoryDate:DateTime HistoryShareCount:creditPoints HistoryImage:nil headerColor:@"0x486890" HistoryButtontype:EnumContentType];
        dataview.ImageUrl=ImageUrl;
        dataview.ContentUrl=contentUrl;
        [DataArray addObject:dataview];
    }
    }
    @catch (NSException *exception)
    {
        
    }
    
    NSLog(@"ParseJsonEarnedHistoryVie=%@",DataArray);
    return DataArray;
    
}

-(NSString*)TimeIntervalToDateDDMMYYYY:(NSString *)Interval
{
    NSString *theDate;
    @try
    {
        
        NSString *myNumber = Interval;
        long long value = fabs(myNumber.longLongValue);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        value=value/1000;
        NSDate *myDate = [[NSDate alloc] initWithTimeIntervalSince1970:value];
        theDate = [dateFormatter stringFromDate:myDate];
    }
    
    @catch (NSException *exception)
    {
    }
    return theDate;
}




-(NSMutableArray*)ParseJsonToInstallShareView:(NSData*)data
{
    
       NSMutableArray *DataArray=[[NSMutableArray alloc]init];
    @try {

    NSError* error;
    NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    int CType=0,EnumContentType=0;
    NSArray *ArrayItemThemes=[jsonData objectForKey:@"data"];
        
        
    for( NSDictionary *DicThemeItem in ArrayItemThemes)
    {
        
        
        NSString * Cid=[DicThemeItem objectForKey:@"cid"];
        NSString * PackageId=[DicThemeItem objectForKey:@"pkgid"];
        NSString * Title=[DicThemeItem objectForKey:@"title"];
        NSString * Description=[DicThemeItem objectForKey:@"subtitle"];
        NSString * ImageUrl=[[DicThemeItem objectForKey:@"imageurl"] stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString * CampaignType= [DicThemeItem objectForKey:@"contenttype"];
        NSString * actiontype= [DicThemeItem objectForKey:@"actiontype"];
        NSString * downloadurl = [[DicThemeItem objectForKey:@"downloadurl"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
         downloadurl = [downloadurl stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        
        NSString * creditPoints= [DicThemeItem objectForKey:@"creditpoint"];
        
        if([actiontype isEqualToString:@"Video"])
        {
            EnumContentType=Videos;
        }
        else if([actiontype isEqualToString:@"onewayShare"])
        {
            EnumContentType=Share;
        }
        else if([actiontype isEqualToString:@"twowayShare"])
        {
            EnumContentType=share1;
        }
        else if([actiontype isEqualToString:@"install"])
        {
            EnumContentType=Install;
 
        }
        else if([actiontype isEqualToString:@"action"])
        {
            EnumContentType=Action;
        }
        
        
        if([CampaignType isEqualToString:@"Banner"])
        {
            CType=Banner;
        }
        else if ([CampaignType isEqualToString:@"Text"])
        {
            CType=Text;
        }
        else if ([CampaignType isEqualToString:@"TextIcon"])
        {
            CType=TextICON;
        }
        else
            
        CType=Application;
        
        
       MegoHistoryCredit *dataview=[MegoHistoryCredit dataWithgetCredit:Title CreditDescription:Description CreditShareCount:creditPoints CreditImage:nil  headerColor:@"0x486890" itemtype:CType Buttontype:EnumContentType];
        dataview.ImageUrl=ImageUrl;
        dataview.ContentUrl=downloadurl;
        dataview.LandingPageStatus=[[DicThemeItem objectForKey:@"enabled_loading_page"] intValue];
        dataview.Landingloading_page_template=[DicThemeItem objectForKey:@"loading_page_template"];
        dataview.DeepLinkUrl=[DicThemeItem objectForKey:@"deeplinkUrl"];
        dataview.CampaignID=Cid;
        dataview.PackageId=PackageId;
        dataview.contenttype=CampaignType;
        [DataArray addObject:dataview];
    }
    }
    @catch (NSException *exception)
    {
        
    }
    return DataArray;
}


-(void)SingleImageDownloadService:(NSString*)ImageUrl
{
   
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ImageUrl]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if(!connectionError)
         {
                UIImage *imag = [[UIImage alloc] initWithData:[NSData dataWithData:data]];
                 [__delegate getImage:imag];
           
            
         }
         
         else
         {
             NSLog(@"Error in  Image Connection connection : %@  %@",[connectionError description],ImageUrl);
         }
     }];
}




//**************************************ankit*********************************


-(void)GetCampaignsForUser
{
    NSMutableDictionary *dictionaryJSON=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dictionaryJSON1=[[NSMutableDictionary alloc]init];
    dictionaryJSON1= [[NSUserDefaults standardUserDefaults] objectForKey: _AppDataSavedKey];
    [dictionaryJSON setObject:[dictionaryJSON1 objectForKey:@"mewardid"]forKey:@"mewardid" ];
    [dictionaryJSON setObject:[dictionaryJSON1 objectForKey:@"tokenkey"] forKey:@"tokenkey" ];
    [dictionaryJSON setObject:[self GetCountryCode] forKey:@"countrycode" ];
    [dictionaryJSON setObject:@"GetCampaignList" forKey:@"action"];
    NSString *path=@"http://mgservices.migsites.com/me_wards/Mewards/mewards";
    [self FetchDataforuser :dictionaryJSON:path];
    
}


-(void)FetchDataforuser:(NSMutableDictionary*)JasonDictionary :(NSString*)ServerPath
{
    
    NSError *error =nil;
    NSData* postData = [NSJSONSerialization dataWithJSONObject:JasonDictionary options:kNilOptions error:&error];
    NSString *PostString= [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"jason====%@",PostString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ServerPath]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"json" forHTTPHeaderField: @"Content-Type"];
    [request setHTTPBody:postData];
    //[request setTimeoutInterval:120];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if(!connectionError)
                               {
                                   NSString *strResponse=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                   NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                                   if(httpResponse.statusCode==200)
                                   {
                                       if(data.length)
                                       {
                                           NSLog(@"Response======%@",strResponse);
                                           
                                           [__delegate ServiceSuccessHandller:data];
                                           
                                       }
                                   }
                                   else
                                   {
                                       [__delegate ServieFailedHandller:strResponse];
                                       NSLog(@"Response======%@",strResponse);
                                       
                                   }
                               }
                               else
                               {
                                   [__delegate ServieFailedHandller:[connectionError description]];
                                   NSLog(@"Error in connection : %@",[connectionError description]);
                               }
                           }];
}




 //****************************** UNUSE FUNCTION  *************************************

+(UIImage*)getImageFromBundle:(NSString*)imageName
{
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Assets" ofType:@"bundle"];
    NSString *receivedImageNam = [[NSBundle bundleWithPath:bundlePath] pathForResource:imageName ofType:@"png"];
    
    UIImage *drop_downImage1 = [[UIImage alloc] initWithContentsOfFile:receivedImageNam];
    return drop_downImage1;
}


+(void)NotifyInstallRefferal:(NSString*)RefferalDetails
{
    
    NSString *ServerNotifiyPath=@"http://mgservices.migsites.com/me_wards/Mewards/mewards";
    NSMutableDictionary *JasonDictionary=[[NSMutableDictionary alloc]init];
    [JasonDictionary setObject:RefferalDetails forKey:@"uniqueId"];
    [JasonDictionary setObject:@"UpdateIphoneCoins"  forKey:@"action" ];
    NSError *error =nil;
    NSData* postData = [NSJSONSerialization dataWithJSONObject:JasonDictionary options:kNilOptions error:&error];
    NSString *PostString= [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"jason====%@",PostString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ServerNotifiyPath]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"json" forHTTPHeaderField: @"Content-Type"];
    [request setHTTPBody:postData];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if(!connectionError)
               {
                   NSString *resposne=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                   NSLog(@"Response=====%@",resposne);
                   NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                   
                   if(httpResponse.statusCode==200)
                   {
                       
                       if(data.length)
                       {
                           NSMutableDictionary* ResponseDictionary = [NSJSONSerialization JSONObjectWithData:data  options:kNilOptions error:nil];
                           
                           NSLog(@"Install refferal successfully notified to server %@",ResponseDictionary);
                           
                            if([[ResponseDictionary objectForKey:@"status"] intValue]== 1)
                               
                           {
                               NSString *strMsg=[NSString stringWithFormat:@"record has been inserted successfully "];
                               UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" Wow !" message:strMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                               [alert show];
                               
                           }
                           
                       }
                       
                   
                       
                   }
        else
            {
                       
                UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"Failed!" message:@"Failed to send Gift, Please try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [Alert show];
            }
                   
               }
                               
        else
                                   
            {
                                   
            NSLog(@"Error in connection : %@",[connectionError description]);
            }
        
    }];
}



-(void)NotifyAction:(NSString*)eventId :(NSDictionary*)DicConditions
{
    
    NSMutableDictionary *JasonDictionary=[[NSMutableDictionary alloc]init];
    [JasonDictionary setObject:@"complete" forKey:@"action"];
    [JasonDictionary setObject:eventId forKey:@"eventId"];
    [JasonDictionary setObject:DicConditions forKey:@"conditions"];
    NSError *error =nil;
    NSData* postData = [NSJSONSerialization dataWithJSONObject:JasonDictionary options:kNilOptions error:&error];
    NSString *PostString= [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"jason====%@",PostString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.ServerPath]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"json" forHTTPHeaderField: @"Content-Type"];
    [request setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    if(!connectionError)
    {
        NSString *resposne=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Response=====%@",resposne);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        if(httpResponse.statusCode==200)
            {
                if(data.length)
                {
                    NSMutableDictionary* ResponseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                    NSLog(@"value of BeginDownloadService %@",ResponseDictionary);
                                           [__delegate SendgiftHandler:ResponseDictionary];
                                           
                }
        else
            {
                  [__delegate ServieFailedHandller:@"Invalid"];
            }
    }
        else
            {
              [__delegate ServieFailedHandller:@"Failed to send Gift Please try again."];
               UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"Failed!" message:@"Failed to send Gift, Please try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [Alert show];
            }
    }
    
    else
    
        {
            [__delegate ServieFailedHandller:[connectionError description]];
            NSLog(@"Error in connection : %@",[connectionError description]);
        }
            }];
}




-(NSMutableArray*)ParseReadeamedPointsView:(NSData*)data
{
    NSMutableArray *SectionArray=[[NSMutableArray alloc]init];
    NSMutableArray *SectionViewArray=[[NSMutableArray alloc]init];
    NSMutableArray *featureArray=[[NSMutableArray alloc]init];
    NSMutableArray *DataArray=[[NSMutableArray alloc]init];
    @try
    {
        NSError* error;
        NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        int CType=0,EnumContentType=0;
        NSArray *ArrayItemThemes=[jsonData objectForKey:@"used"];
        
        
        for( NSDictionary *DicThemeItem in ArrayItemThemes)
        {
            
            NSString * AppName=[DicThemeItem objectForKey:@"app_name"];
            int  Points=[[DicThemeItem objectForKey:@"total_coins"]intValue];
            NSString * ImageUrl=[DicThemeItem objectForKey:@"app_image"];
            NSArray * DetailsArray= [DicThemeItem objectForKey:@"uses"];
            NSString *TotalCreditPoints=[NSString stringWithFormat:@"%d",Points];
            UIImage *img=[[UIImage alloc]init];
            
            ImageUrl=@"http://www.download-hd-wallpapers.com/wp-content/uploads/2014/06/creative-desktop-ideas.jpg";
            MegoHistoryCredit *dataview=[MegoHistoryCredit dataWithHeaderRedeemed:AppName HeaderShareCount:TotalCreditPoints HeaderImage:img];
            dataview.ImageUrl=ImageUrl;
            [dataview DownloadImage];
            [SectionViewArray addObject:dataview];
            for(NSDictionary *DetailsDicationary in DetailsArray )
            {
                
                NSString * featureName= [DetailsDicationary objectForKey:@"title"];
                NSString * creditPoints= [DetailsDicationary objectForKey:@"coins"];
                NSString *featureImageurl=[DetailsDicationary objectForKey:@"box_image"];
                NSString * DateTime= [DetailsDicationary objectForKey:@"timestamp"];
                MegoHistoryCredit  *dataView3 = [MegoHistoryCredit dataWithRedeemed:featureName RedeemedDate:DateTime RedeemedShareCount:creditPoints RedeemedImage:img];
                dataView3.ImageUrl=featureImageurl;
                [dataView3 DownloadImage];
                [DataArray addObject:dataView3];
            }
            [SectionArray addObject:DataArray];
        }
        [featureArray addObject:SectionArray];
        [featureArray addObject:SectionViewArray];
    }
    @catch (NSException *exception)
    {
        
    }
    return featureArray;
}





-(NSMutableArray*)ParseJsonBuyView:(NSData*)data
{
    
    NSMutableArray *DataArray=[[NSMutableArray alloc]init];
    NSError* error;
    NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray *ArrayItemThemes=[jsonData objectForKey:@"data"];
    for( NSDictionary *DicThemeItem in ArrayItemThemes)
    {
        
        NSString * Price= [DicThemeItem objectForKey:@"price"];
        NSString * inAppid= [DicThemeItem objectForKey:@"inappid"];
        NSString * creditPoints= [DicThemeItem objectForKey:@"coins"];
        MegoHistoryCredit *dataview=[MegoHistoryCredit dataWithBuyCredit:creditPoints CreditDollarCount:Price DollarImage:[UIImage imageNamed:[NSString stringWithFormat:@"dollar.png"]]];
        dataview.InAppId=inAppid;
        [DataArray addObject:dataview];
    }
    return DataArray;
}




-(void)GetPurchasableCoinList
{
    
    NSMutableDictionary *JasonDictionary=[[NSMutableDictionary alloc]init];
    
    
    [JasonDictionary setObject:@"CoinsPurchase" forKey:@"action"];
    [JasonDictionary setObject:self.MewardID  forKey:@"mewardid" ];
    [JasonDictionary setObject:self.AppTokenKey forKey:@"tokenkey" ];
    [JasonDictionary setObject:@"6" forKey:@"store"];
    [JasonDictionary setObject:@"iPhone" forKey:@"os" ];
    [JasonDictionary setObject:[self GetCountryCode] forKey:@"countrycode"];
    if([SDKHistoryManager.ApplicationDataCache objectForKey: JasonDictionary]!=nil)
    {
        [__delegate ServiceSuccessHandller:[SDKHistoryManager.ApplicationDataCache objectForKey: JasonDictionary]];
    }
    NSError *error =nil;
    NSData* postData = [NSJSONSerialization dataWithJSONObject:JasonDictionary options:kNilOptions error:&error];
    NSString *PostString= [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"jason====%@",PostString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.ServerPath]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"json" forHTTPHeaderField: @"Content-Type"];
    [request setHTTPBody:postData];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if(!connectionError)
                               {
                                   
                                   NSString *Responsess=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"responsessss====%@",Responsess);
                                   
                                   if(data.length)
                                   {
                                       NSMutableDictionary* responseString = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                       NSLog(@"value of BeginDownloadService %@",responseString);
                                       NSLog(@"Response String %@",responseString);
                                       [__delegate ServiceSuccessHandller:data];
                                       [SDKHistoryManager.ApplicationDataCache setObject:data forKey:JasonDictionary];
                                   }
                                   
                                   else
                                   {
                                       [__delegate ServieFailedHandller:@"Invalid"];
                                   }
                               }
                               else
                               {
                                   [__delegate ServieFailedHandller:[connectionError description]];
                                   NSLog(@"Error in connection : %@",[connectionError description]);
                               }
                           }];
}








@end

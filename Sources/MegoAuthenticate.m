//
//  Authenticate.m
//
//  Created by David-iphone on 12/06/15.
//

#import "MegoAuthenticate.h"
#import "MegoAuthenticateManager.h"
#import "MegoHistoryclasss.h"

@interface MegoAuthenticate()<ServerDataHandller>



@end

@implementation MegoAuthenticate

-(void)Intialize
{
    MegoAuthenticateManager *pro = [[MegoAuthenticateManager alloc]init];
    pro._delegate = self;
    [pro GetHost];


}

-(void)GethostHandller
{
    BOOL isautheticated = [[NSUserDefaults standardUserDefaults]boolForKey:@"Authenticated"];
    if(!isautheticated)
    {
        MegoAuthenticateManager *authenticate = [[MegoAuthenticateManager alloc]init];
        authenticate._delegate = self;
        [authenticate AuthenticateUser];
        
    }
    else{
        
        NSLog(@"Already authenticated");
    }
    
}
-(void)ServiceSuccessHandller:(NSString*)Response
{
    
}


-(void)AuthenticationSuccess
{
    //post notification
}


-(void)ServieFailedHandller:(NSError*)ErrorDescription;
{

    [[self delegate] MegoAuthErrorHandler:ErrorDescription];
}

-(void)getHistory:(UINavigationController*)navigation
{
    
    MegoHistoryclasss *history=[[MegoHistoryclasss alloc]init];
    [navigation pushViewController:history animated:YES];
    
    
}





@end

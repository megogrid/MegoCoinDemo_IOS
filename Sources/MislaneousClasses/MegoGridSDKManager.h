//
//  MewoGridSDKManager.h
//  MigitalStoreSDK
//
//  Created by Rishi on 2/13/15.
//  Copyright (c) 2015 migital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MegoGridProgressBarView.h"


typedef enum
{
    DisplayTypeIPhone,
    DisplayTypeIPhoneRetina,
    DisplayTypeIPad,
} DisplayType;


static MegoGridProgressBarView *objProgressBarView=nil;
static DisplayType displayType;



@interface MegoGridSDKManager : NSObject


+(int) devType;
+(CGFloat)deviceHeight;
+(CGFloat)deviceWidth;
+ (void)stopProgressBar;


+ (void)startProgressBar:(UIView*) parent : (NSString*)ProgressMessage;
@property (nonatomic,strong) UIView *CurrentParent;
@property (nonatomic,strong) MegoGridProgressBarView *objProgressBarView;
+(NSCache *)ApplicationDataCache;
+(void) showAlertMessage:(UIView*) parent : (NSString*) messageText;


@property (nonatomic) DisplayType displayType;

+(void) checkDeviceType;
+(double) pX:(double) ValueX;
+(double) pY:(double) ValueY;
+(NSString *) ConvertImage:(NSString*) ImageName;

+(UILabel*)label:(CGRect)labelPosition_CGRectMake BackColor:(UIColor*)bgColor LblText:(NSString*)labelString TextColor:(UIColor*)textColor FontSize:(CGFloat)fontSize Alignment:(char)textAlignment parentView:(UIViewController*)classOfLabel;

+(UIButton*)buttonWithSelectUnSelectUI:(NSString*)selectUI unselectedImg:(NSString*)unselectUI rect:(CGRect)positionOfButton_CGRectMake tittle:(NSString*)tittleOfButton tagValue:(NSInteger)tagOfButton parentView:(UIViewController*)classOfButton;

+(UILabel*)labelWithFont:(CGRect)labelPosition_CGRectMake BackColor:(UIColor*)bgColor LblText:(NSString*)labelString TextColor:(UIColor*)textColor FontSize:(CGFloat)fontSize FontFace:(NSString*)fontType Alignment:(char)textAlignment parentView:(UIViewController*)classOfLabel;

+(UILabel*)labelWithFontView:(CGRect)labelPosition_CGRectMake BackColor:(UIColor*)bgColor LblText:(NSString*)labelString TextColor:(UIColor*)textColor FontSize:(CGFloat)fontSize FontFace:(NSString*)fontType Alignment:(char)textAlignment parentView:(UIView*)classOfLabel;


+(void)ShowCommonAlert:(NSString*)Title MsgBody:(NSString*)Body;





@end

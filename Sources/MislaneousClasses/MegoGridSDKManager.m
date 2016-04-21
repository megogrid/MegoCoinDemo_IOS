//
//  MewoGridSDKManager.m
//  MigitalStoreSDK
//
//  Created by Rishi on 2/13/15.
//  Copyright (c) 2015 migital. All rights reserved.
//

#import "MegoGridSDKManager.h"

@implementation MegoGridSDKManager


# pragma Check Device Type(iPhone,iPad,etc)

static NSCache *ApplicationDataCache;
static DisplayType displayType;
@synthesize displayType;


+ (NSCache *)ApplicationDataCache;
{
    if(ApplicationDataCache==nil)
    {
        ApplicationDataCache=[[NSCache alloc]init];
        ApplicationDataCache.totalCostLimit=1024;
    }
    return ApplicationDataCache;
}

+ (void)SetImageCache:(NSCache *)value;
{
    @synchronized(self)
    {
        ApplicationDataCache = value;
    }
}


+(int) devType
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        return 3;
    else{
        
        if ([[UIScreen mainScreen] bounds].size.height == 568)
            return 2;
        else
            return 1;
    }
}

+(CGFloat)deviceWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+(CGFloat)deviceHeight
{
    NSLog(@"Height of device= %f",[UIScreen mainScreen].bounds.size.height);
    return [UIScreen mainScreen].bounds.size.height;
}


#pragma mark - Alert Message
+(void) showAlertMessage:(UIView*) parent : (NSString*) messageText
{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle: @"Note:"
                                                        message: messageText
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
    [alertView show];
    //[alertView release];
    
    
}


# pragma Label Color(text,BG) Text(size,color, alignment)
+(UILabel*)label:(CGRect)labelPosition_CGRectMake BackColor:(UIColor*)bgColor LblText:(NSString*)labelString TextColor:(UIColor*)textColor FontSize:(CGFloat)fontSize Alignment:(char)textAlignment parentView:(UIViewController*)classOfLabel
{
    CGRect myImageRect = CGRectMake([MegoGridSDKManager pX:labelPosition_CGRectMake.origin.x],
                                    [MegoGridSDKManager pY:labelPosition_CGRectMake.origin.y],
                                    [MegoGridSDKManager pX:labelPosition_CGRectMake.size.height],
                                    [MegoGridSDKManager pY:labelPosition_CGRectMake.size.width]);
    UILabel *myLabel;
    myLabel = [[UILabel alloc] initWithFrame:myImageRect];
    myLabel.backgroundColor=bgColor;
    [myLabel setText:labelString];
    myLabel.textColor = textColor;
    myLabel.font=[UIFont systemFontOfSize:fontSize];
    
    if(textAlignment == 'C'){
        myLabel.textAlignment = UITextAlignmentCenter;
    }
    else if (textAlignment == 'L'){
        myLabel.textAlignment = UITextAlignmentLeft;
    }
    else if (textAlignment == 'R'){
        myLabel.textAlignment = UITextAlignmentRight;
    }
    else{
        myLabel.textAlignment = UITextAlignmentCenter;
    }
    [classOfLabel.view addSubview:myLabel];
    return myLabel;
    //return myLabel;
}

# pragma Label Color(text,BG) Text(size, type, color, alignment)
+(UILabel*)labelWithFont:(CGRect)labelPosition_CGRectMake BackColor:(UIColor*)bgColor LblText:(NSString*)labelString TextColor:(UIColor*)textColor FontSize:(CGFloat)fontSize FontFace:(NSString*)fontType Alignment:(char)textAlignment parentView:(UIViewController*)classOfLabel
{
    CGRect myImageRect = CGRectMake([MegoGridSDKManager pX:labelPosition_CGRectMake.origin.x],
                                    [MegoGridSDKManager pY:labelPosition_CGRectMake.origin.y],
                                    [MegoGridSDKManager pX:labelPosition_CGRectMake.size.height],
                                    [MegoGridSDKManager pY:labelPosition_CGRectMake.size.width]);
    UILabel *myLabel;
    myLabel = [[UILabel alloc] initWithFrame:myImageRect];
    myLabel.backgroundColor=bgColor;
    [myLabel setText:labelString];
    myLabel.textColor = textColor;
    //    myLabel.font=[UIFont systemFontOfSize:fontSize];
    [myLabel setFont: [UIFont fontWithName: fontType size:fontSize]];
    
    if(textAlignment == 'C'){
        myLabel.textAlignment = UITextAlignmentCenter;
    }
    else if (textAlignment == 'L'){
        myLabel.textAlignment = UITextAlignmentLeft;
    }
    else if (textAlignment == 'R'){
        myLabel.textAlignment = UITextAlignmentRight;
    }
    else{
        myLabel.textAlignment = UITextAlignmentCenter;
    }
    
    [classOfLabel.view addSubview:myLabel];
    return myLabel;
}



# pragma Label Color(text,BG) Text(size, type, color, alignment)
+(UILabel*)labelWithFontView:(CGRect)labelPosition_CGRectMake BackColor:(UIColor*)bgColor LblText:(NSString*)labelString TextColor:(UIColor*)textColor FontSize:(CGFloat)fontSize FontFace:(NSString*)fontType Alignment:(char)textAlignment parentView:(UIView*)classOfLabel
{
    CGRect myImageRect = CGRectMake([MegoGridSDKManager pX:labelPosition_CGRectMake.origin.x],
                                    [MegoGridSDKManager pY:labelPosition_CGRectMake.origin.y],
                                    [MegoGridSDKManager pX:labelPosition_CGRectMake.size.height],
                                    [MegoGridSDKManager pY:labelPosition_CGRectMake.size.width]);
    UILabel *myLabel;
    myLabel = [[UILabel alloc] initWithFrame:myImageRect];
    myLabel.backgroundColor=bgColor;
    [myLabel setText:labelString];
    myLabel.textColor = textColor;
    //    myLabel.font=[UIFont systemFontOfSize:fontSize];
    [myLabel setFont: [UIFont fontWithName: fontType size:fontSize]];
    
    if(textAlignment == 'C'){
        myLabel.textAlignment = UITextAlignmentCenter;
    }
    else if (textAlignment == 'L'){
        myLabel.textAlignment = UITextAlignmentLeft;
    }
    else if (textAlignment == 'R'){
        myLabel.textAlignment = UITextAlignmentRight;
    }
    else{
        myLabel.textAlignment = UITextAlignmentCenter;
    }
    
    [classOfLabel addSubview:myLabel];
    return myLabel;
}




+ (void)startProgressBar:(UIView*) parent : (NSString*)ProgressMessage
{
    if(objProgressBarView)
    {
        [objProgressBarView removeFromSuperview];
        objProgressBarView=nil;
    }
    //if([parent)
    objProgressBarView=[[MegoGridProgressBarView alloc]initWithFrame:CGRectMake(0,0,parent.frame.size.width,parent.frame.size.height):ProgressMessage];
    [parent addSubview:objProgressBarView];
    [parent bringSubviewToFront:objProgressBarView];
}

+(void)ShowCommonAlert:(NSString*)Title MsgBody:(NSString*)Body
{
    UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:Title message:Body delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [Alert show];
    
}

+ (void)stopProgressBar
{
    [objProgressBarView removeFromSuperview];
    objProgressBarView=nil;
    [[UIApplication sharedApplication].keyWindow setUserInteractionEnabled:YES];
}

+(NSString *)GetUdid
{
    NSString *udid=nil;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        // This is will run if it is iOS6
        udid =[[[UIDevice currentDevice] identifierForVendor] UUIDString];
        //NSLog(@"identifierForVendor===%@",udid);
    }
    else
    {
        /*NSLog(@"identifieruidi===%@",udid);
         udid=[[UIDevice currentDevice] uniqueIdentifier]; "uniqueIdentifier" is private */
        NSString *getId=[[NSUserDefaults standardUserDefaults]objectForKey:@"UIDID"];
        if (getId==nil) {
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
    //NSLog(@"identifierForVendor===%@",udid);
    return udid;
}

# pragma Convert X
+(double) pX:(double) ValueX
{
    if (displayType == DisplayTypeIPad)
    {
        return ValueX*2.4;
    }
    else if (displayType == DisplayTypeIPhoneRetina)
    {
        return ValueX;
    }
    else
    {
        return ValueX;
    }
}




# pragma Convert Y
+(double) pY:(double) ValueY
{
    if (displayType == DisplayTypeIPad)
    {
        return ValueY*2.14;
    }
    else if (displayType == DisplayTypeIPhoneRetina)
    {
        return ValueY;
    }
    else
    {
        return ValueY;
    }
}


# pragma Convert Image
+(NSString *) ConvertImage:(NSString*) ImageName
{
    NSString *tempString;
    
    if (displayType == DisplayTypeIPad)
    {
        tempString = @"iPad_";
        tempString =  [tempString stringByAppendingString:ImageName];
        return tempString;
    }
    else if (displayType == DisplayTypeIPhoneRetina)
    {
        return ImageName;
    }
    else
    {
        return ImageName;
    }
    
}


# pragma Button with Select or Unselect UI
+(UIButton*)buttonWithSelectUnSelectUI:(NSString*)selectUI unselectedImg:(NSString*)unselectUI rect:(CGRect)positionOfButton_CGRectMake tittle:(NSString*)tittleOfButton tagValue:(NSInteger)tagOfButton parentView:(UIViewController*)classOfButton
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame: CGRectMake([MegoGridSDKManager pX:positionOfButton_CGRectMake.origin.x],
                                 [MegoGridSDKManager pY:positionOfButton_CGRectMake.origin.y],
                                 [MegoGridSDKManager pX:positionOfButton_CGRectMake.size.height],
                                 [MegoGridSDKManager pY:positionOfButton_CGRectMake.size.width])];
    button.tag = tagOfButton;
    [button setTitle:tittleOfButton forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    [button setBackgroundImage:[UIImage imageNamed:[self ConvertImage:unselectUI]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:[self ConvertImage:selectUI]] forState:UIControlStateHighlighted];
    [classOfButton.view addSubview:button];
    return button;
    
}


# pragma Default Button
+(UIButton*)buttonDefault:(CGRect)positionOfButton_CGRectMake tittle:(NSString*)tittleOfButton tagValue:(NSInteger)tagOfButton parentView:(UIViewController*)classOfButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake([MegoGridSDKManager pX:positionOfButton_CGRectMake.origin.x],
                              [MegoGridSDKManager pY:positionOfButton_CGRectMake.origin.y],
                              [MegoGridSDKManager pX:positionOfButton_CGRectMake.size.height],
                              [MegoGridSDKManager pY:positionOfButton_CGRectMake.size.width]);
    button.tag = tagOfButton;
    [button setTitle:tittleOfButton forState:UIControlStateNormal];
    [classOfButton.view addSubview:button];
    return button;
}

# pragma Button with no border
+(UIButton*)buttonNoBorder:(CGRect)positionOfButton_CGRectMake tittle:(NSString*)tittleOfButton tagValue:(NSInteger)tagOfButton parentView:(UIViewController*)classOfButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake([MegoGridSDKManager pX:positionOfButton_CGRectMake.origin.x],
                              [MegoGridSDKManager pY:positionOfButton_CGRectMake.origin.y],
                              [MegoGridSDKManager pX:positionOfButton_CGRectMake.size.height],
                              [MegoGridSDKManager pY:positionOfButton_CGRectMake.size.width]);
    button.tag = tagOfButton;
    [button setTitle:tittleOfButton forState:UIControlStateNormal];
    [button.layer setBorderWidth:0.1];
    [button.layer setCornerRadius:0.0];
    [button.layer setBorderColor:[UIColor clearColor].CGColor];
    
    [classOfButton.view addSubview:button];
    return button;
}

# pragma Button with Select or Unselect UI
+(UIButton*)buttonWithSelectUnSelectUIView:(NSString*)unselectUI selectImg:(NSString*)selectUI rect:(CGRect)positionOfButton_CGRectMake tittle:(NSString*)tittleOfButton tagValue:(NSInteger)tagOfButton parentView:(UIView*)viewOfButton
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame: CGRectMake([MegoGridSDKManager pX:positionOfButton_CGRectMake.origin.x],
                                 [MegoGridSDKManager pY:positionOfButton_CGRectMake.origin.y],
                                 [MegoGridSDKManager pX:positionOfButton_CGRectMake.size.height],
                                 [MegoGridSDKManager pY:positionOfButton_CGRectMake.size.width])];
    button.tag = tagOfButton;
    [button setTitle:tittleOfButton forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    [button setBackgroundImage:[UIImage imageNamed:[self ConvertImage:unselectUI]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:[self ConvertImage:selectUI]] forState:UIControlStateHighlighted];
    
    
    [viewOfButton addSubview:button];
    return button;
}





# pragma ImageView
+(UIImageView*)imageView:(NSString*)imageName rect:(CGRect)imagePosition_CGRectMake parentView:(UIViewController*)classOfImage
{
    CGRect myImageRect = CGRectMake([MegoGridSDKManager pX:imagePosition_CGRectMake.origin.x],
                                    [MegoGridSDKManager pY:imagePosition_CGRectMake.origin.y],
                                    [MegoGridSDKManager pX:imagePosition_CGRectMake.size.height],
                                    [MegoGridSDKManager pY:imagePosition_CGRectMake.size.width]);
    UIImageView *imageView;
    imageView = [[UIImageView alloc] initWithFrame:myImageRect];
    [imageView setImage:[UIImage imageNamed:[self ConvertImage:imageName]]];
    [classOfImage.view addSubview:imageView];
    return imageView;
}

# pragma ImageView with URL
+(UIImageView*)imageViewURL:(NSString*)defaultImageName imgURL:(NSURL*)url rect:(CGRect)imagePosition_CGRectMake parentView:(UIViewController*)classOfImage
{
    CGRect myImageRect = CGRectMake([MegoGridSDKManager pX:imagePosition_CGRectMake.origin.x],
                                    [MegoGridSDKManager pY:imagePosition_CGRectMake.origin.y],
                                    [MegoGridSDKManager pX:imagePosition_CGRectMake.size.height],
                                    [MegoGridSDKManager pY:imagePosition_CGRectMake.size.width]);
    
    UIImageView *imageView;
    imageView = [[UIImageView alloc] initWithFrame:myImageRect];
    NSString *myString = [url absoluteString];
    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:myString]];
    
    if ( data == nil )
    {
        [imageView setImage:[UIImage imageNamed:[self ConvertImage:defaultImageName]]];
    }
    else
    {
        UIImage *tmpImage = [UIImage imageWithData: data];
        [imageView setImage:tmpImage];
    }
    [classOfImage.view addSubview:imageView];
    return imageView;
}





@end

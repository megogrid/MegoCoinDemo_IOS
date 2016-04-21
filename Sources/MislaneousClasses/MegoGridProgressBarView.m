 
#import "MegoGridProgressBarView.h"
#import "QuartzCore/QuartzCore.h"
//#import "MBBAppDelegate.h"

 
@implementation MegoGridProgressBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        {//Progress Bar Code
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            {
                background=[[UIView alloc]initWithFrame:CGRectMake(0,0,320*2.4,480*2.14)];
                [background setBackgroundColor:[UIColor whiteColor]];
                background.alpha=0.4;
                [self addSubview:background];
                pleasewait=[[UILabel alloc]initWithFrame:CGRectMake(90*2.4,215*2.14,130*2.4,70*2.14)];
                [pleasewait setBackgroundColor:[UIColor blackColor]];
               
                
                UILabel *downlable1=[[UILabel alloc]initWithFrame:CGRectMake(0,32*2.14,130*2.4,30*2.14)];
                [downlable1 setBackgroundColor:[UIColor clearColor]];
                downlable1.textColor=[UIColor whiteColor];
                downlable1.text=@" Please wait....";
                downlable1.textAlignment=UITextAlignmentCenter;
                downlable1.font=[UIFont systemFontOfSize:15*2.14];
                [pleasewait addSubview:downlable1];
                downlable1=nil;
               
                
                CALayer *layerCorner=[pleasewait layer];
                [layerCorner setMasksToBounds:YES];
                [layerCorner setCornerRadius:12.0];
                [layerCorner setBorderWidth:1.0];
                [layerCorner setBorderColor:[[UIColor darkGrayColor] CGColor]];
                [self addSubview:pleasewait];
            
                
                activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                [activityView setFrame:CGRectMake(145*2.4,227*2.14,20*2.4,20*2.14)];
                [self addSubview:activityView];
                [activityView startAnimating];
                
                
                
            }
          
            else
            {
                background=[[UIView alloc]initWithFrame:frame];
                [background setBackgroundColor:[UIColor blackColor]];
                background.alpha=0.4;
                [self addSubview:background];
                
                pleasewait=[[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-130)/2,(self.frame.size.height-70)/2,130,70)];
                [pleasewait setBackgroundColor:[UIColor blackColor]];
              
                
                UILabel *downlable1=[[UILabel alloc]initWithFrame:CGRectMake(0,32,130,30)];
                [downlable1 setBackgroundColor:[UIColor clearColor]];
                downlable1.textColor=[UIColor whiteColor];
                downlable1.text=@"Please wait....";
                downlable1.textAlignment=NSTextAlignmentCenter;
                downlable1.font=[UIFont systemFontOfSize:15];
                [pleasewait addSubview:downlable1];
                downlable1=nil;
                
                CALayer *layerCorner=[pleasewait layer];
                [layerCorner setMasksToBounds:YES];
                [layerCorner setCornerRadius:12.0];
                [layerCorner setBorderWidth:1.0];
                [layerCorner setBorderColor:[[UIColor darkGrayColor] CGColor]];
                [self addSubview:pleasewait];
                
                activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                [activityView setFrame:CGRectMake((pleasewait.frame.size.width-20)/2,(pleasewait.frame.size.height-45)/2,20,20)];
                [pleasewait addSubview:activityView];
                [activityView startAnimating];

                
//                pleasewait=[[UILabel alloc]initWithFrame:CGRectMake(90,215,130,70)];
//                [pleasewait setBackgroundColor:[UIColor blackColor]];
//
//                
//                UILabel *downlable1=[[UILabel alloc]initWithFrame:CGRectMake(0,32,130,30)];
//                //[pleasewait setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Tab_US.png"]]];
//                [downlable1 setBackgroundColor:[UIColor clearColor]];
//                downlable1.textColor=[UIColor whiteColor];
//                downlable1.text=@" Please wait....";
//                downlable1.textAlignment=UITextAlignmentCenter;
//                downlable1.font=[UIFont systemFontOfSize:15];
//                [pleasewait addSubview:downlable1];
//                [downlable1 release];
//                downlable1=nil;
//                
//                CALayer *layerCorner=[pleasewait layer];
//                [layerCorner setMasksToBounds:YES];
//                [layerCorner setCornerRadius:12.0];
//                [layerCorner setBorderWidth:1.0];
//                [layerCorner setBorderColor:[[UIColor darkGrayColor] CGColor]];
//                [self addSubview:pleasewait];
//                
//                activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//                [activityView setFrame:CGRectMake(145,227,20,20)];
//                [self addSubview:activityView];
//                [activityView startAnimating];
                
            }
            
            
            
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame:(NSString*)ProgressMessage
{
    self = [super initWithFrame:frame];
    if (self) {
        {//Progress Bar Code
            
            
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            {
                background=[[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x*2.4,[UIScreen mainScreen].bounds.origin.y-420,320*2.4,480*2.14)];
                [background setBackgroundColor:[UIColor clearColor]];
                background.alpha=0.4;
                [self addSubview:background];
                pleasewait=[[UILabel alloc]initWithFrame:CGRectMake(90*2.4,(self.frame.size.height-150)/2,130*2.4,70*2.14)];
                [pleasewait setBackgroundColor:[UIColor blackColor]];
                UILabel *downlable1=[[UILabel alloc]initWithFrame:CGRectMake(0,32*2.14,130*2.4,30*2.14)];
                [downlable1 setBackgroundColor:[UIColor clearColor]];
                downlable1.textColor=[UIColor whiteColor];
                downlable1.text=ProgressMessage;
                downlable1.textAlignment=UITextAlignmentCenter;
                downlable1.font=[UIFont systemFontOfSize:15*2.14];
                [pleasewait addSubview:downlable1];
                downlable1=nil;
                CALayer *layerCorner=[pleasewait layer];
                [layerCorner setMasksToBounds:YES];
                [layerCorner setCornerRadius:12.0];
                [layerCorner setBorderWidth:1.0];
                [layerCorner setBorderColor:[[UIColor darkGrayColor] CGColor]];
                [self addSubview:pleasewait];
                activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                [activityView setFrame:CGRectMake(143*2.4,(self.frame.size.height-20*2.14)/2,20*2.4,20*2.14)];
                [self addSubview:activityView];
                [activityView startAnimating];
            }
            else
            {
                // CGRect Rect=CGRectMake(0, 80, frame.size.width, frame.size.height);
                background=[[UIView alloc]initWithFrame:frame];//frame
                [background setBackgroundColor:[UIColor clearColor]];
                background.alpha=0.4;
                [self addSubview:background];
                
                pleasewait=[[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-130)/2,(self.frame.size.height-70)/2,130,70)];
                [pleasewait setBackgroundColor:[UIColor blackColor]];
                
                UILabel *downlable1=[[UILabel alloc]initWithFrame:CGRectMake(0,32,130,30)];
                [downlable1 setBackgroundColor:[UIColor clearColor]];
                downlable1.textColor=[UIColor whiteColor];
                downlable1.text=ProgressMessage;
                downlable1.textAlignment=NSTextAlignmentCenter;
                downlable1.font=[UIFont systemFontOfSize:15];
                [pleasewait addSubview:downlable1];
                downlable1=nil;
                
                CALayer *layerCorner=[pleasewait layer];
                [layerCorner setMasksToBounds:YES];
                [layerCorner setCornerRadius:12.0];
                [layerCorner setBorderWidth:1.0];
                [layerCorner setBorderColor:[[UIColor darkGrayColor] CGColor]];
                [self addSubview:pleasewait];
                activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                [activityView setFrame:CGRectMake((pleasewait.frame.size.width-20)/2,(pleasewait.frame.size.height-45)/2,20,20)];
                [pleasewait addSubview:activityView];
                [activityView startAnimating];
                
            }
            
            
            
        }
    }
    return self;
}

-(void)stopAnimating
{
    [activityView stopAnimating];

}



@end
//
//  HistoryHeaderView.h
//
//  Created by David-iphone on 2/6/15.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>




@protocol backClickDelegate
@required
-(void)backClick;
-(void)MenuClick;
-(void)SearchClick;

@end

@interface HistoryHeaderView : UIView
{
    id <backClickDelegate> HeaderDelegates;
    
}

@property (strong) id HeaderDelegates;
@property(nonatomic,strong)UIButton *back;
@property(nonatomic,strong)UIButton *menuBtn;
@property(nonatomic,strong)UIButton *Gridbtn;
@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic)int myThemeType;
//-(void)HeaderSection : (NSString *)headerStripColor :(NSString *)GetName :(UIImage *)GetImage : (int)ThemeType;

+(HistoryHeaderView *)HeaderPlacement :(NSString *)GetName :(UIImage *)GetImage :(UIView *)BaseView :(int)ThemeType :(BOOL)BackText;

+(NSString *)HeaderColorAccToType :(int)ThemeType;
@end

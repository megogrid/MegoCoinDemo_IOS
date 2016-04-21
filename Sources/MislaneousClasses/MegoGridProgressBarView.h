//
//  ProgressBarView.h
//  MobileBloodBank
//
//  Created by migital on 21/11/12.
//
//


#import <UIKit/UIKit.h>
//Nanu

@interface MegoGridProgressBarView : UIView
{
    UIView *background;
    UILabel *pleasewait;
    UIActivityIndicatorView *activityView;
}

- (id)initWithFrame:(CGRect)frame:(NSString*)ProgressMessage;
-(void)stopAnimating;

@end

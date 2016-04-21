//
//
//  Created by David on 7/10/15.
//

#import "MegoHistoryCustomcell.h"

@implementation MegoHistoryCustomcell

@synthesize customView = _customView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)setupInternalDataWithData:(MegoHistoryCredit *)data
{
    if(self.customView !=nil)
    {
        //[self.customView removeFromSuperview];
    }
    self.customView = data.creditview;
    CGFloat width = data.creditview.frame.size.width;
    CGFloat height = data.creditview.frame.size.height;
    CGFloat x = data.creditview.frame.origin.x;
    CGFloat y = data.creditview.frame.origin.y;
    self.customView.frame = CGRectMake(x , y , width, height);
    [self.contentView addSubview:self.customView];
}


- (void)productImages
{
    self.contentView.backgroundColor=[UIColor purpleColor];
}
@end
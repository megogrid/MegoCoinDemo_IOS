//
//
//  Created by David on 7/14/15.
//

#import "MegoHistorytablecell.h"

@implementation MegoHistorytablecell

- (void)awakeFromNib
 {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {}
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setupInternalDataWithData];
}
- (void)setupInternalDataWithData
{
    if(self.customView !=nil)
    {
       
    }
    self.customView = _data.creditview;
    CGFloat width = _data.creditview.frame.size.width;
    CGFloat height = _data.creditview.frame.size.height;
    CGFloat x = _data.creditview.frame.origin.x;
    CGFloat y = _data.creditview.frame.origin.y;
    self.customView.frame = CGRectMake(x , y , width, height);
    [self.contentView addSubview:self.customView];
}


- (void)productImages
{
    self.contentView.backgroundColor=[UIColor purpleColor];
}

@end

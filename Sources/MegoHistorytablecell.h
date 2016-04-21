//
//
//
//  Created by David on 7/14/15.
//

#import <UIKit/UIKit.h>
#import "MegoHistoryCredit.h"

@interface MegoHistorytablecell : UITableViewCell
@property(nonatomic,strong)UIView *customView;
@property(nonatomic,strong)MegoHistoryCredit *data;

- (void)setupInternalDataWithData;
- (void)productImages;

@end

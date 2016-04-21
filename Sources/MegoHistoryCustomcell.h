//
//
//  Created by David on 7/10/15.
//

#import <UIKit/UIKit.h>
#import "MegoHistoryCredit.h"
@class Creditclass;

@interface MegoHistoryCustomcell : UICollectionViewCell

@property(nonatomic,retain)UIView *customView;
- (void)setupInternalDataWithData:(MegoHistoryCredit *)data;
- (void)productImages;
@end






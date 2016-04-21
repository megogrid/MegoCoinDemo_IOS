//
// HistorySegmentedHeader.h
//
//  Created by David-iphone on 3/30/15.
//
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@protocol ProductCategoryTypeDelegate
@required
-(void)ProductTypeClick:(NSString*)PtypeID Version:(NSString*)Version;
@end
#import <UIKit/UIKit.h>



@interface HistorySegmentedHeader : UIView
{
    
    NSMutableArray *dict;
    NSMutableArray *RequestParamArray;
    NSMutableArray *VersionArray;
   

   

}
@property (nonatomic,assign) id <ProductCategoryTypeDelegate>ProductTypeDelegate;
@property(nonatomic) NSInteger selectedSegmentIndex;
@property(nonatomic)int myThemeType;
@property(nonatomic,strong)  UIScrollView *scrollView;

-(void)DrawSegemntedControl:(NSMutableArray*)RequestParam :(NSMutableArray*)HeaderCategory :(NSMutableArray*)VersionArray :(int)ThemeType;

@end

//
//  ConvertColor.h
//  Tiled
//
//  Created by David on 9/17/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MegoConvertColor : NSObject
+(UIColor *) colorWithHexString: (NSString *) hex;
+(void)drawRect:(CGRect)rect;
@end

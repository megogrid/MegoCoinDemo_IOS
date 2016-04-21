//
//MewardConvertColor.m
//  Tiled
//
//  Created by David on 9/17/14.
//

#import "MegoConvertColor.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
NSString *HeaderColorCode;
@implementation MegoConvertColor
+ (UIColor *) colorWithHexString: (NSString *) hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    unsigned int r1,g1,b1;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r1];
    [[NSScanner scannerWithString:gString] scanHexInt:&g1];
    [[NSScanner scannerWithString:bString] scanHexInt:&b1];
    
    r1=(float)r1/255.0f;
    g1=(float)g1/255.0f;
    b1=(float)b1/255.0f;
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1];
}

+(void)drawRect:(CGRect)rect
{
    NSLog(@"draw star call");
    int aSize = 100.0;
    CGFloat color[4] = { 0.0, 0.0, 1.0, 1.0 }; // Blue
    CGColorRef aColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), color);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, aSize);
    CGFloat xCenter = 100.0;
    CGFloat yCenter = 100.0;
    
    float  w = 100.0;
    double r = w / 2.0;
    float flip = -1.0;
    
    CGContextSetFillColorWithColor(context, aColor);
    
    
    CGContextSetStrokeColorWithColor(context, aColor);
    
    double theta = 2.0 * M_PI * (2.0 / 5.0); // 144 degrees
    
    CGContextMoveToPoint(context, xCenter, r*flip+yCenter);
    
    for (NSUInteger k=1; k<5; k++)
    {
        float x = r * sin(k * theta);
        float y = r * cos(k * theta);
        CGContextAddLineToPoint(context, x+xCenter, y*flip+yCenter);
    }
    
    CGContextClosePath(context);
    CGContextFillPath(context);
}

@end

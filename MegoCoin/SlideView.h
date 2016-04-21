//
//  SlideView.h
//  Mego Shop Demo
//
//  Created by ankit-iphone on 2/12/16.
//  Copyright (c) 2016 unity. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideViewDelegate <NSObject>

-(void)PushToViewController:(long)indexPath;

-(void)ishideSilder;

@end

@interface SlideView : UIView<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>

-(void)hideSilder;

@property(strong)id <SlideViewDelegate> _slideViewDelegate;
@end

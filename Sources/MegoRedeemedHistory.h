//
//  Redeemed class.h
//  MigitalStoreSDK
//
//  Created by Shalu on 7/14/15.
//  Copyright (c) 2015 migital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MegoHistoryCredit.h"
#import "MegoHistoryCustomcell.h"
#import "MegoHistoryServerModel.h"
//#import "CategoryThemeView.h"



@interface MegoRedeemedHistory : UIViewController<UITableViewDelegate,UITableViewDataSource>
{   MegoHistoryCredit *dataView1;
    MegoHistoryCredit *dataView2;
    MegoHistoryCredit *dataView3;
    MegoHistoryCredit *headerdataView;
    NSMutableArray *ThemeDataArray;
    NSMutableArray *HeaderDataArray;
    MegoHistoryServerModel *ObjMewardServerModel;
   
    }
@property (nonatomic,strong) UITableView *TableView;
@property(nonatomic,strong)NSMutableArray *TableImages;
@property(nonatomic,strong)NSMutableArray *Buttonimage;

@end

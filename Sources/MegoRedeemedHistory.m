//
//  Redeemed class.m
//  MigitalStoreSDK
//
//  Created by Shalu on 7/14/15.
//  Copyright (c) 2015 migital. All rights reserved.
//

#import "MegoHistoryCredit.h"
#import "MegoHistoryCustomcell.h"
#import "MegoHistorytablecell.h"
#import "MegoHistoryclasss.h"
#import "SDKHistoryManager.h"
#import "MegoRedeemedHistory.h"

@interface MegoRedeemedHistory ()<MegoServerDataHandller>
{
    NSMutableArray *boolImageArray;
    UIImageView *viewForUpAndDownImage;
}

@end
@implementation MegoRedeemedHistory
bool isclicked;
bool shouldCollapse;

- (void)viewDidLoad
{
    [super viewDidLoad];
    HeaderDataArray =[[NSMutableArray alloc]init];
    
    boolImageArray = [[NSMutableArray alloc]init];
    {
        for (int i = 0; i < [HeaderDataArray count]; i++)
        {
            headerdataView=[MegoHistoryCredit dataWithHeaderRedeemed:@"name" HeaderShareCount:@"30" HeaderImage:[self.TableImages objectAtIndex:i]];
            [HeaderDataArray addObject:headerdataView];
            [boolImageArray addObject:[NSNumber numberWithBool:NO]];
        }
    }
    self.view.backgroundColor=[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:0.9];
    self.TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                  75, self.view.frame.size.width,self.view.frame.size.height-140) ];
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    [self.TableView registerClass:[MegoHistorytablecell class] forCellReuseIdentifier:@"cell"];
    self.TableView.hidden=YES;
    [self.TableView setSeparatorColor:[UIColor colorWithRed:231/256.f green:230/256.f blue:231/256.f alpha:1]];
    [self.TableView setBackgroundColor: [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:0.9]];
//   [ self.TableView setBackgroundColor:[UIColor purpleColor]];
    
    [self.TableView setRowHeight:40.0f];
    self.TableView.contentInset = UIEdgeInsetsMake(10, 0, 65, 0);
    self.TableView.showsVerticalScrollIndicator=false;
   [self.view addSubview:self.TableView];
    self.Buttonimage=[[NSMutableArray alloc]init];
    self.Buttonimage=[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"w5.jpg"],[UIImage imageNamed:@"orange_fav_se.png"],[UIImage imageNamed:@"w3.jpg"],nil];
    self.TableImages=[[NSMutableArray alloc]init];
    
    ThemeDataArray=[[NSMutableArray alloc]init];
    self.TableView.hidden=NO;
    [self.TableView reloadData];
    NSLog(@"TableView reloadData");
    ObjMewardServerModel=[[MegoHistoryServerModel alloc]init];
    ObjMewardServerModel._delegate=self;
    [self AuthenticationServiceSuccessHandller];
    [SDKHistoryManager startProgressBar:self.view :@"Please Wait..."];
  
}

-(void)AuthenticationServiceSuccessHandller
{
    [ObjMewardServerModel FetchReadeamPointsDetails];
}


-(void)CoinUpdated:(NSDictionary *)Response
{
    
}
-(void)ServiceSuccessHandller:(NSData*)data
{
   NSMutableArray *AllThemeDataArray =[ObjMewardServerModel ParseReadeamedPointsView:data];
    HeaderDataArray=AllThemeDataArray[1];
    ThemeDataArray=AllThemeDataArray[0];
    if(ThemeDataArray.count<=0)
    {
        [SDKHistoryManager ShowCommonAlert:@"Not Found" MsgBody:@"No Record Found!"];
    }
    boolImageArray = [[NSMutableArray alloc]init];
    {
        for (int i = 0; i < [HeaderDataArray count]; i++)
        {
            [boolImageArray addObject:[NSNumber numberWithBool:NO]];
        }
    }
    [self.TableView reloadData];
    dispatch_async(dispatch_get_main_queue(),^
                   {
                       [SDKHistoryManager stopProgressBar ];
                   });

    
}
-(void)ServieFailedHandller:(NSString*)ErrorDescription
{
    [SDKHistoryManager stopProgressBar ];
}

#pragma mark TableView Delegates


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(15, 30, 100, 40)];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}



- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    return YES;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MegoHistorytablecell *cell = (MegoHistorytablecell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[ MegoHistorytablecell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSMutableArray *DataArray = [ThemeDataArray objectAtIndex:indexPath.section];
    MegoHistoryCredit *Data = [DataArray objectAtIndex:indexPath.row];
    cell.data = Data;
    cell.backgroundColor= [UIColor  colorWithRed:0.85 green:0.85 blue:0.85 alpha:0.9];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[boolImageArray objectAtIndex:section] boolValue])
    {
        NSMutableArray *DataArray = [ThemeDataArray objectAtIndex:section];
        return [DataArray count];
    }
    return 0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  HeaderDataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  
    MegoHistoryCredit *objCC=[HeaderDataArray objectAtIndex:section];
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                 CGRectMake(0, 10, tableView.frame.size.width, 60.0)];
    sectionHeaderView.backgroundColor=[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    sectionHeaderView.tag=section;
    [sectionHeaderView addSubview:objCC.creditview];
    
    viewForUpAndDownImage = [[UIImageView alloc]initWithFrame:CGRectMake(sectionHeaderView.frame.size.width-32,(sectionHeaderView.frame.size.height-8)/2,12,8)];
    if ([[boolImageArray objectAtIndex:section] boolValue])
    {
        viewForUpAndDownImage.image=[UIImage imageNamed:@"Arrow_up.png"];
    }
    else
    {
        viewForUpAndDownImage.image=[UIImage imageNamed:@"Arrow_Down.png"];
    }
    [sectionHeaderView addSubview:viewForUpAndDownImage];
    
    UITapGestureRecognizer  *headerTapped  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [sectionHeaderView addGestureRecognizer:headerTapped];
    return sectionHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

#pragma mark - gesture tapped

- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0)
    {
        BOOL collapsed  = [[boolImageArray objectAtIndex:indexPath.section] boolValue];
        collapsed       = !collapsed;
        [boolImageArray replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        NSRange range   = NSMakeRange(indexPath.section, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.TableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"shaluasdnasdcasad");
}
-(void)listBtnClick
{
    NSLog(@"asdasasdadasdsad");
}

@end

  //
//  GetCredits.m
//  Created by David-iphone on 7/9/15.
//

#import "HistoryGetCredits.h"
#import "MegoHistoryCustomcell.h"
#import "SDKHistoryManager.h"
#import "MegoConvertColor.h"
#import "MegoHistoryclasss.h"
#define LOADING_CELL_IDENTIFIER @"LoadingItemCell"
@interface HistoryGetCredits ()<ButtonClickDelegate>

@property (nonatomic, strong) id<UIViewControllerTransitioningDelegate,MegoServerDataHandller,ButtonClickDelegate> transitioningDelegate;

@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;
@end

@implementation HistoryGetCredits
@synthesize Buttonimage;
static NSString *simpleCollectionIdentifier = @"CollectionIdentifier";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    MainView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    [MainView setBackgroundColor:[UIColor colorWithRed:17/255.f green:133/255.f blue:194/255.f alpha:1]];
    
    [self.view addSubview:MainView];
    self.ThemeDataArray=[[NSMutableArray alloc]init];
    self.TableImages=[[NSMutableArray alloc]init];
    
    myview =[[UIView alloc]initWithFrame:CGRectMake(0, Header.frame.origin.y+Header.frame.size.height+40, MainView.frame.size.width, MainView.frame.size.height)];
    [myview setBackgroundColor:[UIColor   colorWithRed:0.85f green:0.85f blue:0.85f alpha:1]];
    [MainView addSubview:myview];
    layout=[[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    layout.minimumLineSpacing=2;
    collectionRect = CGRectMake(0,108,myview.frame.size.width, myview.frame.size.height-120);
    ThemeCollectionView=[[UICollectionView alloc] initWithFrame:collectionRect collectionViewLayout:layout];
    [ThemeCollectionView setDataSource:self];
    [ThemeCollectionView setDelegate:self];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [ThemeCollectionView registerClass:[MegoHistoryCustomcell class] forCellWithReuseIdentifier:simpleCollectionIdentifier];
    [ThemeCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:LOADING_CELL_IDENTIFIER];
    
    [ThemeCollectionView setBackgroundColor:[UIColor clearColor]];
    [myview addSubview:ThemeCollectionView];
    [ThemeCollectionView setCollectionViewLayout:layout];
    ThemeCollectionView.showsVerticalScrollIndicator = false;
    [self ShowHeaderSegmented];
    [self GetHeader:@"1500"];
    
//    dataView=[[MewardCreditclass alloc]init];
    _ObjMewardServerModel=[[MegoHistoryServerModel alloc]init];
    _ObjMewardServerModel._delegate=self;
    [SDKHistoryManager startProgressBar:ThemeCollectionView :@"Please Wait..."];
    GetCrdtvalue.text=[_ObjMewardServerModel GetRemainingCoinBalance];
     [self AuthenticationServiceSuccessHandller];
   
    
}
-(void)RefreshData
{
    [SDKHistoryManager startProgressBar:ThemeCollectionView :@"Please Wait..."];
    [_ObjMewardServerModel FetchCampaigns];
    
}


-(void)CoinUpdated:(NSDictionary*)Response
{
    GetCrdtvalue.text=[_ObjMewardServerModel GetRemainingCoinBalance];
}

-(void)AuthenticationServiceSuccessHandller
{
    
    [_ObjMewardServerModel FetchCampaigns];
}

-(void)ServiceSuccessHandller:(NSData*)data
{
    self.ThemeDataArray=[[NSMutableArray alloc]init];
    self.ThemeDataArray =[_ObjMewardServerModel ParseJsonToInstallShareView:data];
    
    [ThemeCollectionView reloadData];
    if(self.ThemeDataArray.count<=0)
    {
        [SDKHistoryManager ShowCommonAlert:@"Not Found" MsgBody:@"No Record Found!"];
    }
    dispatch_async(dispatch_get_main_queue(),^
                   {
                       [SDKHistoryManager stopProgressBar ];
                   });
}

-(void)ServieFailedHandller:(NSString*)ErrorDescription
{
    [SDKHistoryManager stopProgressBar];
}

-(void)ButtonClick:(UIButton*)Button
{
    UIButton * clickedButton=(UIButton*)Button;
    
    MegoHistoryCustomcell *cell = (MegoHistoryCustomcell *)[[[clickedButton superview]superview]superview];
   
    NSIndexPath *indexPath = [ThemeCollectionView indexPathForCell:cell];
    NSLog(@"%ld", (long)indexPath.row);
    MegoHistoryCredit *data = [self.ThemeDataArray objectAtIndex:indexPath.row];
    
    
//    if(data.LandingPageStatus==1)
//    {
//        _objLandingpage=[[MewardLandingPageViewController alloc]init];
//        _objLandingpage.strTemplataResponse=data.Landingloading_page_template;
//        _objLandingpage.NavigationUrl=data.ContentUrl;
//        _objLandingpage.crossDelegate=self;
//        _objLandingpage.indexPath=indexPath;
//        _objLandingpage.TemplateActiontype=data.Buttontype;
//        [[UIApplication sharedApplication].keyWindow addSubview:_objLandingpage.view];
//    }
//    
//    else
//    {
//        [self NavigationPerformance:data];
//    }
}




//-(void)crossClick:(NSIndexPath*)indexPath
//{
//    MewardCreditclass *data = [self.ThemeDataArray objectAtIndex:indexPath.row];
//    [self NavigationPerformance:data];
//    
//}
//

//-(void)NavigationPerformance:(MewardCreditclass*)data
//{
//    if(data.Buttontype==Videos)
//    {
//        MeWardVideoPlayScreen *VPS=[[MeWardVideoPlayScreen alloc]init];
//        VPS.VideoUrl=data.ContentUrl;
//        [self.navigationController pushViewController:VPS animated:true];
//    }
//    
//    else  if(data.Buttontype==Action)
//    {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data.DeepLinkUrl]];
//    }
//    
//    else if(data.Buttontype==Install)
//    {
//        
//       
//        NSLog(@"Itunes Url=====%@",data.ContentUrl);
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data.ContentUrl]];
//        
//        [ MeWardServerModel NotifyInstallRefferal:@"Coin_VQ27ZC18T1447046530_4DKOZ976W1447046530_YZ7S8BFZN"];
//        
//    }
//    
//    if(data.Buttontype==Share)
//    {
//        NSString *textToShare =data.ContentUrl;
//        UIActivityViewController *activityVC =[[UIActivityViewController alloc] initWithActivityItems:@[textToShare] applicationActivities:nil];
//        activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact,
//                                             UIActivityTypePrint,
//                                             UIActivityTypeAddToReadingList,];
//        //Exclude whichever aren't relevant
//        
//        [self presentViewController:activityVC animated:YES completion:nil];
//        
//        [activityVC setCompletionHandler:^(NSString *activityType, BOOL completed)
//         {
//            
//             
//             if (completed)
//             {
//                 
//                NSString *type=data.CreditName;
//                NSString *type1=@"share";
//                 [_ObjMewardServerModel UpdateCointoServer:data.PackageId CampaignId:data.CampaignID Coins:data.CoinsCount type:type type1:type1];
//               
//             }
//             else
//             {
//                   UIAlertView *objalert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Posting was not successful" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [objalert show];
//                        objalert = nil;
//                 
//             }
//         }];
//    }
//    
//    if(data.Buttontype==share1)
//    {
//        NSString *textToShare =data.ContentUrl;
//        UIActivityViewController *activityVC =[[UIActivityViewController alloc] initWithActivityItems:@[textToShare] applicationActivities:nil];
//        
//        [self presentViewController:activityVC animated:YES completion:nil];
//        
//        [activityVC setCompletionHandler:^(NSString *activityType, BOOL completed)
//         {
//             if (completed)
//             {
//                
//                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"information !" message:@"after install u get coins." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                 [alert show];
//             }
//             else
//             {
//                 
//                 
//            }
//         }];
//    }
//}

-(void)GetHeader:(NSString *)GetCreditvalue;
{
    Header =[[UIImageView alloc]initWithFrame:CGRectMake(0, 19, self.view.frame.size.width, 54)];
    Header.userInteractionEnabled=YES;
    Header.backgroundColor=[UIColor colorWithRed:17/255.f green:133/255.f blue:194/255.f alpha:1];
    
    [MainView addSubview:Header];
    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 7, 30, 38)];
    [back setImage:[MegoHistoryServerModel getImageFromBundle:@"goBack_un"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(BackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    back.showsTouchWhenHighlighted=YES;
    [Header addSubview:back];
    
    UILabel *Backlabel=[[UILabel alloc] initWithFrame:CGRectMake(back.frame.origin.x+back.frame.size.width-5,back.frame.origin.y-3,50,40)];
    Backlabel.text=@"Back";
    Backlabel.font=[UIFont fontWithName:@"Arial" size:18];
    Backlabel.backgroundColor = [UIColor clearColor];
    Backlabel.textColor = [UIColor whiteColor];
    Backlabel.textAlignment=NSTextAlignmentLeft;
    [Header addSubview:Backlabel];
    
    if(SDKHistoryManager.deviceHeight==1024)
    {
        GetCredit=[[UILabel alloc] initWithFrame:CGRectMake(Header.frame.size.width-200,Backlabel.frame.origin.y,90,40)];
        
    }
    else
    {
        GetCredit=[[UILabel alloc] initWithFrame:CGRectMake((Header.frame.size.width-100)/2-10,Backlabel.frame.origin.y,100,40)];
    }
    GetCredit.text=@"Get Credits";
    GetCredit.font=[UIFont boldSystemFontOfSize:18];
    GetCredit.backgroundColor = [UIColor clearColor];
    GetCredit.textColor = [UIColor whiteColor];
    GetCredit.textAlignment=NSTextAlignmentLeft;
    
    [Header addSubview:GetCredit];
    
    UIImageView *StoreImage=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-37,70,20,20)];
    StoreImage.userInteractionEnabled=NO;
    StoreImage.image= [MegoHistoryServerModel getImageFromBundle:@"credits"];
    [Header addSubview:StoreImage];
    
    UILabel *creditlable=[[UILabel alloc]initWithFrame:CGRectMake(0,35, self.view.frame.size.width,45 )];
    creditlable.backgroundColor=[MegoConvertColor colorWithHexString:@"f1f1f1"];
    [myview addSubview:creditlable];
    
    UILabel *totalcredit=[[UILabel alloc]initWithFrame:CGRectMake(10,35 ,200, 45)];
    totalcredit.text=@"TOTAL CREDITS" ;
    [myview addSubview:totalcredit];
    totalcredit.textColor=[UIColor blackColor];
    
    GetCrdtvalue=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-90,70,60,30)];
    GetCrdtvalue.text=GetCreditvalue;
    GetCrdtvalue.font=[UIFont fontWithName:@"Arial" size:18];
    GetCrdtvalue.backgroundColor = [UIColor clearColor];
    GetCrdtvalue.textColor = [UIColor blackColor];
    GetCrdtvalue.textAlignment=NSTextAlignmentLeft;
    GetCrdtvalue.numberOfLines=1;
    [GetCrdtvalue sizeToFit];
    [Header addSubview:GetCrdtvalue];
    
    
    
    UILabel *linelbl=[[UILabel alloc] initWithFrame:CGRectMake(GetCrdtvalue.frame.origin.x+GetCrdtvalue.frame.size.width+5,GetCrdtvalue.frame.origin.y-2,1,25)];
    linelbl.backgroundColor=[UIColor whiteColor];
    
    UIButton *ReloadBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [ReloadBtn setFrame:CGRectMake(Header.frame.size.width-100,(Header.frame.size.height-28)/2-2, 100, 28)];
    [ReloadBtn setTitle:@"History" forState:UIControlStateNormal];
    [ReloadBtn setBackgroundColor:[UIColor clearColor]];
    [ReloadBtn addTarget:self action:@selector(ReloadBtnClick)forControlEvents:UIControlEventTouchUpInside];
   [Header addSubview:ReloadBtn];
}

-(void)ShowHeaderSegmented
{
    RequestParamArray=[[NSMutableArray alloc]initWithObjects:@"EARN",@"BUY", nil];
    TabArray=[[NSMutableArray alloc]initWithObjects:@"EARN",@"BUY", nil];
    GetcreditsClassObj=[[HistorySegmentedHeader alloc]initWithFrame:CGRectMake(0,78, self.view.frame.size.width, 20)];
    GetcreditsClassObj.ProductTypeDelegate=self;
    [GetcreditsClassObj DrawSegemntedControl : RequestParamArray:TabArray :TabArray :self.myThemeType];
     
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];

    
    [[UISegmentedControl appearance] setTintColor:[MegoConvertColor colorWithHexString:@"e2e2e2"]];
    [UISegmentedControl appearance].layer.borderColor=(__bridge CGColorRef)([UIColor clearColor]);
  
    [myview  addSubview: GetcreditsClassObj];
    
}


-(void)ProductTypeClick:(NSString*)PtypeID Version:(NSString *)Version
{
    if([PtypeID isEqualToString:@"BUY"])
    {     [ThemeCollectionView removeFromSuperview];
        
        segmentview=[[UIView alloc]initWithFrame:CGRectMake(0,GetcreditsClassObj.frame.origin.y+GetcreditsClassObj.frame.size.height+35, myview.frame.size.width, myview.frame.size.height)];
        
        [myview addSubview:segmentview];
        NSLog(@"myfaviourate 11111get successfully");
//        getbuyobj=[[MewardBuyClass alloc]init];
//        [segmentview addSubview:getbuyobj.view];
        
        
    }
    if([PtypeID isEqualToString:@"EARN"])
    {
        NSLog(@"mystuff33333333 get successfully");
        [segmentview removeFromSuperview];
//        [getbuyobj.view removeFromSuperview];
        [ myview addSubview:ThemeCollectionView];
        
    }
}


#pragma mark - collectionViewdelegate  delegate methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (self.ThemeDataArray.count);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(-10, 10, 60, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    CGSize itemSize;
    if(indexPath.row<self.ThemeDataArray.count)
    {
         MegoHistoryCredit*data =[self.ThemeDataArray objectAtIndex:indexPath.row];
        CGSize itemSize = CGSizeMake(data.creditview.frame.size.width,data.creditview.frame.size.height);
        return itemSize;
    }
    return itemSize;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (UICollectionViewCell *cell in [ThemeCollectionView visibleCells])
    {
        NSIndexPath *ThemeCollectionViewIndexPath = [ThemeCollectionView indexPathForCell:cell];
        NSUInteger lastIndex = [ThemeCollectionViewIndexPath indexAtPosition:[ThemeCollectionViewIndexPath length] - 1];
        
        NSLog(@"visible cell value for UICollectionViewCell%lu",(unsigned long)lastIndex);
        if(lastIndex<= self.ThemeDataArray.count-1)
        {
            MegoHistoryCredit *ThemeData = [ self.ThemeDataArray objectAtIndex:lastIndex];
            if(ThemeData.IsThumbnailLoaded==false)
            {
                [ThemeData DownloadImage];
            }
        }
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MegoHistoryCustomcell *cell = (MegoHistoryCustomcell *)[ThemeCollectionView dequeueReusableCellWithReuseIdentifier:simpleCollectionIdentifier forIndexPath:indexPath];
    MegoHistoryCredit *data =[self.ThemeDataArray objectAtIndex:indexPath.row];
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:simpleCollectionIdentifier forIndexPath:indexPath];
        [cell setupInternalDataWithData:data];
    }
    [ThemeCollectionView registerClass:[MegoHistoryCustomcell class]
            forCellWithReuseIdentifier:[NSString stringWithFormat:@"%ldss",(long)indexPath.row]];
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%ldss",(long)indexPath.row] forIndexPath:indexPath];
    [cell setupInternalDataWithData:data];
    if (ThemeCollectionView.dragging == NO && ThemeCollectionView.decelerating == NO)
    {
        {
            [data DownloadImage];
        }
    }
    
    data.ButtonClickDelegate=self;
    return cell;
}



-(void)BackBtnClick
{
    //      mainCategoryObj=[[CategoryThemeView alloc]init];
    //      [self.navigationController pushViewController:mainCategoryObj animated:NO];
    //    [_ObjMewardServerModel SaveRemainingCoin:GetCrdtvalue.text];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)ReloadBtnClick
{
    
    NSString *connection=[self NetworkConnectionType];
    
    if([connection isEqualToString:@"wifi"]||[connection isEqualToString:@"2g"]||[connection isEqualToString:@"3g"]||[connection isEqualToString:@"4g"]||[connection isEqualToString:@"lte"])
    {
    
        MegoHistoryclasss *history=[[MegoHistoryclasss alloc]init];
        [self.navigationController pushViewController:history animated:true];



    }
    else
    {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"hoho!"
                              message:@"Connect device to Internet connection!"
                              delegate:nil
                              cancelButtonTitle:@" OK" otherButtonTitles:nil];
        [alert show];
        
    }
}



-(NSString*)NetworkConnectionType
{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetworkItemView = nil;
    NSString *ConnectionType;
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]])
        {
            dataNetworkItemView = subview;
            break;
        }
    }
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue]) {
        case 0:
            ConnectionType=@"no wifi or cellular";
            break;
            
        case 1:
            ConnectionType=@"2g";
            break;
            
        case 2:
            ConnectionType=@"3g";
            break;
        case 3:
            ConnectionType=@"4g";
            break;
            
        case 4:
            ConnectionType=@"lte";
            break;
            
        case 5:
            ConnectionType=@"wifi";
            break;
            
        default:
            break;
    }
    return ConnectionType;
}


@end

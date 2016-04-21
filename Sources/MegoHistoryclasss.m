//
//  MigitalStoreSDK
//
//  Created by David on 7/13/15.
//
#import "MegoHistoryclasss.h"
#import "MegoHistoryCustomcell.h"
#import "MegoHistoryServerModel.h"
#import "SDKHistoryManager.h"
#import "MegoConvertColor.h"
#import "HistorySegmentedHeader.h"
#import "MegoHistoryCredit.h"
#import  "MegoRedeemedHistory.h"

#define LOADING_CELL_IDENTIFIER @"LoadingItemCell"

@interface MegoHistoryclasss ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) MegoHistoryServerModel *ObjMewardServerModel;
@end

//@class MewardCreditclass;
//@class MewardRedeemed_class;

@implementation MegoHistoryclasss
{
     HistorySegmentedHeader *GetcreditsClassObj;
     MegoHistoryCredit    *dataView;
     MegoRedeemedHistory  *getredemeedobj;
}

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
     [MainView setBackgroundColor:[MegoConvertColor colorWithHexString:@"f7852c"]];
    [self.view addSubview:MainView];
    ThemeDataArray=[[NSMutableArray alloc]init];
    
    _ObjMewardServerModel=[[MegoHistoryServerModel alloc]init];
    self.TableImages=[[NSMutableArray alloc]init];
    
    myview =[[UIView alloc]initWithFrame:CGRectMake(0, Header.frame.origin.y+Header.frame.size.height+40, MainView.frame.size.width, MainView.frame.size.height-20)];
    
    [myview setBackgroundColor:[UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1]];
    
    [MainView addSubview:myview];
    
    layout=[[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    layout.minimumLineSpacing=2;
    collectionRect = CGRectMake(0, 68 ,myview.frame.size.width, MainView.frame.size.height-(Header.frame.origin.y+Header.frame.size.height)-80);
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
    [self GetHeader:[_ObjMewardServerModel GetRemainingCoinBalance]];
    dataView=[[MegoHistoryCredit alloc]init];

      [self AuthenticationServiceSuccessHandller];
     [SDKHistoryManager startProgressBar:self.view :@"Please Wait..."];

    
}

-(void)AuthenticationServiceSuccessHandller
{
     [_ObjMewardServerModel FetchEarnedHistory];
    
}



-(void)ServiceSuccessHandller:(NSData*)data
{
    NSLog(@"ServiceSuccessHandller");
    ThemeDataArray =[_ObjMewardServerModel ParseJsonEarnedHistoryView:data];
    [ThemeCollectionView reloadData];
    if(ThemeDataArray.count<=0)
    {
        [SDKHistoryManager ShowCommonAlert:@"Not Found" MsgBody:@"No Record Found!"];
    }
    dispatch_async(dispatch_get_main_queue(),^
                   {
                       [SDKHistoryManager stopProgressBar];
                   });
}

-(void)CoinUpdated:(NSDictionary*)Response
{
       
}

-(void)ServieFailedHandller:(NSString*)ErrorDescription
{
    [SDKHistoryManager stopProgressBar];
}

-(void)GetHeader:(NSString *)GetCreditvalue;
{
    Header =[[UIImageView alloc]initWithFrame:CGRectMake(0, 19, self.view.frame.size.width, 54)];
    Header.userInteractionEnabled=YES;
   Header.backgroundColor=[MegoConvertColor colorWithHexString:@"f7852c"];
    [MainView addSubview:Header];
    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 7, 30, 38)];
    [back setImage:[MegoHistoryServerModel getImageFromBundle:@"goBack_un"] forState:UIControlStateNormal];
    
    [back addTarget:self action:@selector(BackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    back.titleLabel.font=[UIFont fontWithName:@"Arial" size:15];
    back.showsTouchWhenHighlighted=YES;
    [Header addSubview:back];
    
    UILabel *Backlabel=[[UILabel alloc] initWithFrame:CGRectMake(back.frame.origin.x+back.frame.size.width-5,back.frame.origin.y-2,50,40)];
    Backlabel.text=@"Back";
    Backlabel.font=[UIFont fontWithName:@"Arial" size:18];
    Backlabel.backgroundColor = [UIColor clearColor];
    Backlabel.textColor = [UIColor whiteColor];
    Backlabel.textAlignment=NSTextAlignmentLeft;
    [Header addSubview:Backlabel];
    
    UILabel *GetCredit=[[UILabel alloc] initWithFrame:CGRectMake((Header.frame.size.width-80)/2,Backlabel.frame.origin.y,90,40)];
    GetCredit.text=@"History";
    GetCredit.font=[UIFont boldSystemFontOfSize:18];
    GetCredit.backgroundColor = [UIColor clearColor];
    GetCredit.textColor = [UIColor whiteColor];
    GetCredit.textAlignment=NSTextAlignmentLeft;
    [Header addSubview:GetCredit];
    
    UIImageView *StoreImage=[[UIImageView alloc]initWithFrame:CGRectMake(Header.frame.size.width-80,Backlabel.frame.origin.y+12.5f,15,15)];
    StoreImage.userInteractionEnabled=NO;
    StoreImage.image= [UIImage imageNamed:@"credit.png"];
//    [Header addSubview:StoreImage];
    
    UILabel *GetCrdtvalue=[[UILabel alloc] initWithFrame:CGRectMake(StoreImage.frame.origin.x+StoreImage.frame.size.width+5,Backlabel.frame.origin.y+10,60,30)];
    GetCrdtvalue.text=GetCreditvalue;
    GetCrdtvalue.font=[UIFont fontWithName:@"Arial" size:18];
    GetCrdtvalue.backgroundColor = [UIColor clearColor];
    GetCrdtvalue.textColor = [UIColor whiteColor];
    GetCrdtvalue.textAlignment=NSTextAlignmentLeft;
    GetCrdtvalue.numberOfLines=1;
     [GetCrdtvalue sizeToFit];
//    [Header addSubview:GetCrdtvalue];
    GetCrdtvalue.text=[_ObjMewardServerModel GetRemainingCoinBalance];

}

-(void)ShowHeaderSegmented
{
    RequestParamArray=[[NSMutableArray alloc]initWithObjects:@"EARNED",@"REDEEMED", nil];
    TabArray=[[NSMutableArray alloc]initWithObjects:@"EARNED",@"REDEEMED", nil];
    GetcreditsClassObj=[[HistorySegmentedHeader alloc]initWithFrame:CGRectMake(0, 54+15.6f, self.view.frame.size.width, 20)];
    GetcreditsClassObj.ProductTypeDelegate=self;
    [GetcreditsClassObj DrawSegemntedControl : RequestParamArray:TabArray :TabArray :self.myThemeType];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    
    [[UISegmentedControl appearance] setTintColor:[MegoConvertColor colorWithHexString:@"f7852c"]];
    [UISegmentedControl appearance].layer.borderColor=(__bridge CGColorRef)([UIColor clearColor]);
    [MainView  addSubview: GetcreditsClassObj];
}


-(void)ProductTypeClick:(NSString*)PtypeID Version:(NSString *)Version
{
    if([PtypeID isEqualToString:@"REDEEMED"])
    {
        NSLog(@"myfaviourate 11111get successfully");
        getredemeedobj=nil;
        getredemeedobj=[[MegoRedeemedHistory alloc]init];
        [ThemeCollectionView removeFromSuperview];
        [myview addSubview:getredemeedobj.view];
    }
    else
    {
        NSLog(@"mystuff33333333 get successfully");
        getredemeedobj.view=nil;
        getredemeedobj=nil;
        [myview addSubview:ThemeCollectionView];
    }
}



#pragma mark - collectionViewdelegate  delegate methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ThemeDataArray.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(-10, 10, 68, 10);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    CGSize itemSize;
    if(indexPath.row<ThemeDataArray.count)
    {
        MegoHistoryCredit *data =[ThemeDataArray objectAtIndex:indexPath.row];
        CGSize itemSize = CGSizeMake(data.creditview.frame.size.width,data.creditview.frame.size.height);
        return itemSize;
    }
    return itemSize;
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MegoHistoryCustomcell *cell = (MegoHistoryCustomcell *)[ThemeCollectionView dequeueReusableCellWithReuseIdentifier:simpleCollectionIdentifier forIndexPath:indexPath];
    MegoHistoryCredit *data =[ThemeDataArray objectAtIndex:indexPath.row];
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (UICollectionViewCell *cell in [ThemeCollectionView visibleCells])
    {
        NSIndexPath *ThemeCollectionViewIndexPath = [ThemeCollectionView indexPathForCell:cell];
        NSUInteger lastIndex = [ThemeCollectionViewIndexPath indexAtPosition:[ThemeCollectionViewIndexPath length] - 1];
        NSLog(@"visible cell value for UICollectionViewCell%lu",(unsigned long)lastIndex);
        if(lastIndex<= ThemeDataArray.count-1)
        {
            MegoHistoryCredit *ThemeData = [ ThemeDataArray objectAtIndex:lastIndex];
            if(ThemeData.IsThumbnailLoaded==false)
            {
                [ThemeData DownloadImage];
            }
        }
    }
}

-(void)BackBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)ReloadBtnClick
{
     [SDKHistoryManager startProgressBar:self.view :@"Please Wait..."];
     [_ObjMewardServerModel FetchEarnedHistory];
}

@end

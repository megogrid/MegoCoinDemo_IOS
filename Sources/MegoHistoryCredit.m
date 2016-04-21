//
//  Creditclass.m
//
//  Created by David on 7/10/15.

#import "MegoHistoryCredit.h"
#import "MegoConvertColor.h"
#import "SDKHistoryManager.h"
#import "HistoryHeaderView.h"
#import "HistoryGetCredits.h"
#import "MegoHistoryclasss.h"
#import "MegoRedeemedHistory.h"
#import "MegoHistoryServerModel.h"
#import "HistoryGetCredits.h"


@implementation MegoHistoryCredit

@synthesize creditview = creditview;


+ (id)dataWithgetCredit:(NSString *)CreditName CreditDescription:(NSString *)CreditDescription  CreditShareCount:(NSString*)CreditShareCount CreditImage:(UIImage*)CreditImage headerColor:(NSString *)headerColor itemtype:(int)itemtype Buttontype:(int)Buttontype
{
    return [[MegoHistoryCredit alloc]initWithgetCredit:CreditName CreditDescription:CreditDescription  CreditShareCount:CreditShareCount CreditImage:CreditImage headerColor:headerColor  itemtype:itemtype Buttontype:Buttontype];
}

-(id)initWithgetCredit:(NSString *)CreditName CreditDescription:(NSString *)CreditDescription  CreditShareCount:(NSString*)CreditShareCount CreditImage:(UIImage*)CreditImage headerColor:(NSString *)headerColor itemtype:(int)itemtype Buttontype:(int)Buttontype
{
    
    UIView *FullView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 75)];
     FullView.backgroundColor= [UIColor whiteColor];
    
    
    
    if(itemtype==Banner)
    {
        viewImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, (FullView.frame.size.height-40)/2, FullView.frame.size.width-120, 40)];
        viewImage.image=CreditImage;
        [FullView addSubview:viewImage];
    }
    
    if(itemtype==Text)
    {
        UILabel *Name = [[UILabel alloc]initWithFrame:CGRectMake(20,20,200, 30)];
        Name.backgroundColor=[UIColor clearColor];
        Name.text=CreditName;
        Name.textColor=[UIColor blackColor];
        Name.textAlignment=NSTextAlignmentLeft;
        UIFont *fontn = [UIFont systemFontOfSize:14];
        Name.font=fontn;
        [FullView addSubview:Name];
        
        
        UILabel *discription=[[UILabel alloc]initWithFrame:CGRectMake(20,45,200, 30)];
        discription.backgroundColor=[UIColor clearColor];
        discription.text=CreditDescription;
        discription.textColor=[UIColor blackColor];
        discription.textAlignment=NSTextAlignmentLeft;
        UIFont *fontn1 = [UIFont systemFontOfSize:14];
        discription.font=fontn1;
        [FullView addSubview:discription];

        
    }
    
    if(itemtype==TextICON)
    {
        viewImage = [[UIImageView alloc]initWithFrame:CGRectMake(15,15,50, 50)];
        viewImage.image=CreditImage;
        [FullView addSubview:viewImage];
        
        UILabel *Name = [[UILabel alloc]initWithFrame:CGRectMake(70,20,150, 30)];
        Name.backgroundColor=[UIColor clearColor];
        Name.text=CreditName;
        Name.textColor=[UIColor blackColor];
        Name.textAlignment=NSTextAlignmentLeft;
        UIFont *fontn = [UIFont systemFontOfSize:14];
        Name.font=fontn;
        [FullView addSubview:Name];
        
        
        
        UILabel *discription=[[UILabel alloc]initWithFrame:CGRectMake(67 ,45,200, 30)];
        discription.backgroundColor=[UIColor clearColor];
        discription.text=CreditDescription;
        discription.textColor=[UIColor blackColor];
        discription.textAlignment=NSTextAlignmentLeft;
        UIFont *fontn1 = [UIFont systemFontOfSize:13];
        discription.font=fontn1;
        [FullView addSubview:discription];
    }




    else if(itemtype==Application)
    {
        viewImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, (FullView.frame.size.height-60)/2, FullView.frame.size.width-240, 60)];
        viewImage.image=CreditImage;
        [FullView addSubview:viewImage];
    }
    
    UIButton *creditsBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, (FullView.frame.size.height-25)/2,300,30)];
    [creditsBtn addTarget:self action:@selector(creditsBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    [creditsBtn setBackgroundColor:[UIColor clearColor]];
    
    if(Buttontype==Action)
    {
        [creditsBtn setImage:[MegoHistoryServerModel getImageFromBundle:@"agree_un"] forState:UIControlStateNormal];
        [creditsBtn setImage:[MegoHistoryServerModel getImageFromBundle:@"agree_un"] forState:UIControlStateHighlighted];
    }
    else if(Buttontype==Install)
    {
        
        UIImageView *Creditimage=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width+220, 0,30,30)];
        Creditimage.image=[MegoHistoryServerModel getImageFromBundle:@"download_un"];
        [creditsBtn addSubview:Creditimage];

    }
    else if(Buttontype==Videos)
    {
        [creditsBtn setImage:[MegoHistoryServerModel getImageFromBundle:@"video_un"] forState:UIControlStateNormal];
        [creditsBtn setImage:[MegoHistoryServerModel getImageFromBundle:@"video_un"] forState:UIControlStateHighlighted];
    }
    else if(Buttontype==Share)
    {
        UIImageView *Creditimage=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width+220, 0,30,30)];
        Creditimage.image=[MegoHistoryServerModel getImageFromBundle:@"share_un"];
        [creditsBtn addSubview:Creditimage];

    }
    else if(Buttontype==share1)
    {
        
        UIImageView *creditsBtn1=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width+220, 0,30,30)];
        creditsBtn1.image=[MegoHistoryServerModel getImageFromBundle:@"twowayshare_s"];
        [creditsBtn addSubview:creditsBtn1];
    }

    else
    {
        [creditsBtn setImage:[MegoHistoryServerModel getImageFromBundle:@"video_un"] forState:UIControlStateNormal];
        [creditsBtn setImage:[MegoHistoryServerModel getImageFromBundle:@"video_un"] forState:UIControlStateHighlighted];
    }
    [creditsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [creditsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    creditsBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:11];
    [FullView addSubview:creditsBtn];
        
        
    UILabel *linelbl=[[UILabel alloc]initWithFrame:CGRectMake(FullView.frame.size.width-60,(FullView.frame.size.height-40)/2 , 1, 40)];
    linelbl.backgroundColor=[UIColor colorWithRed:0.82f green:0.82f blue:0.82f alpha:1];
    [FullView addSubview:linelbl];
    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(FullView.frame.size.width-50, (FullView.frame.size.height-24)/2,29 ,29)];
    [buyBtn addTarget:self action:@selector(buyBtnClick)forControlEvents:UIControlEventTouchUpInside];
    buyBtn.layer.cornerRadius=buyBtn.frame.size.height/2;
    buyBtn.clipsToBounds=YES;
    buyBtn.userInteractionEnabled=NO;
    
    [buyBtn setTitle:[@"" stringByAppendingString:CreditShareCount] forState:UIControlStateNormal];
    [buyBtn setTitle:[@"" stringByAppendingString:CreditShareCount] forState:UIControlStateHighlighted];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    buyBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:10];

    NSInteger buyNo=[buyBtn.titleLabel.text integerValue];
    if(buyNo<=599 )
    {
        buyBtn.backgroundColor=[UIColor colorWithRed:221/255.f green:133/255.f blue:70/255.f alpha:1];
    }
    else if ((buyNo>599) || (buyNo <=999 ))
    {
        buyBtn.backgroundColor=[UIColor colorWithRed:164/255.f green:91/255.f blue:179/255.f alpha:1];
    }
    
   
    else if (buyNo>=1000)
    {
      [buyBtn setBackgroundColor:[MegoConvertColor colorWithHexString:@"0xbd5151"]];
    }


    [FullView addSubview:buyBtn];
    
    self.CreditName=CreditName;
    self.CreditDescription=CreditDescription;
    self.CreditImage=CreditImage;
    self.CoinsCount=CreditShareCount;
    self.Buttontype=Buttontype;
    return [self initWithView:FullView];
}


+ (id)dataWithBuyCredit:(NSString*)CreditShareCount CreditDollarCount:(NSString*)CreditDollarCount DollarImage:(UIImage*)DollarImage
{
    return [[MegoHistoryCredit alloc]initWithBuyCredit:CreditShareCount CreditDollarCount:CreditDollarCount DollarImage:DollarImage];
}

-(id)initWithBuyCredit:(NSString*)CreditShareCount CreditDollarCount:(NSString*)CreditDollarCount DollarImage:(UIImage*)DollarImage
{
    UIView *FullView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-12, 60)];
    FullView.layer.cornerRadius = 8.0f;
    FullView.clipsToBounds=YES;
    FullView.backgroundColor= [UIColor whiteColor];
    
    viewImage = [[UIImageView alloc]initWithFrame:CGRectMake(FullView.frame.size.width-290, (FullView.frame.size.height-32)/2, 32, 32)];
    viewImage.image= DollarImage;
    [FullView addSubview:viewImage];
    
    
    UILabel *DollarCount = [[UILabel alloc]initWithFrame:CGRectMake(viewImage.frame.origin.x+viewImage.frame.size.width+10, viewImage.frame.origin.y, 130, 30)];
    DollarCount.text=CreditDollarCount;
    DollarCount.textColor=[UIColor blackColor];
    DollarCount.textAlignment=NSTextAlignmentLeft;
    UIFont *font1 = [UIFont systemFontOfSize:16];
    DollarCount.font=font1;
    [FullView addSubview:DollarCount];
    
    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(FullView.frame.size.width-60, (FullView.frame.size.height-40)/2,40,40)];
    [buyBtn addTarget:self action:@selector(buyBtnClick)forControlEvents:UIControlEventTouchUpInside];
    buyBtn.layer.cornerRadius=buyBtn.frame.size.height/2;
    buyBtn.clipsToBounds=YES;
    
    buyBtn.userInteractionEnabled=NO;
    [buyBtn setBackgroundColor:[MegoConvertColor colorWithHexString:@"0xbd5151"]];
    [buyBtn setTitle:[@"" stringByAppendingString:CreditShareCount] forState:UIControlStateNormal];
    [buyBtn setTitle:[@"" stringByAppendingString:CreditShareCount] forState:UIControlStateHighlighted];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    buyBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:11];
    [FullView addSubview:buyBtn];
    
    self.CoinsCount=CreditShareCount;
    self.DollarImage=DollarImage;
    self.CreditDollarCount=CreditDollarCount;
    return [self initWithView:FullView];
    
}

+ (id)dataWithHistory:(NSString *)HistoryName HistoryDate:(NSString *)HistoryDate  HistoryShareCount:(NSString*)HistoryShareCount HistoryImage:(UIImage*)HistoryImage headerColor:(NSString *)headerColor HistoryButtontype:(int)HistoryButtontype
{
    return [[MegoHistoryCredit alloc]initWithHistory:HistoryName HistoryDate:HistoryDate  HistoryShareCount:HistoryShareCount HistoryImage:HistoryImage headerColor:headerColor HistoryButtontype:HistoryButtontype];
}
-(id)initWithHistory:(NSString *)HistoryName HistoryDate:(NSString *)HistoryDate  HistoryShareCount:(NSString*)HistoryShareCount HistoryImage:(UIImage*)HistoryImage headerColor:(NSString *)headerColor HistoryButtontype:(int)HistoryButtontype
{
    
    
     NSLog(@"IN FUNCTION");
    
    UIView *FullView = [[UIView alloc]initWithFrame:CGRectMake(0,3, [UIScreen mainScreen].bounds.size.width, 65)];
    FullView.backgroundColor= [UIColor whiteColor];
    
    viewImage = [[UIImageView alloc]initWithFrame:CGRectMake(16, (FullView.frame.size.height-50)/2, FullView.frame.size.width-240, 50)];
    viewImage.image=HistoryImage;
    [FullView addSubview:viewImage];
    
    
    
    UILabel *Name = [[UILabel alloc]initWithFrame:CGRectMake(viewImage.frame.origin.x+viewImage.frame.size.width+15, viewImage.frame.origin.y,100, 30)];
    Name.backgroundColor=[UIColor clearColor];
    Name.text=HistoryName;
    Name.textColor=[UIColor blackColor];
    Name.textAlignment=NSTextAlignmentLeft;
    UIFont *font1 = [UIFont systemFontOfSize:14];
    Name.font=font1;
    [FullView addSubview:Name];
    
    UILabel *Discription = [[UILabel alloc]initWithFrame:CGRectMake(Name.frame.origin.x, Name.frame.origin.y+Name.frame.size.height+1,100, 30)];
    Discription.backgroundColor=[UIColor clearColor];
    UIFont *font = [UIFont systemFontOfSize:11];
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    CGSize expectedLabelSize = [HistoryDate sizeWithFont:font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    CGRect newFrame = Discription.frame;
    newFrame.size.height = expectedLabelSize.height;
    Discription.frame = newFrame;
    Discription.numberOfLines=0;
    Discription.text = HistoryDate;
    Discription.font = font;
    Discription.textColor=[UIColor blackColor];
    Discription.textAlignment=NSTextAlignmentLeft;
    [FullView addSubview:Discription];
    
    UIButton *creditsBtn = [[UIButton alloc]initWithFrame:CGRectMake(FullView.frame.size.width-100, (FullView.frame.size.height-30)/2,40,40)];
    [creditsBtn setBackgroundColor:[UIColor clearColor]];
    if(HistoryButtontype==Action)
    {
        [creditsBtn setImage:[MegoHistoryServerModel getImageFromBundle:@"agree_se"] forState:UIControlStateNormal];
        [creditsBtn setImage:[MegoHistoryServerModel getImageFromBundle:@"agree_se"] forState:UIControlStateHighlighted];
    }
    else if(HistoryButtontype==Install)
    {
        
        
        UIImageView *creditsBtn1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,30,30)];
        creditsBtn1.image=[MegoHistoryServerModel getImageFromBundle:@"download_un"];
        [creditsBtn addSubview:creditsBtn1];
    }
    else if(HistoryButtontype==Videos)
    {
        [creditsBtn setImage:[MegoHistoryServerModel getImageFromBundle:@"video_se"] forState:UIControlStateNormal];
        [creditsBtn setImage:[MegoHistoryServerModel getImageFromBundle:@"video_se"] forState:UIControlStateHighlighted];
    }
    else if(HistoryButtontype==Share)
    {
        
        UIImageView *creditsBtn1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,30,30)];
        creditsBtn1.image=[MegoHistoryServerModel getImageFromBundle:@"share_un"];
        [creditsBtn addSubview:creditsBtn1];

    }
    else if(HistoryButtontype==share1)
    {
        
        UIImageView *creditsBtn1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,30,30)];
        creditsBtn1.image=[MegoHistoryServerModel getImageFromBundle:@"twowayshare_s"];
        [creditsBtn addSubview:creditsBtn1];
       
    }

    
        else
    {
        
        [creditsBtn setImage:[MegoHistoryServerModel getImageFromBundle:@"video_se"] forState:UIControlStateNormal];
        [creditsBtn setImage:[MegoHistoryServerModel getImageFromBundle:@"video_se"] forState:UIControlStateHighlighted];
    }
    
    [creditsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [creditsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    creditsBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:11];
    [FullView addSubview:creditsBtn];
    
    
    UILabel *linelbl=[[UILabel alloc]initWithFrame:CGRectMake(FullView.frame.size.width-60,(FullView.frame.size.height-40)/2 , 1, 40)];
    linelbl.backgroundColor=[UIColor colorWithRed:0.82f green:0.82f blue:0.82f alpha:1];
    [FullView addSubview:linelbl];
    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(FullView.frame.size.width-50, (FullView.frame.size.height-24)/2,30,30)];
   
    buyBtn.layer.cornerRadius=buyBtn.frame.size.height/2;
    buyBtn.clipsToBounds=YES;
    buyBtn.userInteractionEnabled=NO;

    
    
    NSInteger buyNo=[HistoryShareCount integerValue];
    if(buyNo<=599 )
    {
        buyBtn.backgroundColor=[UIColor colorWithRed:221/255.f green:133/255.f blue:70/255.f alpha:1];
    }
    else if ((buyNo>599) || (buyNo <=999 ))
    {
        buyBtn.backgroundColor=[UIColor colorWithRed:164/255.f green:91/255.f blue:179/255.f alpha:1];
    }
    
    
    else if (buyNo>=1000)
    {
        [buyBtn setBackgroundColor:[MegoConvertColor colorWithHexString:@"0xbd5151"]];
    }

    [buyBtn setTitle:[@"" stringByAppendingString:HistoryShareCount] forState:UIControlStateNormal];
    [buyBtn setTitle:[@"" stringByAppendingString:HistoryShareCount] forState:UIControlStateHighlighted];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    buyBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:11];
    [FullView addSubview:buyBtn];
    
    self.HistoryName=HistoryName;
    self.HistoryDate=HistoryDate;
    self.HistoryImage=HistoryImage;
    self.HistoryButtontype=HistoryButtontype;
    self.HistoryShareCount=HistoryShareCount;
    return [self initWithView:FullView];
}


+ (id)dataWithRedeemed:(NSString *)RedeemedName RedeemedDate:(NSString *)RedeemedDate  RedeemedShareCount:(NSString*)RedeemedShareCount RedeemedImage:(UIImage*)RedeemedImage ;

{
    return [[MegoHistoryCredit alloc]initWithRedeemed:RedeemedName RedeemedDate:RedeemedDate  RedeemedShareCount:RedeemedShareCount RedeemedImage:RedeemedImage] ;
}

-(id)initWithRedeemed:(NSString *)RedeemedName RedeemedDate:(NSString *)RedeemedDate  RedeemedShareCount:(NSString*)RedeemedShareCount RedeemedImage:(UIImage*)RedeemedImage

{
    UIView *FullView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 65)];
    FullView.backgroundColor= [UIColor whiteColor];
    
    
    viewImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, (FullView.frame.size.height-40)/2, FullView.frame.size.width-260, 40)];
    NSLog(@"width:%f",viewImage.frame.size.width);
    viewImage.layer.cornerRadius=viewImage.frame.size.height/2;
    viewImage.clipsToBounds=YES;
    viewImage.image=RedeemedImage;
    
    [FullView addSubview:viewImage];
    
    UILabel *Name = [[UILabel alloc]initWithFrame:CGRectMake(viewImage.frame.origin.x+viewImage.frame.size.width+10, viewImage.frame.origin.y, 130, 25)];
    Name.backgroundColor=[UIColor clearColor];
    Name.text=RedeemedName;
    Name.textColor=[UIColor blackColor];
    Name.textAlignment=NSTextAlignmentLeft;
    Name.font=[UIFont systemFontOfSize:16];
    [FullView addSubview:Name];
    
    UILabel *Discription = [[UILabel alloc]initWithFrame:CGRectMake(Name.frame.origin.x, Name.frame.origin.y+Name.frame.size.height+2, Name.frame.size.width, 32)];
    Discription.backgroundColor=[UIColor clearColor];
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    CGSize expectedLabelSize = [RedeemedDate sizeWithFont:font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    CGRect newFrame = Discription.frame;
    newFrame.size.height = expectedLabelSize.height;
    Discription.frame = newFrame;
    Discription.numberOfLines=0;
    Discription.text = RedeemedDate;
    Discription.font = font;
    Discription.textColor=[UIColor blackColor];
    Discription.textAlignment=NSTextAlignmentLeft;
    [FullView addSubview:Discription];
    
    
    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(FullView.frame.size.width-60, (FullView.frame.size.height-25)/2,25,25)];
    [buyBtn addTarget:self action:@selector(buyBtnClick)forControlEvents:UIControlEventTouchUpInside];
    buyBtn.layer.cornerRadius=buyBtn.frame.size.height/2;
    buyBtn.clipsToBounds=YES;
    buyBtn.userInteractionEnabled=NO;
    buyBtn.backgroundColor=[UIColor lightGrayColor];
    [buyBtn setTitle:[@"" stringByAppendingString:RedeemedShareCount] forState:UIControlStateNormal];
    [buyBtn setTitle:[@"" stringByAppendingString:RedeemedShareCount] forState:UIControlStateHighlighted];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    buyBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:11];
    [FullView addSubview:buyBtn];
    
    self.RedeemedImage=RedeemedImage;
    self.RedeemedName=RedeemedName;
    self.RedeemedDate=RedeemedDate;
    self.RedeemedShareCount=RedeemedShareCount;
    return [self initWithView:FullView];
    
}



+(id)dataWithHeaderRedeemed:(NSString *)HeaderName HeaderShareCount:(NSString*)HeaderShareCount HeaderImage:(UIImage*)HeaderImage
{
    return [[MegoHistoryCredit alloc]initWithHeaderRedeemed:HeaderName HeaderShareCount:HeaderShareCount HeaderImage:HeaderImage];
}

-(id)initWithHeaderRedeemed:(NSString *)HeaderName HeaderShareCount:(NSString*)HeaderShareCount HeaderImage:(UIImage*)HeaderImage
{
    UIView *sectionHeaderView2 = [[UIView alloc] initWithFrame:
                                  CGRectMake(10,0, [UIScreen mainScreen].bounds.size.width-20, 60)];
    
    sectionHeaderView2.layer.cornerRadius=4.0f;
    sectionHeaderView2.clipsToBounds=YES;
    sectionHeaderView2.userInteractionEnabled=YES;
    sectionHeaderView2.backgroundColor=[UIColor whiteColor];
   
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(10, sectionHeaderView2.frame.size.height-1, sectionHeaderView2.frame.size.width-20, 1)];
    lineLabel.backgroundColor = [UIColor colorWithRed:231/256.f green:230/256.f blue:231/256.f alpha:1];
    [sectionHeaderView2 addSubview:lineLabel];
    
    
    
    lineLabel.backgroundColor = [UIColor colorWithRed:231/256.f green:230/256.f blue:231/256.f alpha:1];
    
    [sectionHeaderView2 addSubview:lineLabel];
    
    
   viewImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, (sectionHeaderView2.frame.size.height-40)/2, sectionHeaderView2.frame.size.width-260, 40)];
    NSLog(@"width:%f",viewImage.frame.size.width);
    viewImage.layer.cornerRadius=viewImage.frame.size.height/2;
    viewImage.clipsToBounds=YES;
    viewImage.image=HeaderImage;
    
    [sectionHeaderView2 addSubview:viewImage];
    
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(viewImage.frame.origin.x+viewImage.frame.size.width+20, 10, 100, 30)];
    
    headerLabel.text = HeaderName;
    headerLabel.textColor=[UIColor blackColor];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    [headerLabel setFont:[UIFont fontWithName:@"Arial" size:15.5]];
    [headerLabel sizeToFit];
    [sectionHeaderView2 addSubview:headerLabel];
    
    UILabel *headerLabel2 = [[UILabel alloc] initWithFrame:
                             CGRectMake(viewImage.frame.origin.x+viewImage.frame.size.width+20, 30, 60, 30)];
    headerLabel2.text = HeaderShareCount;
    headerLabel2.textColor=[UIColor colorWithRed:-0/256.f green:155/256.f blue:-0/256.f alpha:1];
    headerLabel2.backgroundColor = [UIColor clearColor];
    headerLabel2.textAlignment = NSTextAlignmentLeft;
    [headerLabel2 setFont:[UIFont fontWithName:@"Arial" size:12.5]];
    [headerLabel2 sizeToFit];
    [sectionHeaderView2 addSubview:headerLabel2];
    
    
    
    self.HeaderName=HeaderName;
    self.HeaderImage=HeaderImage;
    self.HeaderShareCount=HeaderShareCount;
    
    return [self initWithView:sectionHeaderView2];
  
}

-(void)DownloadImage
{
    if([SDKHistoryManager.ApplicationDataCache objectForKey:self.ImageUrl]==nil )
    {
        DownloadImage=[[MegoHistoryServerModel alloc]init];
        [ DownloadImage SingleImageDownloadService:self.ImageUrl];
        DownloadImage._delegate=self;
    }
    else
    {
        [self getImage:[SDKHistoryManager.ApplicationDataCache  objectForKey:self.ImageUrl]];
    }
}

-(void)getImage:(UIImage*)DownloadedImage;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       self.IsThumbnailLoaded=true;
                       viewImage.image=nil;
                       dispatch_async(dispatch_get_main_queue(),^
                                      {
                                          viewImage.image=DownloadedImage;
                                          if(DownloadedImage!=nil)
                                          {
                                              [SDKHistoryManager.ApplicationDataCache setObject:DownloadedImage forKey:self.ImageUrl];
                                          }
                                      });
                   });
}

- (id)initWithView:(UIView *)view
{
    self = [super init];
    if (self)
    {
        self.creditview=view;
    }
    return self;
}

-(void)buyBtnClick
{
    
}

-(void)creditsBtnClick:(id)sender
{
   
[ _ButtonClickDelegate ButtonClick:sender];
}




@end

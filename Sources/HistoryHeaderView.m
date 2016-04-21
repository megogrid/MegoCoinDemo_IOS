//
//  HHistoryHeaderView.m
//
//  Created by David-iphone on 2/6/15.
//

#import "HistoryHeaderView.h"
#import "MegoConvertColor.h"
//extern NSString * HeaderColorCode;


@implementation HistoryHeaderView
@synthesize HeaderDelegates;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self HeaderSection];
    }
    return self;
}



-(void)HeaderSection : (NSString *)headerStripColor :(NSString *)GetName :(UIImage *)GetImage :(int)ThemeType :(BOOL)BackText
{
    UIImageView *Header =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    Header.userInteractionEnabled=YES;
    Header.backgroundColor= [MegoConvertColor colorWithHexString:headerStripColor];
    
    Header.backgroundColor=[UIColor colorWithRed:0.89 green:0.43 blue:0.136 alpha:0.8];
    [self addSubview:Header];
    
//    if(ThemeType==LeoGrid || ThemeType== LeoList)
//    {
//        Header.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
//        
//        _searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [_searchBtn setFrame:CGRectMake(Header.frame.size.width-42,(Header.frame.size.height-19)/2, 19, 19)];
//        [_searchBtn setBackgroundImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
//        [_searchBtn setBackgroundColor:[UIColor clearColor]];
//        [_searchBtn addTarget:self action:@selector(searchBtnClick)forControlEvents:UIControlEventTouchUpInside];
//        [Header addSubview:_searchBtn];
//        _searchBtn.showsTouchWhenHighlighted=YES;
//        
//        
//        
//        UILabel *connectlabel=[[UILabel alloc] initWithFrame:CGRectMake((Header.frame.size.width-200)/2,(Header.frame.size.height-30)/2,200,30)];
//        connectlabel.text=GetName;
//        connectlabel.font=[UIFont fontWithName:@"Arial" size:16];
//        connectlabel.backgroundColor = [UIColor clearColor];
//        connectlabel.textColor = [UIColor whiteColor];
//        connectlabel.textAlignment=NSTextAlignmentCenter;
//        [Header addSubview:connectlabel];
//        
//        
//        _back = [[UIButton alloc]initWithFrame:CGRectMake(15, _searchBtn.frame.origin.y, 8, 13)];
//        [_back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//        [_back addTarget:self action:@selector(BackBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        _back.titleLabel.font=[UIFont fontWithName:@"Arial" size:15];
//        _back.hidden=NO;
//        
//        _back.showsTouchWhenHighlighted=YES;
//        [Header addSubview:_back];
//        
//    }
//    
//    else if(ThemeType==Iluiana ||ThemeType==IluianaGrid)
//    {
//        Header.backgroundColor=[UIColor whiteColor];
//        _searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [_searchBtn setFrame:CGRectMake(Header.frame.size.width-42,(Header.frame.size.height-30)/2, 30, 30)];
//        [_searchBtn setBackgroundImage:[UIImage imageNamed:@"btn_search.png"] forState:UIControlStateNormal];
//        [_searchBtn setBackgroundColor:[UIColor clearColor]];
//        [_searchBtn addTarget:self action:@selector(searchBtnClick)forControlEvents:UIControlEventTouchUpInside];
//        [Header addSubview:_searchBtn];
//        _searchBtn.showsTouchWhenHighlighted=YES;
//        
//        
//        _menuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [_menuBtn setFrame:CGRectMake(10,(Header.frame.size.height-34)/2, 30, 34)];
//        [_menuBtn setBackgroundImage:[UIImage imageNamed:@"btn_options.png"] forState:UIControlStateNormal];
//        [_menuBtn setBackgroundImage:[UIImage imageNamed:@"btn_options.png"] forState:UIControlStateHighlighted];
//        [_menuBtn addTarget:self action:@selector(menuBtnClick)forControlEvents:UIControlEventTouchUpInside];
//        [_menuBtn setBackgroundColor:[UIColor clearColor]];
//        [Header addSubview:_menuBtn];
//        _menuBtn.showsTouchWhenHighlighted=YES;
//        
//        UILabel *connectlabel=[[UILabel alloc] initWithFrame:CGRectMake((Header.frame.size.width-200)/2,(Header.frame.size.height-30)/2,200,30)];
//        connectlabel.text=GetName;
//        connectlabel.font=[UIFont fontWithName:@"Arial" size:16];
//        connectlabel.backgroundColor = [UIColor clearColor];
//        connectlabel.textColor = [UIColor colorWithRed:119/255.f green:112/255.f blue:21/255.f alpha:1];
//        connectlabel.textAlignment=NSTextAlignmentCenter;
//        [Header addSubview:connectlabel];
//        
//        
//        _back = [[UIButton alloc]initWithFrame:CGRectMake(0, 3, 30, 38)];
//        [_back setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
//        [_back addTarget:self action:@selector(BackBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        _back.titleLabel.font=[UIFont fontWithName:@"Arial" size:15];
//        _back.hidden=YES;
//        _back.showsTouchWhenHighlighted=YES;
//        [Header addSubview:_back];
//        
//        
//        
//    }
//    else
//    {
        _back = [[UIButton alloc]initWithFrame:CGRectMake(0, 3, 25, 38)];
        [_back setImage:[UIImage imageNamed:@"goBack_un.png"]forState:UIControlStateNormal];
        [_back addTarget:self action:@selector(BackBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _back.titleLabel.font=[UIFont fontWithName:@"Arial" size:15];
        _back.showsTouchWhenHighlighted=YES;
        [Header addSubview:_back];
        
        if(BackText==TRUE)
        {
            UILabel *back=[[UILabel alloc] init];
            back.text=@"Back";
            //connectlabel.font=[UIFont fontWithName:@"Arial" size:16];
            back.font=[UIFont boldSystemFontOfSize:19];
            [back sizeToFit];
            back.frame=CGRectMake(_back.frame.origin.x+_back.frame.size.width,Header.frame.size.height/2-back.frame.size.height/2,back.frame.size.width,back.frame.size.height);
            back.backgroundColor = [UIColor clearColor];
            back.textColor = [UIColor whiteColor];
            back.textAlignment=NSTextAlignmentLeft;
            [Header addSubview:back];
        }
        
        //        UIImageView *StoreImage=[[UIImageView alloc]initWithFrame:CGRectMake(_back.frame.origin.x+_back.frame.size.width,(Header.frame.size.height-32)/2,32,32)];
        //        StoreImage.userInteractionEnabled=YES;
        //        StoreImage.layer.cornerRadius=StoreImage.frame.size.height/2;
        //        StoreImage.clipsToBounds=YES;
        //        StoreImage.image=GetImage;
        //        [Header addSubview:StoreImage];
        
        
        //
        //            UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //            [searchBtn setFrame:CGRectMake(Header.frame.size.width-62,(Header.frame.size.height-19)/2, 19, 19)];
        //            [searchBtn setBackgroundImage:[UIImage imageNamed:@"nsearch_un"] forState:UIControlStateNormal];
        //            [searchBtn setBackgroundColor:[UIColor clearColor]];
        //            [searchBtn addTarget:self action:@selector(searchBtnClick)forControlEvents:UIControlEventTouchUpInside];
        //            [Header addSubview:searchBtn];
        //            searchBtn.showsTouchWhenHighlighted=YES;
        //
        //            UIButton *menuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //            [menuBtn setFrame:CGRectMake(Header.frame.size.width-35,(Header.frame.size.height-34)/2, 30, 34)];
        //            [menuBtn setBackgroundImage:[UIImage imageNamed:@"goMenu_un.png"] forState:UIControlStateNormal];
        //            [menuBtn addTarget:self action:@selector(menuBtnClick)forControlEvents:UIControlEventTouchUpInside];
        //            [menuBtn setBackgroundColor:[UIColor clearColor]];
        //            [Header addSubview:menuBtn];
        //            menuBtn.showsTouchWhenHighlighted=YES;
        
        UILabel *connectlabel=[[UILabel alloc] init];
        connectlabel.text=GetName;
        //connectlabel.font=[UIFont fontWithName:@"Arial" size:16];
        connectlabel.font=[UIFont boldSystemFontOfSize:19];
        [connectlabel sizeToFit];
        connectlabel.frame=CGRectMake(Header.frame.size.width/2-connectlabel.frame.size.width/2,Header.frame.size.height/2-connectlabel.frame.size.height/2,connectlabel.frame.size.width,connectlabel.frame.size.height);
        connectlabel.backgroundColor = [UIColor clearColor];
        connectlabel.textColor = [UIColor whiteColor];
        connectlabel.textAlignment=NSTextAlignmentLeft;
        [Header addSubview:connectlabel];
//    }
}
-(void)searchBtnClick
{
    [[self HeaderDelegates] searchBtnClick];
    
}

-(void)menuBtnClick
{
    [[self HeaderDelegates] MenuClick];
}

-(void)BackBtnClick
{
    [[self HeaderDelegates] backClick];
}

+(NSString *)HeaderColorAccToType :(int)ThemeType
{
//    NSString *colorStr=@"";
//    if(ThemeType==DarkBlue){
//        colorStr = @"0x486890";
//    }else if(ThemeType==SkyBlueGrid || ThemeType==SkyBlueList){
//        colorStr = @"0x599afe";
//    }else if (ThemeType==Orange){
//        colorStr = @"0xe73130";
//    }
//    
//    
//    
//    
//    return HeaderColorCode;


      return @"";
}



+(HistoryHeaderView *)HeaderPlacement :(NSString *)GetName :(UIImage *)GetImage :(UIView *)BaseView :(int)ThemeType :(BOOL)BackText
{
    HistoryHeaderView *Header = [[HistoryHeaderView alloc]initWithFrame:CGRectMake(0, 0, BaseView.frame.size.width, 45)];
    [Header setHeaderDelegates:self];
    NSString *headerStripColor=@"";
    
    //    if(ThemeType==DarkBlue){
    //        headerStripColor = @"0x486890";
    //    }else if(ThemeType==SkyBlueGrid || ThemeType==SkyBlueList){
    //        headerStripColor = @"0x599afe";
    //    }else if (ThemeType==Orange){
    //        headerStripColor = @"0xe73130";
    //    }
    
    
    
    
//    headerStripColor=HeaderColorCode;
    
    //    [Header HeaderSection :headerStripColor :GetName :GetImage];
    [Header HeaderSection:headerStripColor :GetName :GetImage :ThemeType :BackText];
    [BaseView addSubview:Header];
    return Header;
}

-(void)BtnClick
{
//    self.myThemeType=Iluiana;
//    NSLog(@"shaluclick");
}
@end

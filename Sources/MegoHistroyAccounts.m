
//  Accounts.m
//  PhotoApp
//  Created by Mohammad on 11/19/14.
//  Copyright (c) 2014 Migital. All rights reserved.

#import "MegoHistroyAccounts.h"
#import "SDKHistoryManager.h"
#import "MegoHistoryclasss.h"
#import "MegoHistoryServerModel.h"
//#import "MewardGiftCredit.h"
#import  "MegoHistoryCredit.h"
#import "HistoryGetCredits.h"


//extern Mewards *meward;

@interface MegoHistroyAccounts()<UITextFieldDelegate,MegoServerDataHandller,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    NSInteger closedSection;
    UITextField * alertTextField1;
}

//@property (strong, nonatomic) MewardGetCredits *GetCredits;
@property (strong, nonatomic)  MegoHistoryServerModel *ObjMewardServerModel;
@property(nonatomic,retain)NSString *width;
@property(nonatomic,retain)NSString *height;


@end


@implementation MegoHistroyAccounts
{
    UIView        *_View1;
    UILabel       *_lblAccount;
    UIView        *_View2;
    UIView        *_View3;
    UIColor       *color;
    UIButton      *_btnMenu;
    UIButton      *_btnShop;
    UILabel       *_labelMID1;
    UILabel       *_labelMID2;
    UILabel       *_lblEmailId1;
    UILabel       *_lblEmailId2;
    UIImageView   *ImageView;
    UIImageView   *_imageHolder1;
    UIImage       *_AccountImage;
    UILabel       *lSeperaotr;
    UIImage       *_ImagePicker;
    UIImageView   *_IMGView;
    UIImageView   *tableBGimg;
    BOOL          openSection;
    NSArray       *totalItemArray;
    UITextField   *textfield1;
    UITextField   *textfield2;
    UITextField   *textfield3;
    NSString      *newString;
    NSString      *CoinsString;
    UIButton      *_btnPicker;
    UIImage       *btnImage;
    UIImageView   *logoView;
    BOOL          issuccessful;
    NSString      *giftedCoins;
    int           UserTotalCoins;
    HistoryGetCredits *_GetCredits;
}


@synthesize type;




- (id)init
{
    self = [super init];
    if (self)
    {
        
        _ObjMewardServerModel=[[MegoHistoryServerModel alloc]init];
        _ObjMewardServerModel._delegate=self;
        _ObjMewardServerModel.AppDataSavedKey=@"MeWardData";
        _ObjMewardServerModel.MewardCoinblanaceKey=@"RemainingKey";
         NSLog(@"SELF DONE");

    }
    return self;
}



- (void)viewDidLoad
{
    
    
    NSLog(@"VIEW DIDLOAD");
    _ObjMewardServerModel._delegate=self;
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    totalItemArray=[[NSArray alloc]init];
    [self AccountUI];
    
   
    NSString *str=[_ObjMewardServerModel GetRemainingCoinBalance];
    
    NSLog(@"STRING=%@",str);
    
    dispatch_async(dispatch_get_main_queue(),^
                   {
                       [SDKHistoryManager startProgressBar:self.view :@"Please Wait..."];
                   });

   
    [self topStrip:str];
   [self AuthenticationServiceSuccessHandller];
  
}




-(void)NotifyInstallRefferalToMigserver
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
    NSString *str=[_ObjMewardServerModel GetRemainingCoinBalance];
    UserTotalCoins=[str intValue];
    [self topStrip:str];
    
}

-(void)CoinUpdated:(NSDictionary*)Response
{
    NSString *str=[_ObjMewardServerModel GetRemainingCoinBalance];
    [self topStrip:str];
}

-(void) ConfigHandller:(NSDictionary*)ResponseDictionary
{
    NSString *str=@"Enter Credits minimum  ";
    _ObjMewardServerModel.MinGiftValue=@"50 credits";
    textfield2.placeholder =str;
}

-(void)AuthenticationServiceSuccessHandller
{
    
    
    _ObjMewardServerModel.MinGiftValue=@"50 credits";
   
    
    NSDictionary *Mewardid=[[NSUserDefaults standardUserDefaults] objectForKey:_ObjMewardServerModel.AppDataSavedKey];
    
    NSLog(@"Mewardid=%@",Mewardid);
    NSString *id=[Mewardid objectForKey:@"mewardid"];
    NSLog(@"id=%@",id);
    
        dispatch_async(dispatch_get_main_queue(),^
                   {
                       [SDKHistoryManager stopProgressBar ];
                       [_labelMID1 setText:[NSString stringWithFormat:@"Mewards ID: %@",id]];
                   });
}

-(void)ServiceSuccessHandller:(NSData*)data
{
    dispatch_async(dispatch_get_main_queue(),^
                   {
                      [SDKHistoryManager stopProgressBar ];
                   });
}

-(void)ServieFailedHandller:(NSString*)ErrorDescription
{
   [SDKHistoryManager stopProgressBar];
}

-(void)topStrip:(NSString*)giftvalue;
{
    NSLog(@"Height of device= %f",[UIScreen mainScreen].bounds.size.height);
    UIView *topStpLbl=[[UIView alloc]initWithFrame:CGRectMake(0, 19, self.view.frame.size.width, 45)];
    topStpLbl.backgroundColor=[UIColor colorWithRed:17/255.f green:134/255.f  blue:194/255.f alpha:1];
    [self.view addSubview:topStpLbl];
    
    UIButton *upperbtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 210, topStpLbl.frame.size.height)];
    [upperbtn setBackgroundColor:[UIColor clearColor]];
    [topStpLbl addSubview:upperbtn];
    [upperbtn addTarget:self action:@selector(showAndHideMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    logoView =[[UIImageView alloc]initWithFrame:CGRectMake(0,(upperbtn.frame.size.height-20)/2,25, 25)];
    logoView.contentMode = UIViewContentModeScaleAspectFit;
    [upperbtn addSubview:logoView];
    UIImageView *logoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(logoView.frame.origin.x+logoView.frame.size.width, (upperbtn.frame.size.height-19)/2, 20, 19)];
    
     UIImage *Account=[MegoHistoryServerModel getImageFromBundle:@"AccountNew"];
     [logoImgView setImage:Account];

    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0,3,40,40)];
    [back setImage:[MegoHistoryServerModel getImageFromBundle:@"goBack_un"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(BackBtnClick) forControlEvents:UIControlEventTouchUpInside];
      back.titleLabel.font=[UIFont fontWithName:@"Arial" size:15];
    back.showsTouchWhenHighlighted=YES;
    [topStpLbl addSubview:back];
    
    UILabel *l1=[[UILabel alloc]initWithFrame:CGRectMake(logoImgView.frame.origin.x+logoImgView.frame.size.width, (upperbtn.frame.size.height-30)/2, 150, 30)];
    [l1 setBackgroundColor:[UIColor clearColor]];
    l1.text=  @"Account";
    l1.font=[UIFont fontWithName:@"Helvetica" size:20];
    l1.textColor=[UIColor whiteColor];
    [upperbtn addSubview:l1];
    
    UIButton *downloadbtn =[[UIButton alloc]initWithFrame:CGRectMake(topStpLbl.frame.size.width-145, (topStpLbl.frame.size.height-25)/2, 54, 30)];
    [downloadbtn setBackgroundColor:[UIColor clearColor]];
    
    
    [downloadbtn setImage:[MegoHistoryServerModel getImageFromBundle:@"Button_BG"] forState:UIControlStateNormal];
    [downloadbtn setImage:[MegoHistoryServerModel getImageFromBundle:@"Button_BG"] forState:UIControlStateHighlighted];
    [topStpLbl addSubview:downloadbtn];
    
    UIImageView *Shop_Icon = [[UIImageView alloc]initWithFrame:CGRectMake(3,(downloadbtn.frame.size.height-18)/2,18,18)];
    [Shop_Icon setImage:[MegoHistoryServerModel getImageFromBundle:@"Shop_Icon"]];
    [downloadbtn addSubview:Shop_Icon];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    [downloadbtn addGestureRecognizer:tapGestureRecognizer];
    
    UILabel *Shoplbl=[[UILabel alloc]initWithFrame:CGRectMake(Shop_Icon.frame.origin.x+Shop_Icon.frame.size.width+2, (downloadbtn.frame.size.height-25)/2, 100, 25)];
    [Shoplbl setBackgroundColor:[UIColor clearColor]];
    Shoplbl.text=  @"Shop";
    Shoplbl.font=[UIFont fontWithName:@"Helvetica" size:12];
    Shoplbl.textColor=[UIColor whiteColor];
    [downloadbtn addSubview:Shoplbl];
    
    UILabel *linelbl=[[UILabel alloc]initWithFrame:CGRectMake(downloadbtn.frame.origin.x+downloadbtn.frame.size.width+10, (topStpLbl.frame.size.height-20)/2+2, 1, 20)];
    [linelbl setBackgroundColor:[UIColor whiteColor]];
    [topStpLbl addSubview:linelbl];
    
    UIButton *giftboxbtn =[[UIButton alloc]initWithFrame:CGRectMake(linelbl.frame.origin.x+linelbl.frame.size.width-5, (topStpLbl.frame.size.height-34)/2-1, 40, 40)];
    [giftboxbtn setBackgroundColor:[UIColor clearColor]];
    [giftboxbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];

    [giftboxbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [giftboxbtn setImage:[MegoHistoryServerModel getImageFromBundle:@"Credits_Icon"] forState:UIControlStateNormal];
    [giftboxbtn setImage:[MegoHistoryServerModel getImageFromBundle:@"Credits_Icon"] forState:UIControlStateHighlighted];
    [topStpLbl addSubview:giftboxbtn];
    
    UILabel *giftlable=[[UILabel alloc]initWithFrame:CGRectMake(giftboxbtn.frame.origin.x+35,  (topStpLbl.frame.size.height-34)/2-1, 60, 40)];
    giftlable.textColor=[UIColor whiteColor];
    [topStpLbl addSubview:giftlable];
    giftlable.text=giftvalue;
    
}

- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer
{
    
    _GetCredits=[[HistoryGetCredits alloc]init];
    [self.navigationController pushViewController:_GetCredits animated:YES];
}


- (void) GiftBox: (id)sender
{
    NSLog(@"cerdits");
}

-(void)AccountUI
{
    _View2=[[UIView alloc]initWithFrame:CGRectMake(0,64,self.view.frame.size.width,170)];
    if(SDKHistoryManager.deviceHeight==1024)
    {
        _View2=[[UIView alloc]initWithFrame:CGRectMake(0,64,self.view.frame.size.width,170*2.14)];
        
    }
    color=[UIColor colorWithRed:192.0/255.0f green:192.0/255.0f blue:192.0/255.0f alpha:2];
    _View2.backgroundColor=color;
    
    btnImage = [MegoHistoryServerModel getImageFromBundle:@"Profile_Icon"];
    _btnPicker=[[UIButton alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,170)];
    if(SDKHistoryManager.deviceHeight==1024)
    {
        _btnPicker=[[UIButton alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,170*2.14)];
        
    }
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    NSData* FBimageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveFbImage"];
    UIImage* FBimage = [UIImage imageWithData:FBimageData];
    
    if (image==nil && FBimage==nil)
    {
        
        [_btnPicker setImage:btnImage forState:UIControlStateNormal];
        
    }
    else if (image==nil && FBimage!=nil)
    {
        [_btnPicker setImage:FBimage forState:UIControlStateNormal];
    }
    else
    {
        [_btnPicker setImage:image forState:UIControlStateNormal];
    }
    
    [_btnPicker addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [_View2 addSubview:_btnPicker];
    
    
    _View3=[[UIView alloc]initWithFrame:CGRectMake(0, _View2.frame.origin.y+_View2.frame.size.height,self.view.frame.size.width,self.view.frame.size.height-_View2.frame.size.height)];
    _View3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    
    if(SDKHistoryManager.deviceHeight==1024)
    {
        _labelMID1=[[UILabel alloc]initWithFrame:CGRectMake(20,20, 380, 30)];
        _labelMID1.font = [UIFont boldSystemFontOfSize:20.0];
    }
    else
    {
        _labelMID1=[[UILabel alloc]initWithFrame:CGRectMake(20,5, 290, 30)];
        _labelMID1.font = [UIFont boldSystemFontOfSize:15.0];
    }
    [_labelMID1 setText:@"Mewards ID :"];

    color=[UIColor colorWithRed:76.0/255.0f green:76.0/255.0f blue:76.0/255.0f alpha:1];
    _labelMID1.textColor=color;
    _labelMID1.textAlignment=NSTextAlignmentLeft;
    
    
    NSString *mewardid = [[NSUserDefaults standardUserDefaults]valueForKey:@"MewardID"];
    _labelMID2=[[UILabel alloc]initWithFrame:CGRectMake(_labelMID1.frame.origin.x+_labelMID1.frame.size.width+10, 5, 200,30)];
    [_labelMID2 setText:mewardid];
    _labelMID2.font = [UIFont boldSystemFontOfSize:16.0];
    color=[UIColor colorWithRed:76.0/255.0f green:76.0/255.0f blue:76.0/255.0f alpha:1];
    _labelMID2.textColor=color;
    _labelMID2.textAlignment=NSTextAlignmentLeft;
    
    if(SDKHistoryManager.deviceHeight==1024)
    {
        ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,_labelMID1.frame.origin.y+_labelMID1.frame.size.height+20, self.view.frame.size.width,   1.5f)];
    }
    else
    {
        ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,_labelMID1.frame.size.height+10, self.view.frame.size.width,   1.5f)];
    }
    ImageView.backgroundColor=[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    
    
    if(SDKHistoryManager.deviceHeight==1024)
    {
        _lblEmailId1=[[UILabel alloc]initWithFrame:CGRectMake(20,ImageView.frame.origin.y+ImageView.frame.size.height+20,100,30)];
        _lblEmailId1.font = [UIFont boldSystemFontOfSize:20.0];
    }
    else
    {
        _lblEmailId1=[[UILabel alloc]initWithFrame:CGRectMake(20,52,70,30)];
        _lblEmailId1.font = [UIFont boldSystemFontOfSize:15.0];
    }
      [_lblEmailId1 setText:@"Email ID :"];
      color=[UIColor colorWithRed:76.0/255.0f green:76.0/255.0f blue:76.0/255.0f alpha:1];
    _lblEmailId1.textColor=color;
    _lblEmailId1.textAlignment=NSTextAlignmentLeft;
    
    
    NSString *email = [[NSUserDefaults standardUserDefaults]valueForKey:@"EmailId"];
    
    
    if(SDKHistoryManager.deviceHeight==1024)
    {
        _lblEmailId2=[[UILabel alloc]initWithFrame:CGRectMake(_lblEmailId1.frame.origin.x+_lblEmailId1.frame.size.width+5,_lblEmailId1.frame.origin.y,240,30)];
        _lblEmailId2.font = [UIFont boldSystemFontOfSize:20];}
    else
    {
        _lblEmailId2=[[UILabel alloc]initWithFrame:CGRectMake(_lblEmailId1.frame.origin.x+_lblEmailId1.frame.size.width+5,_lblEmailId1.frame.origin.y,240,30)];
        _lblEmailId2.font = [UIFont boldSystemFontOfSize:15];
        
    }
    [_lblEmailId2 setText:email];
    [_lblEmailId2 setText:@"ankityadav**@gmail.com"];
    color=[UIColor colorWithRed:76.0/255.0f green:76.0/255.0f blue:76.0/255.0f alpha:1];
    _lblEmailId2.textColor=color;
    _lblEmailId2.textAlignment=NSTextAlignmentLeft;
    
    if(SDKHistoryManager.deviceHeight==1024)
    {
        lSeperaotr=[[UILabel alloc]initWithFrame:CGRectMake(0, _lblEmailId1.frame.origin.y+_lblEmailId1.frame.size.height+30, self.view.frame.size.width, 1.5)];
    }
    else
        
    {
        lSeperaotr=[[UILabel alloc]initWithFrame:CGRectMake(0, _lblEmailId1.frame.origin.y+_lblEmailId1.frame.size.height+3, self.view.frame.size.width, 1.5)];
    }
    [_View3 addSubview:lSeperaotr];
    [lSeperaotr setBackgroundColor:[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1]];
    
    
    UIButton *creditButton=[[UIButton alloc]initWithFrame:CGRectMake(0, lSeperaotr.frame.origin.y+lSeperaotr.frame.size.height+2, self.view.frame.size.width, 45)];
    [creditButton addTarget:self action:@selector(tab:) forControlEvents:UIControlEventTouchUpInside];
     [_View3 addSubview:creditButton];

       creditButton.tag=1;
    
    UIImageView *view1=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, lSeperaotr.frame.origin.y+lSeperaotr.frame.size.height+20,10, 10)];
    view1.image=[MegoHistoryServerModel getImageFromBundle:@"errow"];
    [_View3 addSubview:view1];

    
    
    UILabel *creditlable=[[UILabel alloc]initWithFrame:CGRectMake(17,0, 100, 230)];
    creditlable.text=@"Gift Credits ";
    creditlable.textAlignment=NSTextAlignmentLeft;
    color=[UIColor colorWithRed:76.0/255.0f green:76.0/255.0f blue:76.0/255.0f alpha:1];
    creditlable.textColor=color;
    
    
    [creditlable setFont:[UIFont boldSystemFontOfSize:16.0]];
    [_View3 addSubview:creditlable];
    
    
    if(SDKHistoryManager.deviceHeight==1024)
    {
        lSeperaotr=[[UILabel alloc]initWithFrame:CGRectMake(0, creditButton.frame.origin.y+creditButton.frame.size.height+30, self.view.frame.size.width, 1.5)];
    }
    else
        
    {
        lSeperaotr=[[UILabel alloc]initWithFrame:CGRectMake(0, creditButton.frame.origin.y+creditButton.frame.size.height+3, self.view.frame.size.width, 1.5)];
    }
    [_View3 addSubview:lSeperaotr];
    [lSeperaotr setBackgroundColor:[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1]];
    
    
    
    UIButton *reciveCredit=[[UIButton alloc]initWithFrame:CGRectMake(0, lSeperaotr.frame.origin.y+lSeperaotr.frame.size.height+2, self.view.frame.size.width, 45)];
     [reciveCredit addTarget:self action:@selector(tab:) forControlEvents:UIControlEventTouchUpInside];
     reciveCredit.tag=2;
    [_View3 addSubview:reciveCredit];

    
    
    
    UIImageView *view2=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, lSeperaotr.frame.origin.y+lSeperaotr.frame.size.height+20,10, 10)];
    view2.image=[MegoHistoryServerModel getImageFromBundle:@"errow"];
    [_View3 addSubview:view2];
    
    UILabel *recivelable=[[UILabel alloc]initWithFrame:CGRectMake(17,50, 140, 230)];
    recivelable.text=@"Recieve Credits ";
    recivelable.textAlignment=NSTextAlignmentLeft;
    color=[UIColor colorWithRed:76.0/255.0f green:76.0/255.0f blue:76.0/255.0f alpha:1];
    recivelable.textColor=color;
    [recivelable setFont:[UIFont boldSystemFontOfSize:16.0]];
    [_View3 addSubview:recivelable];
    
    
    if(SDKHistoryManager.deviceHeight==1024)
    {
        lSeperaotr=[[UILabel alloc]initWithFrame:CGRectMake(0, reciveCredit.frame.origin.y+reciveCredit.frame.size.height+30, self.view.frame.size.width, 1.5)];
    }
    else
        
    {
        lSeperaotr=[[UILabel alloc]initWithFrame:CGRectMake(0, reciveCredit.frame.origin.y+reciveCredit.frame.size.height+3, self.view.frame.size.width, 1.5)];
    }
    [_View3 addSubview:lSeperaotr];
    [lSeperaotr setBackgroundColor:[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1]];
    
    
    UIButton *history=[[UIButton alloc]initWithFrame:CGRectMake(0, lSeperaotr.frame.origin.y+lSeperaotr.frame.size.height+2, self.view.frame.size.width, 45)];
    
    [_View3 addSubview:history];
    [history addTarget:self action:@selector(tab:) forControlEvents:UIControlEventTouchUpInside];
    history.tag=3;
    
    
    UIImageView *view3=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, lSeperaotr.frame.origin.y+lSeperaotr.frame.size.height+20,10, 10)];
    view3.image=[MegoHistoryServerModel getImageFromBundle:@"errow"];
    [_View3 addSubview:view3];
    
    UILabel *historylable=[[UILabel alloc]initWithFrame:CGRectMake(17,100, 140, 230)];
    historylable.text=@"History ";
    historylable.textAlignment=NSTextAlignmentLeft;
    color=[UIColor colorWithRed:76.0/255.0f green:76.0/255.0f blue:76.0/255.0f alpha:1];
    historylable.textColor=color;
    [historylable setFont:[UIFont boldSystemFontOfSize:16.0]];
    [_View3 addSubview:historylable];
    
    
    if(SDKHistoryManager.deviceHeight==1024)
    {
        lSeperaotr=[[UILabel alloc]initWithFrame:CGRectMake(0, history.frame.origin.y+history.frame.size.height+30, self.view.frame.size.width, 1.5)];
    }
    else
        
    {
        lSeperaotr=[[UILabel alloc]initWithFrame:CGRectMake(0, history.frame.origin.y+history.frame.size.height+3, self.view.frame.size.width, 1.5)];
    }
    [_View3 addSubview:lSeperaotr];
    [lSeperaotr setBackgroundColor:[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1]];

    
    [self.view addSubview:_View2];
    [self.view addSubview:_View3];
    [_View3 addSubview:_labelMID1];
    [_View3 addSubview:_labelMID2];
    [_View3 addSubview:_lblEmailId1];
    [_View3 addSubview:_lblEmailId2];
    [_View3 addSubview:ImageView];
}


- (IBAction)selectPhoto:(UIButton *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(selectedImage) forKey:@"saveImage"];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    
    NSData* FBimageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveFbImage"];
    UIImage* FBimage = [UIImage imageWithData:FBimageData];
    
    if (image==nil && FBimage==nil)
    {
        [_btnPicker setImage:btnImage forState:UIControlStateNormal];
    }
    else if (image==nil && FBimage!=nil)
    {
        [_btnPicker setImage:FBimage forState:UIControlStateNormal];
    }
    else
    {
        [_btnPicker setImage:image forState:UIControlStateNormal];
        
    }
    
    [picker dismissViewControllerAnimated:NO completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:NO completion:NULL];
    
}



//-(void)tab:(UIButton*)sender
//{
//    if(sender.tag==1)
//    {
//       MewardGiftCredit *ObjHistory=[[MewardGiftCredit alloc]init];
//        [self.navigationController pushViewController:ObjHistory animated:YES];
//    }
//    
//    
//    else if(sender.tag==2)
//    {
//        
//        
//       
//        
//        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:@"Redeem Credits"];
//
//       [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor  colorWithRed:76/255.f green:132/255.f blue:249/255.f alpha:1] range:NSMakeRange(13,0)];
//        
//        [attributedStr addAttribute:NSFontAttributeName
//                      value:[UIFont systemFontOfSize:50.0]
//                      range:NSMakeRange(0, 13)];
//        
//        
//        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Redeem Credits"
//                                                          message:@"Enter the promo code received on your Email ID to redeem credits"
//                                                         delegate:self
//                                                cancelButtonTitle:@"Cancel"
//                                                otherButtonTitles:@"Confirm", nil];
//     
//        message.alertViewStyle = UIAlertViewStylePlainTextInput;
//        alertTextField1 = [message textFieldAtIndex:0];
//        message.tag=101;
//        alertTextField1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//        alertTextField1.placeholder = @"Enter Promo Code";
//        [[message textFieldAtIndex:0] setSecureTextEntry:NO];
//        [message show];
//    }
//   else if(sender.tag==3)
//    {
//        MewardHistoryclass *ObjHistory=[[MewardHistoryclass alloc]init];
//        [self.navigationController pushViewController:ObjHistory animated:YES];
//       
//    }
//}
//

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        [alertView removeFromSuperview];
    }
    
    if(buttonIndex == [alertView firstOtherButtonIndex])
    {
    
       if(alertView.tag==101)
    {
       [self RecieveCreaditsConfirmCall];
    }
        
    else
    {
         [alertView removeFromSuperview];
    }
    }
}




-(void)SendgiftHandler:(NSDictionary*)Response
{
    [SDKHistoryManager stopProgressBar];
    UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"Message!" message:[Response objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [Alert show];
    NSString *str=[_ObjMewardServerModel GetRemainingCoinBalance];
    [self topStrip:str];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"CoinsString"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EmailId/MewardId"];
}


-(void)RecieveCreaditsConfirmCall
{
    
    NSLog(@"ConfirmCall");
    
     NSString *string = alertTextField1.text;
    [[NSUserDefaults standardUserDefaults]setValue:string forKey:@"PromoCode"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *PromoCode = [[NSUserDefaults standardUserDefaults]valueForKey:@"PromoCode"];
    if(PromoCode.length<=0)
    {
        [SDKHistoryManager ShowCommonAlert:@"Invalid Entry!" MsgBody:@"Sorry..! Enter promo code"];
        return;
    }
    
    [_ObjMewardServerModel ReceiveGift:PromoCode];
    [SDKHistoryManager startProgressBar:self.view :@"Please Wait..."];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"PromoCode"];
    
}

-(void)RecivegiftHandler:(NSDictionary*)Response
{
    /* authentication = true;
     coins = 0;
     msg = "Sorry..! The promo code you enter is already used by someone.";
     */
    
  
    NSString *RemCoinstr=[_ObjMewardServerModel GetRemainingCoinBalance];
    NSString *Coins=[Response objectForKey:@"coins"];
    int redeemcoins=[Coins intValue]-[RemCoinstr intValue];
    NSString *coins1=[NSString stringWithFormat:@"%d", redeemcoins];
    NSString *msg=[Response objectForKey:@"msg"];
    Coins=[NSString stringWithFormat:@"%@ Gift Received!",coins1];
    
    UIAlertView *Alert1=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [Alert1 show];
    
    if([Coins intValue]>0)
    {
        NSString *RemCoinstr=[_ObjMewardServerModel GetRemainingCoinBalance];
        NSString  *StrTotalCoinsAfterRecivinggift=[NSString stringWithFormat:@"%d",([RemCoinstr intValue]+[Coins intValue])];
        [self topStrip:StrTotalCoinsAfterRecivinggift];
        [_ObjMewardServerModel SaveRemainingCoin:StrTotalCoinsAfterRecivinggift];
        
    }
    
    [SDKHistoryManager stopProgressBar];
}



-(BOOL)emailValidate:(NSString *)emailAdd
{
    return YES;
}

-(void)showAndHideMenu:(UIButton*)sender
{
    
}

-(void)BackBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end





//
//  HistorySegmentedHeader.m
//
//  Created by David-iphone on 3/30/15.
//

#import "HistorySegmentedHeader.h"




extern NSString *HeaderColorCode;
@implementation HistorySegmentedHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)DrawSegemntedControl:(NSMutableArray*)RequestParam :(NSMutableArray*)HeaderTab :(NSMutableArray*)ArrVersion :(int)ThemeType
{
   // dict=ArrayCategory;
//     dict=[[NSMutableArray alloc]init];
//    [dict addObject:@"TOP"];
//    [dict addObject:@"NEW"];
//    [dict addObject:@"FREE"];
//    [dict addObject:@"PAID"];
//    [dict addObject:@"TOP" ];
//    [dict addObject:@"NEW" ];
//    [dict addObject:@"FREE" ];
//    [dict addObject:@"PAID"];
    
    dict=HeaderTab;
    RequestParamArray=RequestParam;
    VersionArray=ArrVersion;
    NSArray *dictKey = [dict mutableCopy];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    _scrollView.userInteractionEnabled=YES;
    
           [_scrollView setBackgroundColor:[UIColor colorWithRed:197/255.f green:197/255.f blue:197/255.f alpha:1]];
   

    //[_scrollView setBackgroundColor:[UIColor whiteColor]];
    [_scrollView setContentSize:CGSizeMake(self.frame.size.width, 50)];
    [self addSubview:_scrollView];
    UISegmentedControl *mySegmentedControl = [[UISegmentedControl alloc]init];
    [mySegmentedControl addTarget:self action:@selector(didChangeSegmentControl:) forControlEvents:UIControlEventValueChanged];
    CGFloat segmntCntrl_Width = ([dictKey count]-1)*100 ;
    NSMutableArray *mutableAry = [[NSMutableArray alloc]init];

    for(int i=0; i<[dictKey count]; i++)
    {
        {
            [mySegmentedControl insertSegmentWithTitle:[dictKey objectAtIndex:i] atIndex:i animated:NO];
            [mutableAry addObject:[dictKey objectAtIndex:i]];
        }
    }
    
    //[top setTopBtn:mutableAry];
    mySegmentedControl.selectedSegmentIndex = 0;
    [_scrollView addSubview:mySegmentedControl];
    if((segmntCntrl_Width+10) < self.frame.size.width)
    {segmntCntrl_Width = self.frame.size.width;}
    [_scrollView setContentSize:CGSizeMake(segmntCntrl_Width+10, 30)];
    //Header.backgroundColor= [ConvertColor colorWithHexString:headerStripColor];
    
    
    CGFloat segmntCntrl_Xpos = (_scrollView.contentSize.width/2)-(segmntCntrl_Width/2);
    [mySegmentedControl setFrame:CGRectMake(segmntCntrl_Xpos, 5, segmntCntrl_Width-10, 30)];
}


- (void)didChangeSegmentControl:(UISegmentedControl *)control
{
    NSString *selectSegmnt = [control titleForSegmentAtIndex:control.selectedSegmentIndex];
    NSLog(@"You Select Tab : %@",selectSegmnt);
    if (control.selectedSegmentIndex == 0)
    {
        
        
        
    }
    [ _ProductTypeDelegate ProductTypeClick:[RequestParamArray objectAtIndex:control.selectedSegmentIndex]  Version:[VersionArray objectAtIndex:control.selectedSegmentIndex] ];
    // [myTableView reloadData];
}

@end

//
//  UI_ProtoTypePage_TC.m
//  ProtoTypeApp
//
//  Created by TacktileSystemsMac4 on 12/01/16.
//  Copyright (c) 2016 Tacktile Systems. All rights reserved.
//

#import "UI_ProtoTypePage_TC.h"
#define TABLE_WIDTH self.tableView.bounds.size.width
#define TABLE_HEIGHT self.tableView.bounds.size.height
#define VIEW_WIDTH tUIViewSection.bounds.size.width
#define VIEW_HEIGHT tUIViewSection.bounds.size.height

@interface UI_ProtoTypePage_TC ()
{
    UIView* tUIViewSection;
    NSDictionary* tDictOfJSON;
    UISegmentedControl* tSegmentedButtons;
    UIButton* tBtnOfRatingStar1;
    UIButton* tBtnOfRatingStar2;
    UIButton* tBtnOfRatingStar3;
    UIButton* tBtnOfRatingStar4;
    UIButton* tBtnOfRatingStar5;
    
    
}
@end

@implementation UI_ProtoTypePage_TC

#pragma mark - VIEW DELEGATES
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self tInitData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - INIT DATA
-(void)tInitData
{
    //ARRAY OF OPTIONS
    NSArray* tArrayOfOptions1 = [[NSArray alloc]initWithObjects:@"Good",@"Bad", nil];
    NSArray* tArrayOfOptions2 = [[NSArray alloc]initWithObjects:@"Low",@"High", nil];
    NSArray* tArrayOfOptions3 = [[NSArray alloc]initWithObjects:@"Online",@"Drive by",@"Referral", nil];
    NSArray* tArrayOfOptions4 = [[NSArray alloc]initWithObjects:@"3", nil];
    
    //ARRAY OF DATA INFORMATION
    // TYPE = 1 >>> SEGMENT CONTROLLER BUTTONS
    // TYPE = 2 >>> SLIDER
    // TYPE = 3 >>> RATINGS

    NSDictionary* tDictOfQue1 = @{@"question":@"1. Location easy to find?",@"type":@"1",@"options":tArrayOfOptions1};
    
    NSDictionary* tDictOfQue2 = @{@"question":@"2. Price",@"type":@"2",@"options":tArrayOfOptions2};
    
    NSDictionary* tDictOfQue3 = @{@"question":@"3. How did you find us?",@"type":@"1",@"options":tArrayOfOptions3};
    
    NSDictionary* tDictOfQue4 = @{@"question":@"4. Rate the house!",@"type":@"3",@"options":tArrayOfOptions4};
    
    
    //ARRAY OF DICTION
    NSArray* tArrayOfDictionary = [[NSArray alloc]initWithObjects:tDictOfQue1,tDictOfQue2,tDictOfQue3,tDictOfQue4, nil];
    
    //JSON DICTIONARY
    tDictOfJSON = @{@"data":tArrayOfDictionary};
    
    NSLog(@"DictOfJSON = %@",tDictOfJSON);
    
    //THIS TYPE OF JSON EXPECT FROM SERVER
    /*
     DictOfJSON = {
     data =     (
     {
     options =(
     Good,
     Bad
     );
     question = "1. Location easy to find?";
     type = 1;
     },
     {
     options =(
     Low,
     High
     );
     question = "2. Price";
     type = 2;
     },
     {
     options =(
     Online,
     "Drive by",
     Referral
     );
     question = "3. How did you find us?";
     type = 1;
     },
     {
     options =
     (3);
     question = "4. Rate the house!";
     type = 3;
     }
     );
     */

}

#pragma mark - TABLE VIEW DELEGATES

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return [[tDictOfJSON valueForKey:@"data"] count] + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 150;
    }
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    tUIViewSection=[[UIView alloc]initWithFrame:CGRectMake(0, 0, TABLE_WIDTH, 100)];
    
    
    if(section == 0)
    {
        UILabel* tTitleLabel;
        tTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, TABLE_WIDTH, 40)];
        tTitleLabel.textColor = [UIColor grayColor];
        tTitleLabel.text = @"Your input means a lot, take this 5 seconds survey..";
        tTitleLabel.textAlignment = NSTextAlignmentCenter;
        tTitleLabel.font = [UIFont systemFontOfSize:22.0f];
        tTitleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        
        
        [tUIViewSection addSubview:tTitleLabel];
    }
    else if(section > 0 && section < [[tDictOfJSON valueForKey:@"data"] count] + 1)
    {
        [self tViewForSection:(int)section];
    }
    else
    {
        UIButton* tBtnOfSubmit = [[UIButton alloc]initWithFrame:CGRectMake((TABLE_WIDTH / 2) - 100 , 10, 200, 44)];
        [tBtnOfSubmit setTitle:@"Submit" forState:UIControlStateNormal];
        tBtnOfSubmit.backgroundColor = [UIColor lightGrayColor];
        tBtnOfSubmit.layer.cornerRadius = 5.5f;
        tBtnOfSubmit.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        [tBtnOfSubmit addTarget:self action:@selector(tBtnActionOfSubmit) forControlEvents:UIControlEventTouchUpInside];
        [tUIViewSection addSubview:tBtnOfSubmit];
    }
    
    
    
    
    
    return tUIViewSection;
}


#pragma mark - LOGICAL METHODS
//VIEW FOR SECTION
-(void)tViewForSection : (int) tSection
{
    UIView* lUIViewMain = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    UILabel* tQuestionLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 0, tUIViewSection.bounds.size.width/2 - 140, 40)];
    tQuestionLabel.text = [[[tDictOfJSON valueForKey:@"data"] valueForKey:@"question"] objectAtIndex:tSection - 1];
    tQuestionLabel.textColor = [UIColor blackColor];
    tQuestionLabel.font = [UIFont systemFontOfSize:26.0f];
    tQuestionLabel.font = [UIFont boldSystemFontOfSize:26.0f];
    [tQuestionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [tQuestionLabel setNumberOfLines:0];
    
    [lUIViewMain addSubview:tQuestionLabel];
    
    int tType = [[[[tDictOfJSON valueForKey:@"data"] valueForKey:@"type"] objectAtIndex:tSection - 1] intValue];
    switch (tType)
    {
        case 1:
            
            [lUIViewMain addSubview:[self tViewForSegmentControllerButtons : [[[tDictOfJSON valueForKey:@"data"] valueForKey:@"options"] objectAtIndex:tSection - 1] :tSection]];

            
            break;
            
        case 2:
 

            [lUIViewMain addSubview:[self tViewForSlider]];
            
            break;
            
        case 3:
            
            [lUIViewMain addSubview:[self tViewForRatings :[[[tDictOfJSON valueForKey:@"data"] valueForKey:@"options"] objectAtIndex:tSection - 1]]];
            break;
            
        case 4:
            
            [lUIViewMain addSubview:[self tViewForSegmentControllerButtons:[[[tDictOfJSON valueForKey:@"data"] valueForKey:@"options"] objectAtIndex:tSection - 1] :tSection]];
            
            break;
            
        default:
            
            break;
    }

    [tUIViewSection addSubview:lUIViewMain];
    
}

//SLIDER
-(UIView*)tViewForSlider
{
     UIView* tSliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    CGRect frame = CGRectMake((VIEW_WIDTH/2)+ 40, 5.0, 250.0, 10.0);
    UISlider *slider = [[UISlider alloc] initWithFrame:frame];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = 0.0;
    slider.maximumValue = 50.0;
    slider.continuous = YES;
    slider.value = 25.0;
    [tSliderView addSubview:slider];
    
    
    return tSliderView;
}

//SEGMENT CRONTROLLERS
-(UIView*)tViewForSegmentControllerButtons :(NSArray*) tArrayOfOptions :(int)tSection
{
    
    
    UIView* tSegmentChangeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
//    NSArray* tArrayOfOptions = [[NSArray alloc]initWithObjects:@"YES",@"NO",@"MALE",@"FEMALE", nil];
    
    tSegmentedButtons = [[UISegmentedControl alloc] initWithItems:tArrayOfOptions];
    
    tSegmentedButtons.frame = CGRectMake((VIEW_WIDTH/2)+ 40, 0, (VIEW_WIDTH/2) - 100, 40);
    
    
    tSegmentedButtons.tag=tSection;
    
    tSegmentedButtons.selectedSegmentIndex = 0;
    
    [tSegmentedButtons addTarget:self action:@selector(SegmentChangeViewValueChanged:) forControlEvents:UIControlEventValueChanged];
    

    [tSegmentChangeView addSubview:tSegmentedButtons];
    
    return tSegmentChangeView;
}


//RATINGS
-(UIView*)tViewForRatings :(NSArray*) tArrayOfRating
{
    
    int tRating = [[tArrayOfRating objectAtIndex:0] intValue];
    
    UIView* tViewOfRatings = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    tBtnOfRatingStar1 = [[UIButton alloc]initWithFrame:CGRectMake((VIEW_WIDTH/2)+ 40,5,40,40)];
    tBtnOfRatingStar1.tag = 1;
    if(tRating > 0)
    {
        [tBtnOfRatingStar1 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    else
    {
        [tBtnOfRatingStar1 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
    }
    
    [tBtnOfRatingStar1 addTarget:self action:@selector(tYumScoreAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [tViewOfRatings addSubview:tBtnOfRatingStar1];
    
    tBtnOfRatingStar2 = [[UIButton alloc]initWithFrame:CGRectMake((VIEW_WIDTH/2)+ 90,5,40,40)];
    tBtnOfRatingStar2.tag = 2;
    if(tRating > 1)
    {
        [tBtnOfRatingStar2 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    else
    {
        [tBtnOfRatingStar2 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
    }
    [tBtnOfRatingStar2 addTarget:self action:@selector(tYumScoreAction:) forControlEvents:UIControlEventTouchUpInside];
    [tViewOfRatings addSubview:tBtnOfRatingStar2];
    
    tBtnOfRatingStar3 = [[UIButton alloc]initWithFrame:CGRectMake((VIEW_WIDTH/2)+ 140 ,5,40,40)];
    tBtnOfRatingStar3.tag = 3;
    if(tRating > 2)
    {
        [tBtnOfRatingStar3 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    else
    {
        [tBtnOfRatingStar3 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
    }
    [tBtnOfRatingStar3 addTarget:self action:@selector(tYumScoreAction:) forControlEvents:UIControlEventTouchUpInside];
    [tViewOfRatings addSubview:tBtnOfRatingStar3];
    
    tBtnOfRatingStar4 = [[UIButton alloc]initWithFrame:CGRectMake((VIEW_WIDTH/2 + 190), 5,40,40)];
    tBtnOfRatingStar4.tag = 4;
    if(tRating > 3)
    {
        [tBtnOfRatingStar4 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    else
    {
        [tBtnOfRatingStar4 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
    }
    [tBtnOfRatingStar4 addTarget:self action:@selector(tYumScoreAction:) forControlEvents:UIControlEventTouchUpInside];
    [tViewOfRatings addSubview:tBtnOfRatingStar4];
    
    tBtnOfRatingStar5 = [[UIButton alloc]initWithFrame:CGRectMake((VIEW_WIDTH/2)+ 240,5,40,40)];
    tBtnOfRatingStar5.tag = 5;
    if(tRating > 4)
    {
        [tBtnOfRatingStar5 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    else
    {
        [tBtnOfRatingStar5 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
    }
    [tBtnOfRatingStar5 addTarget:self action:@selector(tYumScoreAction:) forControlEvents:UIControlEventTouchUpInside];
    [tViewOfRatings addSubview:tBtnOfRatingStar5];
    
    
    return tViewOfRatings;
    
}




#pragma mark - ACTION
-(void)SegmentChangeViewValueChanged :(UISegmentedControl*) sender
{
    
    NSLog(@"Section = %d",sender.selectedSegmentIndex);

}

-(void)tYumScoreAction:(UIButton*)sender
{
    if (sender.tag==1) {

        if (sender.selected) {

         
            sender.selected=FALSE;
            tBtnOfRatingStar2.selected=FALSE;
            tBtnOfRatingStar3.selected=FALSE;
            tBtnOfRatingStar4.selected=FALSE;
            tBtnOfRatingStar5.selected=FALSE;
            [sender setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar2 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar3 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar4 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar5 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
            
            
        }else
        {

            sender.selected=TRUE;
            [sender setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        }
        
    }
    else if (sender.tag==2)
    {
        NSLog(@"STAR 2");
        if (sender.selected) {

            sender.selected=FALSE;
            tBtnOfRatingStar3.selected=FALSE;
            tBtnOfRatingStar4.selected=FALSE;
            tBtnOfRatingStar5.selected=FALSE;
            [sender setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar3 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar4 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar5 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
        }else
        {

            sender.selected=TRUE;
            tBtnOfRatingStar1.selected=TRUE;
            [sender setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar1 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        }
    }
    else if (sender.tag==3)
    {
        NSLog(@"STAR 3");
        if (sender.selected) {

            sender.selected=FALSE;
            tBtnOfRatingStar4.selected=FALSE;
            tBtnOfRatingStar5.selected=FALSE;
            [sender setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar4 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar5 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
            
            
        }else
        {
   
            sender.selected=TRUE;
            tBtnOfRatingStar1.selected=TRUE;
            tBtnOfRatingStar2.selected=TRUE;
            [sender setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar1 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar2 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        }
    } else if (sender.tag==4)
    {
        NSLog(@"STAR 4");
        if (sender.selected) {
   
            sender.selected=FALSE;
            tBtnOfRatingStar5.selected=FALSE;
            [sender setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar5 setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
            
            
        }else
        {

            sender.selected=TRUE;
            tBtnOfRatingStar1.selected=TRUE;
            tBtnOfRatingStar2.selected=TRUE;
            tBtnOfRatingStar3.selected=TRUE;
            [sender setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar1 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar2 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar3 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        }
    }
    else if (sender.tag==5)
    {
        NSLog(@"STAR 5");
        if (sender.selected) {
   
            sender.selected=FALSE;
            [sender setBackgroundImage:[UIImage imageNamed:@"grey_star"] forState:UIControlStateNormal];
        }else
        {
            
            sender.selected=TRUE;
            tBtnOfRatingStar1.selected=TRUE;
            tBtnOfRatingStar2.selected=TRUE;
            tBtnOfRatingStar3.selected=TRUE;
            tBtnOfRatingStar4.selected=TRUE;
            [sender setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar1 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar2 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar3 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
            [tBtnOfRatingStar4 setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        }
    }
    
}

-(void)sliderAction:(id)sender
{
//    UISlider *slider = (UISlider*)sender;
//    float value = slider.value;
}

-(void)tBtnActionOfSubmit
{
    //OUT PUT JSON
    /*{
        "questions":[
                     {
                         "id": 1,
                         "answer": "1", #choice which is to be selected
                         "type" : "" #Specified by server
     
                     },
                     {
                         "id": 2,
                         "answer": "4", #choice which is to be selected
                         "type" : "" #Specified by server
     
                     },
                     .
                     .
                     .
                     .
                     . n no of ques
                     ]
    }*/
    
}

@end

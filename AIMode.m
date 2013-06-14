//
//  AIMode.m
//  Connect Four
//
//  Created by Training on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AIMode.h"
#import <QuartzCore/QuartzCore.h>

@interface AIMode ()

@end

@implementation AIMode

@synthesize statusLabel;
@synthesize p1score;
@synthesize p2score;
@synthesize diff;
@synthesize imgDiff;
@synthesize imgWinner;
@synthesize timerLabel;
@synthesize timerLabelMin;
@synthesize timerLabelHr;
@synthesize pointsLabel;
@synthesize name;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recordHighScore:) name:@"record" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    turn = 1 ;
    countMoves = 0;
    gameOver = false;
    draw = false;
    p1wins=0;
    p2wins=0;
    difficulty = diff.intValue;
    points = 100;
    
    dataEasy = [[NSMutableArray alloc] init];
    [dataEasy addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"easy"]];
    dataNormal = [[NSMutableArray alloc] init];
    [dataNormal addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"normal"]];
    dataHard = [[NSMutableArray alloc] init];
    [dataHard addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"hard"]];

    NSSortDescriptor *sortAscnd = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES];
    [dataEasy sortUsingDescriptors:[NSMutableArray arrayWithObject:sortAscnd]];
    [dataNormal sortUsingDescriptors:[NSMutableArray arrayWithObject:sortAscnd]];
    [dataHard sortUsingDescriptors:[NSMutableArray arrayWithObject:sortAscnd]];

	///////////////////////New Btn
    UIButton *newBtn;
    newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [newBtn setBackgroundColor:[UIColor clearColor]];
    [newBtn addTarget:self action:@selector(newBtnClick) forControlEvents:UIControlEventTouchUpInside];
    newBtn.frame = CGRectMake(20, 13, 58, 40);
    newBtn.layer.cornerRadius = 5.0f;
    newBtn.layer.borderWidth = 0.5f;
    newBtn.layer.borderColor = [[UIColor clearColor] CGColor];
    
    UIImage *newImg = [UIImage imageNamed:@"new.png"];
    [newBtn setBackgroundImage:newImg forState:UIControlStateNormal];
    ////////////////////// 
    
    ///////////////////////Reset Btn
    UIButton *resetBtn;
    resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [resetBtn setBackgroundColor:[UIColor clearColor]];
    [resetBtn addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.frame = CGRectMake(242, 12, 58, 42);
    resetBtn.layer.cornerRadius = 5.0f;
    resetBtn.layer.borderWidth = 0.5f;
    resetBtn.layer.borderColor = [[UIColor clearColor] CGColor];
    
    UIImage *resetImg = [UIImage imageNamed:@"reset.png"];
    [resetBtn setBackgroundImage:resetImg forState:UIControlStateNormal];
    //////////////////////
    [self.view addSubview:newBtn];
    [self.view addSubview:resetBtn];
    
    
    if(difficulty == 1)
    {
        imgDiff.image = [UIImage imageNamed:@"easyai.png"];
    }
    else if(difficulty == 2)
    {
        imgDiff.image = [UIImage imageNamed:@"normai.png"];
    }
    else if(difficulty == 3)
    {
        imgDiff.image = [UIImage imageNamed:@"hardai.png"];
    }
    
    int tag=1;
    for(int r=0; r<6;r++) //sets the gameboard
    {
        for(int c=0; c<7; c++)
        {
            UIImageView *blackhole = (UIImageView*)[self.view viewWithTag:tag]; 
            
            holes[r][c] = blackhole;
            blackhole.image = [UIImage imageNamed:@"black.png"];
            tag++;
        }
    }
    
    UIButton *returnBtn;
    returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnBtn setBackgroundColor:[UIColor clearColor]];
    [returnBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    returnBtn.frame = CGRectMake(10, 420, 77, 30);
    returnBtn.layer.cornerRadius = 5.0f;
    returnBtn.layer.borderWidth = 0.5f;
    returnBtn.layer.borderColor = [[UIColor clearColor] CGColor];
    
    UIImage *retImg = [UIImage imageNamed:@"return.png"];
    [returnBtn setBackgroundImage:retImg forState:UIControlStateNormal];
    [self.view addSubview:returnBtn];

}

- (void)viewDidUnload
{
    [self setStatusLabel:nil];
    [self setP1score:nil];
    [self setP2score:nil];
    [self setImgDiff:nil];
    [self setImgWinner:nil];
    [self setTimerLabel:nil];
    [self setTimerLabelMin:nil];
    [self setTimerLabelHr:nil];
    [self setPointsLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)goBack
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)newBtnClick
{
    [gameTimer invalidate];
    [gameTimerMin invalidate];
    [gameTimerHr invalidate];
    
    timerLabelHr.text = @"00";
    timerLabelMin.text = @"00";
    timerLabel.text = @"00";
    
    imgWinner.image = nil;
    int tag=1;
    for(int r=0; r<6;r++) //resets the gameboard
    {
        for(int c=0; c<7; c++)
        {
            UIImageView *blackhole = (UIImageView*)[self.view viewWithTag:tag]; 
            
            holes[r][c] = blackhole;
            blackhole.image = [UIImage imageNamed:@"black.png"];
            tag++;
        }
    }
    
    //turn = 1 ;
    points = 100;
    pointsLabel.text = [NSString stringWithFormat:@"%i", points];

    countMoves = 0;
    gameOver = false;
    draw = false;
    statusLabel.text = @"";
    [self aiTurn];
}


-(void)resetBtnClick
{
    p1wins=0;
    p2wins=0;
    p1score.text = [NSString stringWithFormat:@"%i",p1wins];
    p2score.text = [NSString stringWithFormat:@"%i",p2wins];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //CGPoint location = [touch locationInView:self.view];
    
    for(int r=0; r<6;r++)
    {
        for(int c=0; c<7; c++)
        {
            if(holes[r][c].tag ==touch.view.tag)
            {
                if(c==0)
                {
                    playermove=c;
                    [self playerTurns];
                    [self aiTurn];
                }
                else if(c==1)
                {
                    playermove=c;
                    [self playerTurns];
                    [self aiTurn];
                }
                else if(c==2)
                {
                    playermove=c;
                    [self playerTurns];
                    [self aiTurn];
                }
                else if(c==3)
                {
                    playermove=c;
                    [self playerTurns];
                    [self aiTurn];
                }
                else if(c==4)
                {
                    playermove=c;
                    [self playerTurns];
                    [self aiTurn];
                }
                else if(c==5)
                {
                    playermove=c;
                    [self playerTurns];
                    [self aiTurn];
                }
                else if(c==6)
                {
                    playermove=c;
                    [self playerTurns];
                    [self aiTurn];
                }
                
            }
        }
    }
}

-(void)playerTurns
{
    UIImage *black = [UIImage imageNamed:@"black.png"];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    WinningCombinations * wc = [[WinningCombinations alloc] init];
        
    if (!gameOver) 
    {
        if(turn==1)
        {
            if(countMoves == 0){
                //eto yun timer
                points = 100;
                timeSec = 0;
                timeMin = 0;
                timeHour = 0;
                timerLabelMin.text = @"00";
                gameTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countUpSec) userInfo:nil repeats:YES];
                gameTimerMin = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(countUpMin) userInfo:nil repeats:YES];
                gameTimerHr = [NSTimer scheduledTimerWithTimeInterval:3600 target:self selector:@selector(countUpMin) userInfo:nil repeats:YES];
            }
            for(int row=5; row>=0; row--)
            {
                if ([holes[row][playermove].image isEqual:black])
                {
                    holes[row][playermove].image = [UIImage imageNamed:@"red.png"];
                    countMoves++; //counts the number of moves
                    
                    for (int i=0; i<6; i++)
                    {
                        for (int j=0; j<7; j++)
                        {
                            [temp addObject:holes[i][j]];
                        }
                    }
                    gameOver = [wc checkWin:temp];
                    
                    if(countMoves == 42)
                    {
                        gameOver = true;
                        draw = true;
                    }
                    
                    if(gameOver)
                    {
                        if(draw)
                        {
                            [gameTimer invalidate];
                            [gameTimerMin invalidate];
                            [gameTimerHr invalidate];
                            statusLabel.text = @"";
                            
                            imgWinner.image = [UIImage imageNamed:@"draw.png"];
                            gameOver = true;
                            turn=1;
                            draw=false;
                        }
                        else 
                        {
                            [gameTimer invalidate];
                            [gameTimerMin invalidate];
                            [gameTimerHr invalidate];
                            statusLabel.text = @"";
                            
                            imgWinner.image = [UIImage imageNamed:@"p1wins.png"];
                            p1wins++;
                            p1score.text = [NSString stringWithFormat:@"%i",p1wins];
                            turn=2;
                            
                            if(difficulty == 1)
                            {
                                if([dataEasy count]>=10)
                                {
                                    for(int a=0; a<10; a++)
                                    {
                                        NSString *time = [[dataEasy objectAtIndex:a] objectForKey:@"time"];
                                        time = [time substringToIndex:8];
                                        NSString *minutes = [time substringToIndex:5];
                                        int hour = [time substringToIndex:2].intValue, min = [minutes substringFromIndex:3].intValue, sec = [time substringFromIndex:6].intValue;
                                        int newhour = timerLabelHr.text.intValue, newmin = timerLabelMin.text.intValue, newsec = timerLabel.text.intValue;
                                        NSLog(@"H:%i M:%i S:%i", hour,min,sec);
                                        if(hour >= newhour)
                                        {
                                            if (min >= newmin)
                                            {
                                                if(sec >= newsec)
                                                {
                                                    //[self showAlertHighScore];
                                                    [self showOverlay];
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    //[self showAlertHighScore];
                                    [self showOverlay];
                                }                                                       
                            }
                            
                            if(difficulty == 2)
                            {
                                if([dataNormal count]>=10)
                                {
                                    for(int a=0; a<10; a++)
                                    {
                                        NSString *time = [[dataNormal objectAtIndex:a] objectForKey:@"time"];
                                        time = [time substringToIndex:8];
                                        NSString *minutes = [time substringToIndex:5];
                                        int hour = [time substringToIndex:2].intValue, min = [minutes substringFromIndex:3].intValue, sec = [time substringFromIndex:6].intValue;
                                        int newhour = timerLabelHr.text.intValue, newmin = timerLabelMin.text.intValue, newsec = timerLabel.text.intValue;
                                        
                                        if(hour >= newhour)
                                        {
                                            if (min >= newmin)
                                            {
                                                if(sec >= newsec)
                                                {
                                                    //[self showAlertHighScore];
                                                    [self showOverlay];
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    //[self showAlertHighScore];
                                    [self showOverlay];
                                }                                                       
                            }
                            if(difficulty == 3)
                            {
                                if([dataHard count]>=10)
                                {
                                    for(int a=0; a<10; a++)
                                    {
                                        NSString *time = [[dataHard objectAtIndex:a] objectForKey:@"time"];
                                        time = [time substringToIndex:8];
                                        NSString *minutes = [time substringToIndex:5];
                                        int hour = [time substringToIndex:2].intValue, min = [minutes substringFromIndex:3].intValue, sec = [time substringFromIndex:6].intValue;
                                        int newhour = timerLabelHr.text.intValue, newmin = timerLabelMin.text.intValue, newsec = timerLabel.text.intValue;
                                        
                                        if(hour >= newhour)
                                        {
                                            if (min >= newmin)
                                            {
                                                if(sec >= newsec)
                                                {
                                                    //[self showAlertHighScore];
                                                    [self showOverlay];
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    //[self showAlertHighScore];
                                    [self showOverlay];
                                }                                                       
                            }                        
                        }    
                    }
                    else 
                    {
                        turn=2;
                    }
                    
                    break;
                }
                else if(![holes[0][playermove].image isEqual:black]) 
                {
                    statusLabel.text = @"Column is full";
                    break;
                }
                
            }
        }
    }
}

-(void)aiTurn
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    AI *ai = [[AI alloc] init];
    WinningCombinations * wc = [[WinningCombinations alloc] init];
    
    if (!gameOver) 
    {
        if(turn==2)
        {
            if(countMoves == 0){
                //eto yun timer
                points = 100;
                timeSec = 0;
                timeMin = 0;
                timeHour = 0;
                timerLabelMin.text = @"00";
                gameTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countUpSec) userInfo:nil repeats:YES];
                gameTimerMin = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(countUpMin) userInfo:nil repeats:YES];
                gameTimerHr = [NSTimer scheduledTimerWithTimeInterval:3600 target:self selector:@selector(countUpMin) userInfo:nil repeats:YES];
            }
            for (int i=0; i<6; i++)
            {
                for (int j=0; j<7; j++)
                {
                    [temp addObject:holes[i][j]];
                }
            }
            
            if(difficulty == 1)
            {
                countMoves++;
                [ai Easy:temp];
            }
            if(difficulty == 2)
            {
                countMoves++;
                [ai Normal:temp];
            }
            if(difficulty == 3)
            {
                countMoves++;
                [ai Hard:temp];
            }
            
            gameOver = [wc checkWin:temp];
            
            if(countMoves == 42)
            {
                gameOver = true;
                draw = true;
            }
            
            if(gameOver)
            {
                if(draw)
                {
                    [gameTimer invalidate];
                    [gameTimerMin invalidate];
                    [gameTimerHr invalidate];
                    statusLabel.text = @"";
                    imgWinner.image = [UIImage imageNamed:@"draw.png"];
                    gameOver = true;
                    turn=2;
                    draw=false;
                }
                else 
                {
                    [gameTimer invalidate];
                    [gameTimerMin invalidate];
                    [gameTimerHr invalidate];
                    statusLabel.text = @"";
                    imgWinner.image = [UIImage imageNamed:@"aiwins.png"];
                    p2wins++;
                    p2score.text = [NSString stringWithFormat:@"%i",p2wins];
                    turn=1;
                }    
            }
            else 
            {
                turn=1;
            }

        }
    }

}

- (void)countUpSec
{
    if(timeSec == 59)
    {
        timeSec = 0;
        if(points == 10)
        {
            pointsLabel.text = [NSString stringWithFormat:@"%i", points];
        }
        else {
            points-=5;
            pointsLabel.text = [NSString stringWithFormat:@"%i", points];
        }
        timerLabel.text = [NSString stringWithFormat:@"0%i", timeSec];
    }
    else 
    {
        timeSec += 1; 
        if(timeSec <= 9)
        {
            timerLabel.text = [NSString stringWithFormat:@"0%i", timeSec];
        }
        else {
            timerLabel.text = [NSString stringWithFormat:@"%i", timeSec];
        } 
    
        if(((timeSec-1)%5 == 0) && timeSec>1)
        {
            if(points == 10)
            {
                pointsLabel.text = [NSString stringWithFormat:@"%i", points];
            }
            else {
                points-=5;
                pointsLabel.text = [NSString stringWithFormat:@"%i", points];
            }
                        
        }
            
    }
}

- (void)countUpMin
{
    if(timeMin == 59)
    {
        timeMin = 0;
        timerLabelMin.text = [NSString stringWithFormat:@"0%i", timeMin];
    }
    else 
    {
        timeMin += 1; 
        if(timeMin <= 9)
        {
            timerLabelMin.text = [NSString stringWithFormat:@"0%i", timeMin];
        }
        else {
            timerLabelMin.text = [NSString stringWithFormat:@"%i", timeMin];
        } 
    }
}

- (void)countUpHr
{

    timeHour += 1; 
    if(timeHour <= 9)
    {
        timerLabelHr.text = [NSString stringWithFormat:@"0%i", timeHour];
    }
    else {
        timerLabelHr.text = [NSString stringWithFormat:@"%i", timeHour];
    }   
}

- (IBAction)stopTime:(id)sender {
    [gameTimer invalidate];
}

//ojfkjalflkdajlkf
//adlkjdslkjaskjdl
- (void)showOverlay{
    SummaryView *showOverlay = [[SummaryView alloc] init];
    showOverlay.delegate = self;
    currentTime = [NSString stringWithFormat:@"%@:%@:%@",timerLabelHr.text,timerLabelMin.text, timerLabel.text];
    [showOverlay labelPoints].text = [NSString stringWithFormat:@"You scored %i points!", points];
    [showOverlay labelTime].text = [NSString stringWithFormat:@"Your time is %@\nEnter your name", currentTime];
    [self.view addSubview:showOverlay];
}

- (void)recordHighScores:(NSString*)aName
{
    NSLog(@"name:%@",aName);
    name = aName;
    
    stringTime = [NSString stringWithFormat:@"%@:%@:%@",timerLabelHr.text,timerLabelMin.text, timerLabel.text];
    
    NSData *picData = [[NSUserDefaults standardUserDefaults] objectForKey:@"picture"];
    
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:stringTime, @"time", picData, @"photo", name, @"name",[NSString stringWithFormat:@"%i",points], @"points",nil];
    
    if(difficulty == 1)
    {
        [dataEasy addObject:data];
        Scores = [NSUserDefaults standardUserDefaults];
        [Scores removeObjectForKey:@"easy"];
        [Scores setObject:dataEasy forKey:@"easy"];
        [Scores synchronize];
    }
    if(difficulty == 2)
    {
        [dataNormal addObject:data];
        Scores = [NSUserDefaults standardUserDefaults];
        [Scores removeObjectForKey:@"normal"];
        [Scores setObject:dataNormal forKey:@"normal"];
        [Scores synchronize];
    }
    if(difficulty == 3)
    {
        [dataHard addObject:data];
        Scores = [NSUserDefaults standardUserDefaults];
        [Scores removeObjectForKey:@"hard"];
        [Scores setObject:dataHard forKey:@"hard"];
        [Scores synchronize];
    }

  
}

//- (void)recordHighScore:(NSNotification *) notification
//{
//    
//    name = [notification object];
//    
//    stringTime = [NSString stringWithFormat:@"%@:%@:%@",timerLabelHr.text,timerLabelMin.text, timerLabel.text];
//        
//    NSData *picData = [[NSUserDefaults standardUserDefaults] objectForKey:@"picture"];
//        
//    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:stringTime, @"time", picData, @"photo", name, @"name",[NSString stringWithFormat:@"%i",points], @"points",nil];
//
//    if(difficulty == 1)
//    {
//        [dataEasy addObject:data];
//        Scores = [NSUserDefaults standardUserDefaults];
//        [Scores removeObjectForKey:@"easy"];
//        [Scores setObject:dataEasy forKey:@"easy"];
//        [Scores synchronize];
//    }
//    if(difficulty == 2)
//    {
//        [dataNormal addObject:data];
//        Scores = [NSUserDefaults standardUserDefaults];
//        [Scores removeObjectForKey:@"normal"];
//        [Scores setObject:dataNormal forKey:@"normal"];
//        [Scores synchronize];
//    }
//    if(difficulty == 3)
//    {
//        [dataHard addObject:data];
//        Scores = [NSUserDefaults standardUserDefaults];
//        [Scores removeObjectForKey:@"hard"];
//        [Scores setObject:dataHard forKey:@"hard"];
//        [Scores synchronize];
//    }
//}
@end

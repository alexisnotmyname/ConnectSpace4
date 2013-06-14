//
//  VPlayerMode.m
//  Connect Four
//
//  Created by Training on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VPlayerMode.h"
#import <QuartzCore/QuartzCore.h>

@interface VPlayerMode ()

@end

@implementation VPlayerMode
@synthesize statusLabel;
@synthesize p1score;
@synthesize p2score;

@synthesize imgWinner;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    //asdf
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

    [self setImgWinner:nil];
    [self setP2score:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)goBack
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)aiclick:(id)sender
{

}
-(void)newBtnClick
{
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
    countMoves = 0;
    gameOver = false;
    draw = false;
//    statusLabel.text = @"";
    imgWinner.image = nil;
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
                }
                else if(c==1)
                {
                    playermove=c;
                    [self playerTurns];
                }
                else if(c==2)
                {
                    playermove=c;
                    [self playerTurns];
                }
                else if(c==3)
                {
                    playermove=c;
                    [self playerTurns];
                }
                else if(c==4)
                {
                    playermove=c;
                    [self playerTurns];
                }
                else if(c==5)
                {
                    playermove=c;
                    [self playerTurns];
                }
                else if(c==6)
                {
                    playermove=c;
                    [self playerTurns];
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
                            statusLabel.text = @"";
                            imgWinner.image = [UIImage imageNamed:@"draw.png"];
                            gameOver = true;
                            turn=1;
                            draw=false;
                        }
                        else 
                        {
                            statusLabel.text = @"";
                            imgWinner.image = [UIImage imageNamed:@"p1wins.png"];
                            p1wins++;
                            p1score.text = [NSString stringWithFormat:@"%i",p1wins];
                            turn=2;
                        }    
                    }
                    else 
                    {
                        turn=2;
                        statusLabel.text = @"Player 2's turn";
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
        else 
        {
            for(int row=5; row>=0; row--)
            {
                if ([holes[row][playermove].image isEqual:black])
                {
                    holes[row][playermove].image = [UIImage imageNamed:@"yellow.png"];
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
                            statusLabel.text = @"";
                            imgWinner.image = [UIImage imageNamed:@"draw.png"];
                            gameOver = true;
                            turn=2;
                            draw=false;
                        }
                        else 
                        {
                            statusLabel.text = @"";
                            imgWinner.image = [UIImage imageNamed:@"p2wins.png"];
                            p2wins++;
                            p2score.text = [NSString stringWithFormat:@"%i",p2wins];
                            turn=1;
                        }    
                    }
                    else 
                    {
                        turn=1;
                        statusLabel.text = @"Player 1's turn";
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
@end

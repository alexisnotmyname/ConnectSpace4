//
//  WinningCombinations.m
//  Connect Four
//
//  Created by Training on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WinningCombinations.h"

@interface WinningCombinations ()

@end

@implementation WinningCombinations

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)checkWin:(NSArray *)gameBoard
{
    BOOL gameOver=false;
    UIImage *black = [UIImage imageNamed:@"black.png"];
    
    int i=0;
    for(int r=0; r<6;r++)
    {
        for(int c=0; c<7; c++)
        {
            holes[r][c] = [gameBoard objectAtIndex:i];
            i++;
        }
    }
     
        for(int hr=0; hr<6;hr++) //checks winning pattern by row
    {
        for(int hc=0; hc<4; hc++)
        {
            if(![holes[hr][hc].image isEqual:black] && 
               [holes[hr][hc].image isEqual:holes[hr][hc+1].image] && 
               [holes[hr][hc+1].image isEqual:holes[hr][hc+2].image] && 
               [holes[hr][hc+2].image isEqual:holes[hr][hc+3].image])
            {
                gameOver = true;
                break;
            }
        }
    }
    
    for(int vr=0; vr<3;vr++) //checks winning pattern by column
    {
        for(int vc=0; vc<7; vc++)
        {
            if(![holes[vr][vc].image isEqual:black] && 
               [holes[vr][vc].image isEqual:holes[vr+1][vc].image] && 
               [holes[vr+1][vc].image isEqual:holes[vr+2][vc].image] && 
               [holes[vr+2][vc].image isEqual:holes[vr+3][vc].image])
            {
                gameOver = true;
                break;
            }
        }
    }

    for(int drr=5; drr>2;drr--) //checks winning pattern for diagonals leaning to the right
    {
        for(int drc=0; drc<4; drc++)
        {
            if(![holes[drr][drc].image isEqual:black] && 
               [holes[drr][drc].image isEqual:holes[drr-1][drc+1].image] &&
               [holes[drr-1][drc+1].image isEqual:holes[drr-2][drc+2].image] && 
               [holes[drr-2][drc+2].image isEqual:holes[drr-3][drc+3].image])
            {
                gameOver = true;
                break;
            }
        }
    }

    for(int dlr=0; dlr<3;dlr++) //checks winning pattern for diagonals leaning to the left
    {
        for(int dlc=0; dlc<4; dlc++)
        {
            if(![holes[dlr][dlc].image isEqual:black] && 
               [holes[dlr][dlc].image isEqual:holes[dlr+1][dlc+1].image] &&
               [holes[dlr+1][dlc+1].image isEqual:holes[dlr+2][dlc+2].image] && 
               [holes[dlr+2][dlc+2].image isEqual:holes[dlr+3][dlc+3].image])
            {
                gameOver = true;
                break;
            }
            
            
            
        }
    }

    return gameOver;
}

@end

//
//  VPlayerMode.h
//  Connect Four
//
//  Created by Training on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinningCombinations.h"
#import "AIMode.h"
#import "MainMenu.h"

@interface VPlayerMode : UIViewController
{
    UIImageView *holes[6][7];
    int playermove,turn;
    int countMoves;
    int p1wins, p2wins;
    BOOL gameOver, draw;
}

@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *p1score;
@property (strong, nonatomic) IBOutlet UILabel *p2score;

@property (strong, nonatomic) IBOutlet UIImageView *imgWinner;

- (IBAction)aiclick:(id)sender;
-(void)newBtnClick;
-(void)resetBtnClick;
-(void)playerTurns;
-(void)goBack;


@end

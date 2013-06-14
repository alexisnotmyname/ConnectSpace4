//
//  ViewController.h
//  Connect Four
//
//  Created by Training on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinningCombinations.h"
#import "AIMode.h"
#import "MainMenu.h"
#import "VPlayerMode.h"

@interface ViewController : UIViewController
{
    UIImageView *holes[6][7];
    int playermove,turn;
    int countMoves;
    int p1wins, p2wins;
    BOOL gameOver, draw;
    NSTimer *timer;
}

@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *p1score;
@property (strong, nonatomic) IBOutlet UILabel *p2score;
@property (strong, nonatomic) IBOutlet UIImageView *img;

-(void)tapToCont;
-(void)contClick;
- (IBAction)tapContinue:(id)sender;


@end

//
//  AIMode.h
//  Connect Four
//
//  Created by Training on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinningCombinations.h"
#import "AI.h"
#import "LeaderBoard.h"
#import "Settings.h"
#import "SummaryView.h"

@interface AIMode : UIViewController <UIAlertViewDelegate>
{
    UIImageView *holes[6][7];
    int playermove,turn;
    int countMoves;
    int p1wins, p2wins;
    @public int difficulty;
    BOOL gameOver, draw;
    NSTimer *gameTimer, *gameTimerMin, *gameTimerHr;
    int timeSec;
    int timeMin;
    int timeHour;
    NSString *totalTime, *stringTime, *currentTime;
    NSMutableArray *scoresArrayEasy, *scoresArrayNormal, *scoresArrayHard;
    NSMutableArray *dataEasy,*dataNormal,*dataHard;
    NSUserDefaults *Scores;
    int points;
}

@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *p1score;
@property (strong, nonatomic) IBOutlet UILabel *p2score;
@property (strong, nonatomic) NSString *diff, *name;
@property (strong, nonatomic) IBOutlet UIImageView *imgDiff;
@property (strong, nonatomic) IBOutlet UIImageView *imgWinner;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UILabel *timerLabelMin;
@property (strong, nonatomic) IBOutlet UILabel *timerLabelHr;
@property (strong, nonatomic) IBOutlet UILabel *pointsLabel;

- (void)recordHighScores:(NSString*)aName;
-(void)newBtnClick;
-(void)resetBtnClick;
-(void)goBack;
-(void)countUp;
-(void)countUpMin;
-(void)countUpHr;
- (IBAction)stopTime:(id)sender;
- (void)showOverlay;


@end

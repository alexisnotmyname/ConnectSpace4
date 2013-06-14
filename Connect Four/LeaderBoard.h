//
//  LeaderBoard.h
//  Connect Four
//
//  Created by Training on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AIMode.h"

@interface LeaderBoard : UIViewController
{
    NSMutableArray *easyScores;
    NSMutableArray *normalScores;
    NSMutableArray *hardScores;
    NSMutableArray *temp;
    NSMutableArray *scores;
    NSUserDefaults *clear;
    int rows;
}
@property (strong, nonatomic) IBOutlet UITableView *tableLeaderBoard;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentCtrl;

- (IBAction)segmentChange:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *resetBtn;

- (IBAction)backBtn:(id)sender;
- (IBAction)resetBtn:(id)sender;


@end

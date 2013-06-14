//
//  TableCellSub.h
//  Connect Four
//
//  Created by Training on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCellSub : UITableViewController
{
    NSMutableArray *easyScores;
    NSMutableArray *normalScores;
    NSMutableArray *hardScores;
    NSMutableArray *temp;
    NSMutableArray *scores;
    NSUserDefaults *clear;
    int rows;
}
@property(strong, nonatomic) NSMutableArray *scores;
@property(strong, nonatomic) NSUserDefaults *clear;

@end

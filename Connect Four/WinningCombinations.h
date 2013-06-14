//
//  WinningCombinations.h
//  Connect Four
//
//  Created by Training on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WinningCombinations : UIViewController
{
    UIImageView *holes[6][7];
}

- (BOOL)checkWin:(NSArray *)gameBoard;
@end

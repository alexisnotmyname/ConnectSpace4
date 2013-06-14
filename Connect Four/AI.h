//
//  AI.h
//  Connect Four
//
//  Created by Training on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinningCombinations.h"

@interface AI : UIViewController
{
    UIImageView *holes[6][7];
    UIImageView *holesTemp[6][7];
    int winningRow, winningCol;
}

-(void)Easy:(NSArray *)gameBoard;
-(void)Normal:(NSArray *)gameBoard;;
-(void)Hard:(NSArray *)gameBoard;;

@end

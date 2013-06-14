//
//  MainMenu.h
//  Connect Four
//
//  Created by Training on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPlayerMode.h"
#import "AIMode.h"
#import "LeaderBoard.h"
#import "Settings.h"
#import <AVFoundation/AVFoundation.h>

@interface MainMenu : UIViewController<AVAudioPlayerDelegate>
{
    UIButton *vsPlayer,
    *vsAi,
    *leaderboard,
    *vsAiEasy,
    *vsAiNormal,
    *vsAiHard;
    BOOL subMenu;
    AVAudioPlayer *bgMusic;
    NSUserDefaults *playerPic;    
}
@property (strong, nonatomic) IBOutlet UIImageView *image;
//@property(strong, nonatomic) UIImage *playerPic;
//@property(strong, nonatomic) NSString *playerPic;

-(void)stopSound;
-(void)playSound;
-(void)displayDifficulty;
-(void)butVPlayer;
-(void)butLeaderboard;
-(void)butEasy;
-(void)butNormal;
-(void)butHard;
- (IBAction)settingsClicked:(id)sender;


@end

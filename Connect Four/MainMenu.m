//
//  MainMenu.m
//  Connect Four
//
//  Created by Training on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import <QuartzCore/QuartzCore.h>

@interface MainMenu ()

@end


@implementation MainMenu


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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gaming_zone" ofType:@"mp3"];
    bgMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:
               [NSURL fileURLWithPath:path] error:NULL];
    bgMusic.delegate = self;
    bgMusic.numberOfLoops = INFINITY;
    
    NSData *picData = [[NSUserDefaults standardUserDefaults] objectForKey:@"picture"];

    playerPic = [NSUserDefaults standardUserDefaults];
    if(picData == nil)
    {
        [playerPic removeObjectForKey:@"picture"];
        [playerPic setObject:UIImagePNGRepresentation([UIImage imageNamed:@"noimg"]) forKey:@"picture"];
        [playerPic synchronize];
    }
    
    ///////////////////////vs player    
    vsPlayer = [UIButton buttonWithType:UIButtonTypeCustom];
    [vsPlayer setBackgroundColor:[UIColor clearColor]];
    [vsPlayer addTarget:self action:@selector(butVPlayer) forControlEvents:UIControlEventTouchUpInside];
    vsPlayer.frame = CGRectMake(95, 176, 150, 50);
    vsPlayer.layer.cornerRadius = 2.0f;
    vsPlayer.layer.borderWidth = 0.5f;
    vsPlayer.layer.borderColor = [[UIColor clearColor] CGColor];
    
    UIImage *vsImg = [UIImage imageNamed:@"vsplayer.png"];
    [vsPlayer setBackgroundImage:vsImg forState:UIControlStateNormal];
    UIImage *vsImgPress = [UIImage imageNamed:@"vsplayer1.png"];
    [vsPlayer setBackgroundImage:vsImgPress forState:UIControlStateHighlighted];
    //////////////////////
    [self.view addSubview:vsPlayer];
    
    ///////////////////////vs ai     
    vsAi = [UIButton buttonWithType:UIButtonTypeCustom];
    [vsAi setBackgroundColor:[UIColor clearColor]];
    [vsAi addTarget:self action:@selector(displayDifficulty) forControlEvents:UIControlEventTouchUpInside];
    vsAi.frame = CGRectMake(95, 228, 150, 50);
    vsAi.layer.cornerRadius = 2.0f;
    vsAi.layer.borderWidth = 0.5f;
    vsAi.layer.borderColor = [[UIColor clearColor] CGColor];
    
    UIImage *vsImgAi = [UIImage imageNamed:@"vsai.png"];
    [vsAi setBackgroundImage:vsImgAi forState:UIControlStateNormal];
    UIImage *vsImgAiPress = [UIImage imageNamed:@"vsai1.png"];
    [vsAi setBackgroundImage:vsImgAiPress forState:UIControlStateHighlighted];
    //////////////////////
    [self.view addSubview:vsAi];
    
    ///////////////////////leaderboard
    leaderboard = [UIButton buttonWithType:UIButtonTypeCustom];
    [leaderboard setBackgroundColor:[UIColor clearColor]];
    [leaderboard addTarget:self action:@selector(butLeaderboard) forControlEvents:UIControlEventTouchUpInside];
    leaderboard.frame = CGRectMake(95, 278, 150, 50);
    leaderboard.layer.cornerRadius = 2.0f;
    leaderboard.layer.borderWidth = 0.5f;
    leaderboard.layer.borderColor = [[UIColor clearColor] CGColor];
    
    UIImage *leaderboardImg = [UIImage imageNamed:@"leaderboard.png"];
    [leaderboard setBackgroundImage:leaderboardImg forState:UIControlStateNormal];
    UIImage *leaderboardImgPress = [UIImage imageNamed:@"leaderboard1.png"];
    [leaderboard setBackgroundImage:leaderboardImgPress forState:UIControlStateHighlighted];
    //////////////////////
    [self.view addSubview:leaderboard];
    
    ///////////////////////ai easy
    vsAiEasy = [UIButton buttonWithType:UIButtonTypeCustom];
    [vsAiEasy setBackgroundColor:[UIColor clearColor]];
    [vsAiEasy addTarget:self action:@selector(butEasy) forControlEvents:UIControlEventTouchUpInside];
    vsAiEasy.frame = CGRectMake(123, 273, 90, 30);
    vsAiEasy.layer.cornerRadius = 2.0f;
    vsAiEasy.layer.borderWidth = 0.5f;
    vsAiEasy.layer.borderColor = [[UIColor clearColor] CGColor];
    
    UIImage *vsImgAiEasy = [UIImage imageNamed:@"easyai.png"];
    [vsAiEasy setBackgroundImage:vsImgAiEasy forState:UIControlStateNormal];
    [self.view addSubview:vsAiEasy];
    
    ///////////////////////ai normal  
    vsAiNormal = [UIButton buttonWithType:UIButtonTypeCustom];
    [vsAiNormal setBackgroundColor:[UIColor clearColor]];
    [vsAiNormal addTarget:self action:@selector(butNormal) forControlEvents:UIControlEventTouchUpInside];
    vsAiNormal.frame = CGRectMake(126, 311, 90, 30);
    vsAiNormal.layer.cornerRadius = 2.0f;
    vsAiNormal.layer.borderWidth = 0.5f;
    vsAiNormal.layer.borderColor = [[UIColor clearColor] CGColor];
    
    UIImage *vsImgAiNormal = [UIImage imageNamed:@"normai.png"];
    [vsAiNormal setBackgroundImage:vsImgAiNormal forState:UIControlStateNormal];
    [self.view addSubview:vsAiNormal];
    
    ///////////////////////ai hard  
    vsAiHard = [UIButton buttonWithType:UIButtonTypeCustom];
    [vsAiHard setBackgroundColor:[UIColor clearColor]];
    [vsAiHard addTarget:self action:@selector(butHard) forControlEvents:UIControlEventTouchUpInside];
    vsAiHard.frame = CGRectMake(123, 349, 90, 30);
    vsAiHard.layer.cornerRadius = 2.0f;
    vsAiHard.layer.borderWidth = 0.5f;
    vsAiHard.layer.borderColor = [[UIColor clearColor] CGColor];
    
    UIImage *vsImgAiHard = [UIImage imageNamed:@"hardai.png"];
    [vsAiHard setBackgroundImage:vsImgAiHard forState:UIControlStateNormal];
    [self.view addSubview:vsAiHard];
    
   
    
    vsAiEasy.hidden = YES;
    vsAiNormal.hidden = YES;
    vsAiHard.hidden = YES;
    


}

-(void)viewWillAppear:(BOOL)animated
{    
    //sample.image = sample2;
    NSString *sound;
    sound = [[NSUserDefaults standardUserDefaults] objectForKey:@"sound"];
    NSLog(@"%@ main",sound);
    
    if([sound isEqual:@"1"])
    {
        [bgMusic play];
    }
    else {
        NSLog(@"%@ stop",sound);
        [bgMusic stop];
    }
//    NSData *picData = [[NSUserDefaults standardUserDefaults] objectForKey:@"picture"];
//    sample.image = [UIImage imageWithData:picData];
    
//    NSString *picstring = [[NSString alloc] initWithData:picData encoding:NSUTF8StringEncoding];
//    NSData *picData2 = [picstring dataUsingEncoding:NSUTF8StringEncoding];
//    sample.image = [UIImage imageWithData:picData2];
//    NSLog(@"%@ 123",picstring);
}

-(void)stopSound
{
    [bgMusic stop];
}
-(void)playSound
{
    [bgMusic play];
}

- (void)displayDifficulty
{
    if(subMenu)
    {
        vsAiEasy.hidden = YES;
        vsAiNormal.hidden = YES;
        vsAiHard.hidden = YES;
        subMenu=false;
        
        leaderboard.frame = CGRectMake(95, 278, 150, 50);
        [self.view addSubview:leaderboard];
    }
    else 
    {
        vsAiEasy.hidden = NO;
        vsAiNormal.hidden = NO;
        vsAiHard.hidden = NO;
        subMenu=true;
         
        leaderboard.frame = CGRectMake(95, 390, 150, 50);
        [self.view addSubview:leaderboard];
    }
    
    
}

- (void)butVPlayer
{
    VPlayerMode *vp = [[VPlayerMode alloc] init];
    vp.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:vp animated:YES];
}

- (void)butLeaderboard
{
    LeaderBoard *showBoard = [[LeaderBoard alloc] init];
    [self presentModalViewController:showBoard animated:YES];
}

- (void)butEasy
{
    AIMode *ai = [[AIMode alloc] init];
    ai.diff = @"1";
    ai.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:ai animated:YES];
}

- (void)butNormal
{
    AIMode *ai = [[AIMode alloc] init];
    ai.diff = @"2";
    ai.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:ai animated:YES];
}

- (void)butHard
{
    AIMode *ai = [[AIMode alloc] init];
    ai.diff = @"3";
    ai.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:ai animated:YES];
}

- (IBAction)settingsClicked:(id)sender {
    
    Settings *showSettings = [[Settings alloc] init];
    showSettings.delegate = self;
    showSettings.modalTransitionStyle= UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:showSettings animated:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

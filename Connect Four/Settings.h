//
//  Settings.h
//  Connect Four
//
//  Created by Training on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MainMenu.h"
#import "AIMode.h"
#import "MainMenu.h"

@class MainMenu;
@interface Settings : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVAudioPlayerDelegate>
{
    NSArray *settingsItems;
    AVAudioPlayer *bgMusic;
    UISwitch *sound;
    NSUserDefaults *soundstate, *playerPic;
    NSString *sample;
    UIImage *picSelected;
    
}
@property (assign) MainMenu *delegate;
@property (strong, nonatomic) IBOutlet UIImageView *imageSelected;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) NSString *sample;

- (IBAction)settingsDismiss:(id)sender;

- (IBAction)pickImage:(id)sender;
-(void)soundClick;

@end

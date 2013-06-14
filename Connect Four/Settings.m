//
//  Settings.m
//  Connect Four
//
//  Created by Training on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"
#import <QuartzCore/QuartzCore.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MainMenu.h"

@interface Settings ()

@end

@implementation Settings
@synthesize imageSelected;
@synthesize navBar;
@synthesize sample;
@synthesize delegate = _delegate;

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
    
    
    soundstate = [NSUserDefaults standardUserDefaults];
    playerPic = [NSUserDefaults standardUserDefaults];

    settingsItems = [[NSArray alloc] initWithObjects:@"Sound",@"Instructions",@"About", nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSData *picData = [[NSUserDefaults standardUserDefaults] objectForKey:@"picture"];
    if(picData == nil)
    {
        [playerPic removeObjectForKey:@"picture"];
        imageSelected.image = [UIImage imageNamed:@"noimg"];
        [playerPic setObject:UIImagePNGRepresentation([UIImage imageNamed:@"noimg"]) forKey:@"picture"];
        [playerPic synchronize];
    }
    else {
       
        imageSelected.image = [UIImage imageWithData:picData];
    }

}

- (void)viewDidUnload
{
    [self setNavBar:nil];
    [self setImageSelected:nil];
    [super viewDidUnload];

}

-(NSInteger)numberOfsectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [settingsItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.textLabel.text = [settingsItems objectAtIndex:indexPath.row];
    
    if(indexPath.row ==0)
    {
        float center = cell.frame.size.height/2;
        sound = [[UISwitch alloc] initWithFrame:CGRectMake(170, center/2.5, 90,cell.frame.size.height)];
        
        [sound addTarget:self action:@selector(soundClick) forControlEvents:UIControlEventValueChanged];
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sound"] isEqual:@"1"]){
            [sound setOn:YES];
        }
        else
        {
            [sound setOn:NO];
        }
        
        [[cell contentView] addSubview:sound];
    }
    return cell;
}

- (void)soundClick
{
   
    if(sound.on)
    {
        [self.delegate playSound];
        [soundstate removeObjectForKey:@"sound"];
        [soundstate setObject:@"1" forKey:@"sound"];
        [soundstate synchronize];
        NSLog(@"%@ settings", [[NSUserDefaults standardUserDefaults] objectForKey:@"sound"]);
    }
    else {
        [self.delegate stopSound];
        [soundstate removeObjectForKey:@"sound"];
        [soundstate setObject:@"0" forKey:@"sound"];
        [soundstate synchronize];
        NSLog(@"%@ settings", [[NSUserDefaults standardUserDefaults] objectForKey:@"sound"]);
        
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)settingsDismiss:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)pickImage:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
//    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:imagePicker animated:YES];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    imageSelected.image = image;
    picSelected = image;
    
    [playerPic removeObjectForKey:@"picture"];
    [playerPic setObject:UIImagePNGRepresentation(picSelected) forKey:@"picture"];
    [playerPic synchronize];

    [picker dismissModalViewControllerAnimated:YES];
}



@end

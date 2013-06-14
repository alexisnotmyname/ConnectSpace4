//
//  ViewController.m
//  Connect Four
//
//  Created by Training on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@end

@implementation ViewController
@synthesize statusLabel;
@synthesize p1score;
@synthesize p2score;
@synthesize img;


- (void)viewDidLoad
{
    [super viewDidLoad];
    timer = [NSTimer scheduledTimerWithTimeInterval:2.2 target:self selector:@selector(tapToCont) userInfo:nil repeats:NO];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2.2];
    img.transform = CGAffineTransformScale(img.transform, 1.3, 1.3);
    [UIView commitAnimations];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2.2];
    img.transform = CGAffineTransformScale(img.transform, 0.5, 0.5);
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    

    if(timer == nil)
    {
         timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(newBtnClick) userInfo:nil repeats:NO];
    }


    
    
    
}

- (void)viewDidUnload
{
    
    [self setStatusLabel:nil];
    [self setP1score:nil];
    [self setP2score:nil];
    [self setImg:nil];
    [super viewDidUnload];
    
//    VPlayerMode *vp =[[VPlayerMode alloc] init];
//    [self presentModalViewController:vp animated:YES];
    //    AIMode *ai = [[AIMode alloc] init];
    //    [self presentModalViewController:ai animated:YES];

    
}



-(void)tapToCont
{

    UIImageView *tap = [[UIImageView alloc] init];
//    tap = [UIButton buttonWithType:UIButtonTypeCustom];
//    [tap setBackgroundColor:[UIColor clearColor]];
    //[tap addTarget:self action:@selector(contClick) forControlEvents:UIControlEventTouchUpInside];
    tap.frame = CGRectMake(83, 344, 165, 90);
//    tap.layer.cornerRadius = 5.0f;
//    tap.layer.borderWidth = 0.5f;
//    tap.layer.borderColor = [[UIColor clearColor] CGColor];
    
//    UIImage *tapImg = [UIImage imageNamed:@"taps2.png"];
    tap.animationImages = [NSArray arrayWithObjects:
                           [UIImage imageNamed:@"taps2.png"],
                           [UIImage imageNamed:@"taps1.png"], nil];
    tap.animationDuration = 1.3;
    [tap startAnimating];
//    [tap setBackgroundImage:tapImg forState:UIControlStateNormal];
    tap.alpha = 0.65;
    [self.view addSubview:tap];


}


-(void)contClick
{
    
}

- (IBAction)tapContinue:(id)sender {
    
    MainMenu *menu = [[MainMenu alloc] init];
    menu.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:menu animated:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)playerTurns
{
    
}

@end

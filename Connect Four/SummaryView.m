//
//  SummaryView.m
//  Connect Four
//
//  Created by Training on 8/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SummaryView.h"
#import <QuartzCore/QuartzCore.h>
//#import "AIMode.h"

@implementation SummaryView
@synthesize labelPoints;
@synthesize labelTime;
@synthesize nameTextField;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, 320, 460);
//    frame = CGRectMake(20, 120, 280, 220);
    self = [super initWithFrame:frame];
    if (self) {
        
        //dim background
        dimBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
        dimBg.backgroundColor = [UIColor blackColor];
        dimBg.alpha = 0.6;
        [self addSubview:dimBg];
        
        //Image for the View
        backGround = [[UIImageView alloc] initWithFrame:CGRectMake(5, 120-100, 310, 250-20)];
        backGround.image = [UIImage imageNamed:@"viewBg"];
        [self addSubview:backGround];
        
        //logo
        imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 120-100, 280, 100)];
        imgLogo.image = [UIImage imageNamed:@"disc3"];
        imgLogo.alpha = 0.7;
        imgLogo.contentMode = UIViewContentModeCenter;
        [self addSubview:imgLogo];
        
        //label for points
        labelPoints = [[UILabel alloc] initWithFrame:CGRectMake(20, 120-70, 280, 30)];
        labelPoints.contentMode = UIViewContentModeCenter;
        labelPoints.textAlignment = UITextAlignmentCenter;
        labelPoints.backgroundColor = [UIColor clearColor];
        labelPoints.textColor = [UIColor whiteColor];
        labelPoints.font = [UIFont boldSystemFontOfSize:18.0];
        labelPoints.text = @"You scored Some points";
        [self addSubview:labelPoints];
        
        //label for time
        labelTime = [[UILabel alloc] initWithFrame:CGRectMake(20, 200-100, 280, 50)];
        labelTime.contentMode = UIViewContentModeCenter;
        labelTime.textAlignment = UITextAlignmentCenter;
        labelTime.backgroundColor = [UIColor clearColor];
        labelTime.textColor = [UIColor whiteColor];
        labelTime.numberOfLines = 2;
        labelTime.lineBreakMode = UILineBreakModeCharacterWrap;
        labelTime.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        labelTime.text = @"Your time is cheverloo samting\nEnter name";
        [self addSubview:labelTime];
        
        //textfield for name
        nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(33, 250-100, 250, 28)];
        nameTextField.contentMode = UIViewContentModeCenter;
        nameTextField.borderStyle = UITextBorderStyleBezel;
        nameTextField.textColor = [UIColor blackColor];
        nameTextField.font = [UIFont systemFontOfSize:16.0];
        nameTextField.placeholder = @"name";
        nameTextField.backgroundColor = [UIColor whiteColor];
        nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        nameTextField.returnKeyType = UIReturnKeyDone;
        nameTextField.keyboardType = UIKeyboardTypeDefault;
        nameTextField.delegate = self;
        nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:nameTextField];
        
//        initWithFrame:CGRectMake(70, 340, 100, 80)
        //button cancel
        buttonCancel= [[UIButton alloc] init];
        buttonCancel.contentMode = UIViewContentModeCenter;
        [buttonCancel addTarget:self action:@selector(CancelBtn) forControlEvents:UIControlEventTouchUpInside];
        buttonCancel.frame = CGRectMake(40, 300-110, 100, 40);
        buttonCancel.layer.cornerRadius = 2.0f;
        buttonCancel.layer.borderWidth = 0.5f;
        buttonCancel.layer.borderColor = [[UIColor clearColor] CGColor];
        UIImage *cancelImg = [UIImage imageNamed:@"cancelred"];
        [buttonCancel setBackgroundImage:cancelImg forState:UIControlStateNormal];
        UIImage *cancelImgPress = [UIImage imageNamed:@"cancelyellow"];
        [buttonCancel setBackgroundImage:cancelImgPress forState:UIControlStateHighlighted];
        [self addSubview:buttonCancel];
        
        //button ok
        buttonOk = [[UIButton alloc] init];
        buttonOk.contentMode = UIViewContentModeCenter;
        [buttonOk addTarget:self action:@selector(ButtonOks) forControlEvents:UIControlEventTouchUpInside];
        buttonOk.frame = CGRectMake(180, 300-110, 100, 40);
        buttonOk.layer.cornerRadius = 2.0f;
        buttonOk.layer.borderWidth = 0.5f;
        buttonOk.layer.borderColor = [[UIColor clearColor] CGColor];
        UIImage *okImg = [UIImage imageNamed:@"okred"];
        [buttonOk setBackgroundImage:okImg forState:UIControlStateNormal];
        UIImage *okImgPress = [UIImage imageNamed:@"okyellow"];
        [buttonOk setBackgroundImage:okImgPress forState:UIControlStateHighlighted];
        buttonOk.enabled = false;
        [self addSubview:buttonOk];
        
        
    }
    return self;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *nameString = [nameTextField.text stringByReplacingCharactersInRange:range withString:string];
    nameString = [nameString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([nameString isEqualToString:@""])
    {
        buttonOk.enabled = false;
        return YES;
    }
    if (nameTextField.text.length >=10 && range.length == 0) {
        return NO;
    } 
    else {
        buttonOk.enabled = YES;
        return YES;
    }
}

- (void)CancelBtn
{
    [self removeFromSuperview];
}

- (void)ButtonOks
{
    
    NSString *name = nameTextField.text;
    if ([self.delegate respondsToSelector:@selector(recordHighScores:)])
        [self.delegate recordHighScores:name];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"record" object:name];
    [self removeFromSuperview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [nameTextField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    buttonOk.enabled = NO;
    return YES;
}



//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    if(nameTextField.text.length == 0)
//    {
//        buttonOk.enabled = false;
//    }
//    else {
//          buttonOk.enabled = true;     
//    }
//
//}

@end

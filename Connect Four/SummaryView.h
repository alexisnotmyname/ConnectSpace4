//
//  SummaryView.h
//  Connect Four
//
//  Created by Training on 8/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AIMode.h"

@class AIMode;
@interface SummaryView : UIView<UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    UIView *dimBg;
    UIImageView *backGround;
    UIImageView *imgLogo;
    UILabel *labelPoints;
    UITextField *nameTextField;
    UIButton *buttonCancel;
    UIButton *buttonOk;
    UILabel *labelTime;

}
@property(assign) AIMode *delegate;
@property(strong, nonatomic) IBOutlet UITextField *nameTextField;
@property(strong, nonatomic) IBOutlet UILabel *labelPoints;
@property(strong, nonatomic) IBOutlet UILabel *labelTime;
@property(strong, nonatomic) IBOutlet UIButton *buttonOk;
-(void)CancelBtn;
-(void)ButtonOks;

@end

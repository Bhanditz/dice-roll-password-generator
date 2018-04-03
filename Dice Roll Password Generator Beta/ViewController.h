//
//  ViewController.h
//  Dice Roll Password Generator Beta
//
//  Created by Milan Bosic on 4/26/16.
//  Copyright (c) 2016 Milan Bosic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

double currentMaxAccX;
double currentMaxAccY;
double currentMaxAccZ;
double currentMaxRotX;
double currentMaxRotY;
double currentMaxRotZ;
int len;

NSMutableString *letters;

@interface ViewController : UIViewController{
    IBOutlet UIScrollView *scroller;
}

@property (strong, nonatomic) IBOutlet UITextField *PasswordLength;

@property (strong, nonatomic) IBOutlet UITextView *PasswordTextField;

@property (strong, nonatomic) IBOutlet UISwitch *SimilarCharSwitch;

@property (strong, nonatomic) IBOutlet UISwitch *UppercaseLettersSwitch;
@property (strong, nonatomic) IBOutlet UILabel *accX;

@property (strong, nonatomic) IBOutlet UILabel *accY;

@property (strong, nonatomic) IBOutlet UILabel *accZ;

@property (strong, nonatomic) IBOutlet UILabel *maxAccX;

@property (strong, nonatomic) IBOutlet UILabel *maxAccY;

@property (strong, nonatomic) IBOutlet UILabel *maxAccZ;

@property (strong, nonatomic) IBOutlet UILabel *rotX;

@property (strong, nonatomic) IBOutlet UILabel *rotY;

@property (strong, nonatomic) IBOutlet UILabel *rotZ;

@property (strong, nonatomic) IBOutlet UILabel *maxRotX;

@property (strong, nonatomic) IBOutlet UILabel *maxRotY;

@property (strong, nonatomic) IBOutlet UILabel *maxRotZ;

- (IBAction)resetMaxValues:(id)sender;

- (IBAction)GenerateButtonPressed:(id)sender;

@property (strong, nonatomic) CMMotionManager *motionManager;

@end

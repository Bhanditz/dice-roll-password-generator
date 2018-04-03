//
//  ViewController.m
//  RandomNumberApp
//
//  Created by Milan Bosic on 4/24/16.
//  Copyright (c) 2016 Milan Bosic. All rights reserved.
//

#import "ViewController.h"
#include <stdlib.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1000)];
    
    currentMaxAccX = 0;
    currentMaxAccY = 0;
    currentMaxAccZ = 0;
    
    currentMaxRotX = 0;
    currentMaxRotY = 0;
    currentMaxRotZ = 0;
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    self.motionManager.gyroUpdateInterval = .2;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        [self outputAccelerationData:accelerometerData.acceleration];
        if (error){
            NSLog(@"%@", error);
        }
    }];
    
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData *gyroData, NSError *error) {
        [self outputRotationData:gyroData.rotationRate];
    }];
    
}


-(void) outputAccelerationData:(CMAcceleration)acceleration{
    
    self.accX.text = [NSString stringWithFormat:@" %.2fg", acceleration.x];
    if (fabs(acceleration.x) > fabs(currentMaxAccX)){
        currentMaxAccX = acceleration.x;
    }
    
    self.accY.text = [NSString stringWithFormat:@" %.2fg",acceleration.y];
    if(fabs(acceleration.y) > fabs(currentMaxAccY))
    {
        currentMaxAccY = acceleration.y;
    }
    self.accZ.text = [NSString stringWithFormat:@" %.2fg",acceleration.z];
    if(fabs(acceleration.z) > fabs(currentMaxAccZ))
    {
        currentMaxAccZ = acceleration.z;
    }
    
    self.maxAccX.text = [NSString stringWithFormat:@" %.2f",currentMaxAccX];
    self.maxAccY.text = [NSString stringWithFormat:@" %.2f",currentMaxAccY];
    self.maxAccZ.text = [NSString stringWithFormat:@" %.2f",currentMaxAccZ];
    
}

-(void)outputRotationData:(CMRotationRate)rotation
{
    self.rotX.text = [NSString stringWithFormat:@" %.2fr/s",rotation.x];
    if(fabs(rotation.x) > fabs(currentMaxRotX))
    {
        currentMaxRotX = rotation.x;
    }
    self.rotY.text = [NSString stringWithFormat:@" %.2fr/s",rotation.y];
    if(fabs(rotation.y) > fabs(currentMaxRotY))
    {
        currentMaxRotY = rotation.y;
    }
    self.rotZ.text = [NSString stringWithFormat:@" %.2fr/s",rotation.z];
    if(fabs(rotation.z) > fabs(currentMaxRotZ))
    {
        currentMaxRotZ = rotation.z;
    }
    
    self.maxRotX.text = [NSString stringWithFormat:@" %.2f",currentMaxRotX];
    self.maxRotY.text = [NSString stringWithFormat:@" %.2f",currentMaxRotY];
    self.maxRotZ.text = [NSString stringWithFormat:@" %.2f",currentMaxRotZ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetMaxValues:(id)sender {
    currentMaxAccX = 0;
    currentMaxAccY = 0;
    currentMaxAccZ = 0;
    
    currentMaxRotX = 0;
    currentMaxRotY = 0;
    currentMaxRotZ = 0;
}

- (IBAction)GenerateButtonPressed:(id)sender {
    
    len = [_PasswordLength.text intValue];
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    letters = [NSMutableString stringWithCapacity: len];
    
    [letters appendString:@"abcdefghjklmnpqrstuvwxyz23456789"];
    
    int acc = 0;
    int lettersLength = 32;
    
    if (_SimilarCharSwitch.on){
        
        [letters appendString:@"i1o0"];
        lettersLength += 4;
    }
    
    if (_UppercaseLettersSwitch.on && _SimilarCharSwitch.on){
        
        [letters appendString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
        lettersLength += 27;
    } else if (_UppercaseLettersSwitch.on == 1){
        [letters appendString:@"ABCDEFGHJKLMNPQRSTUVWXYZ"];
        lettersLength += 25;
    }

    NSLog(@"letters: %@", letters);
    
        for (int i = 0; i < len; i++){
        
            unsigned char max;
            unsigned char min;
            unsigned char max2;
            unsigned char min2;
            
            if (currentMaxAccX > currentMaxAccY){
                max = currentMaxAccX * currentMaxRotX;
                min = currentMaxAccY;
            } else {
                max = currentMaxAccY * currentMaxRotY;
                min = currentMaxAccX;
            }
            if (currentMaxAccZ > max){
                max = currentMaxAccZ * currentMaxRotZ;
            } else if (currentMaxAccZ < min){
                min = currentMaxAccZ;
            }
        
            acc = (int)max + 1235123;
            //acc = (int)max * currentMaxRotX * currentMaxRotY * currentMaxRotZ * 123123;
            
            unsigned char a = (acc >> 24) & 0xff;
            unsigned char b = (acc >> 16) & 0xff;
            unsigned char c = (acc >> 8) & 0xff;
            unsigned char d = acc & 0xff;
            
            if (a > b) {
                max = a;
                min = b;
            } else {
                max = b;
                min = a;
            }
            if (c > d) {
                max2 = c;
                min2 = d;
            } else {
                max2 = d;
                min2 = c;
            }
            if (max < max2) {
                max = max2;
            }
            if (min > min2) {
                min = min2;
            }
            
            printf("Smallest: %d\n", min);
            printf("Largest: %d\n", max);
            
            unsigned char num = min ^ max;
            
            NSLog(@"XORED num: %d", num);
            
            if (num > lettersLength){
                [randomString appendFormat: @"%C", [letters characterAtIndex: (int)(num % lettersLength)]];

            } else{
                [randomString appendFormat: @"%C", [letters characterAtIndex: (int)num]];

            }
            NSLog(@"random string is: %@", randomString);
            
            [NSThread sleepForTimeInterval:0.03f];

    }
    
    _PasswordTextField.text = randomString;
}

//    [letters appendString:@"abcdefghijklmnpqrstuvwxyz23456789"];
//    
//    if (_SimilarCharSwitch.on){
//        
//        [letters appendString:@"i1o0"];
//        
//    }
//    
//    if (_UppercaseLettersSwitch.on){
//        
//        [letters appendString:@"ABCDEFGHJKLMNPQRSTUVWXYZ"];
//    }


//- (NSString *) randomStringWithLength: (int) len {
//    randomString = [NSMutableString stringWithCapacity: len];
//    
//    for (int i = 0; i < len; i++){
//        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
//    }
//    
//    return randomString;
//}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [_PasswordLength resignFirstResponder];
//}

@end

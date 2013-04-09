//
//  ViewController.h
//  AlarmSB
//
//  Created by Vivek Srinivasan on 20/03/13.
//  Copyright (c) 2013 Vivek Srinivasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmGradientController.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *hourLabel;
@property (strong, nonatomic) IBOutlet UILabel *minLabel;
@property (strong, nonatomic) IBOutlet UILabel *diffLabel;
@property (strong, nonatomic) IBOutlet UILabel *colon;

@property (strong, nonatomic) IBOutlet UILabel *hourTrack;
@property (strong, nonatomic) IBOutlet UILabel *minTrack;

@property (strong, nonatomic) IBOutlet UIView *background;
@property (strong, nonatomic) IBOutlet AlarmGradientController *bg;
@property (strong, nonatomic) IBOutlet UIView *gView;

@property int swipe;

@property (strong, nonatomic) IBOutlet UILabel *hourDec;
@property (strong, nonatomic) IBOutlet UILabel *hourInc;
@property (strong, nonatomic) IBOutlet UILabel *minDec;
@property (strong, nonatomic) IBOutlet UILabel *minInc;

@property UISwipeGestureRecognizer *setAlarm;
@property CGRect stateFrame;
@property BOOL alarmState;
@property NSInteger setHour;
@property NSInteger setMinute;

- (void)reset;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)setAlarmTime;

@end

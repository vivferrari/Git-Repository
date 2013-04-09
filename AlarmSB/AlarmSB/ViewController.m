//
//  ViewController.m
//  AlarmSB
//
//  Created by Vivek Srinivasan on 20/03/13.
//  Copyright (c) 2013 Vivek Srinivasan. All rights reserved.
//

#import "ViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize hourLabel;
@synthesize minLabel;
@synthesize diffLabel;
@synthesize colon;
@synthesize hourTrack;
@synthesize minTrack;
@synthesize swipe;
@synthesize bg;
@synthesize hourDec;
@synthesize hourInc;
@synthesize minDec;
@synthesize minInc;

@synthesize setAlarm;
@synthesize stateFrame;
@synthesize alarmState;
@synthesize setHour;
@synthesize setMinute;
@synthesize gView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    swipe = 0;
    [bg setHour:12];
    self.hourLabel.text = [NSString stringWithFormat:@"%2d",12];
    [bg setHourLabel:hourLabel];
    [bg setMinLabel:minLabel];
    [bg setDiffLabel:diffLabel];
    [bg setColon:colon];
    //stateLabel.text = @"OFF";
    //stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(-100,0,100,self.view.frame.size.height)];
    //[stateLabel setBackgroundColor:[[UIColor alloc] initWithRed:0.85 green:0.85 blue:0.85 alpha:0.66]];
    
    alarmState = NO;
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"AlarmState"];
    }
    
    if (![self.slidingViewController.underRightViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underRightViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }

    [self.slidingViewController setVc:self];
    self.slidingViewController.panGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)reset{
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    swipe = 0;
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!alarmState){
        swipe++;
        if(swipe%3==0){
            CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
            CGPoint prevtouchPoint = [[touches anyObject] previousLocationInView:self.view];
            if(swipe%9==0){
                if (touchPoint.x > hourTrack.frame.origin.x &&
                    touchPoint.x < hourTrack.frame.origin.x + hourTrack.frame.size.width &&
                    touchPoint.y > hourTrack.frame.origin.y &&
                    touchPoint.y < hourTrack.frame.origin.y + hourTrack.frame.size.height){
                    int hr = ([self.hourLabel.text intValue]%24);
                    if(prevtouchPoint.y < touchPoint.y){
                        if(hr+1==24){
                            hr = -1;
                        }
                        self.hourLabel.text = [[NSString alloc]initWithFormat:@"%02d",++hr];
                    }
                    else if(prevtouchPoint.y > touchPoint.y){
                        hr--;
                        if(hr==24){
                            hr = 0;
                        }
                        if(hr<0){
                            hr+=24;
                        }
                        self.hourLabel.text = [[NSString alloc]initWithFormat:@"%02d",hr];
                    }
                    [bg setNeedsDisplayInRect:bg.frame];
                }
            }
            if (touchPoint.x > minTrack.frame.origin.x &&
                touchPoint.x < minTrack.frame.origin.x + minTrack.frame.size.width &&
                touchPoint.y > minTrack.frame.origin.y &&
                touchPoint.y < minTrack.frame.origin.y + minTrack.frame.size.height){
                int min = ([self.minLabel.text intValue]%60);
                if(prevtouchPoint.y < touchPoint.y){
                    min=(++min)%60;
                    self.minLabel.text = [[NSString alloc]initWithFormat:@"%02d",min];
                    if(min==0){
                    }
                }
                else if(prevtouchPoint.y > touchPoint.y){
                    min--;
                    if(min<=0){
                        min+=60;
                    }
                    min%=60;
                    self.minLabel.text = [[NSString alloc]initWithFormat:@"%02d",min];
                }
            }
        }
        [bg setHour:[hourLabel.text intValue]];
        [bg setNeedsDisplayInRect:bg.frame];
        NSLog(@"%i", setHour);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!alarmState){
        [bg setHour:[hourLabel.text intValue]];
        [bg setNeedsDisplayInRect:bg.frame];
        if(swipe==0){
            CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
            if (touchPoint.x > hourDec.frame.origin.x &&
                touchPoint.x < hourDec.frame.origin.x + hourDec.frame.size.width &&
                touchPoint.y > hourDec.frame.origin.y &&
                touchPoint.y < hourDec.frame.origin.y + hourDec.frame.size.height){
                int hr = [self.hourLabel.text intValue];
                if(hr-1<0){
                    hr+=24;
                }
                hr = (hr-1)%24;
                self.hourLabel.text = [[NSString alloc]initWithFormat:@"%02d",hr];;
            }
            else if (touchPoint.x > hourInc.frame.origin.x &&
                     touchPoint.x < hourInc.frame.origin.x + hourInc.frame.size.width &&
                     touchPoint.y > hourInc.frame.origin.y &&
                     touchPoint.y < hourInc.frame.origin.y + hourInc.frame.size.height){
                int hr = [self.hourLabel.text intValue];
                hr = (hr+1)%24;
                self.hourLabel.text = [[NSString alloc]initWithFormat:@"%02d",hr];;
            }
            else if (touchPoint.x > minDec.frame.origin.x &&
                     touchPoint.x < minDec.frame.origin.x + minDec.frame.size.width &&
                     touchPoint.y > minDec.frame.origin.y &&
                     touchPoint.y < minDec.frame.origin.y + minDec.frame.size.height){
                int min = [self.minLabel.text intValue];
                if(min-1<0){
                    min+=60;
                }
                min = (min-1)%60;
                self.minLabel.text = [[NSString alloc]initWithFormat:@"%02d",min];;
            }
            else if (touchPoint.x > minInc.frame.origin.x &&
                     touchPoint.x < minInc.frame.origin.x + minInc.frame.size.width &&
                     touchPoint.y > minInc.frame.origin.y &&
                     touchPoint.y < minInc.frame.origin.y + minInc.frame.size.height){
                int min = [self.minLabel.text intValue];
                min = (min+1)%60;
                self.minLabel.text = [[NSString alloc]initWithFormat:@"%02d",min];;
            }
            [bg setHour:[hourLabel.text intValue]];
            [bg setNeedsDisplayInRect:bg.frame];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)setAlarmOnOff:(id)sender{
    CGPoint swipePoint = [setAlarm locationInView:self.view];
    if(swipePoint.x>=0 && swipePoint.y>=0 && swipePoint.x<=100 && swipePoint.y<=self.view.frame.size.height){
        if(alarmState){
            alarmState = NO;
            //stateLabel.textAlignment = NSTextAlignmentCenter;
            //stateLabel.text = @"OFF";
            diffLabel.text = @"";
        }
        else{
            alarmState = YES;
            //stateLabel.textAlignment = NSTextAlignmentCenter;
            //stateLabel.text = @"ON";
            self.setHour = [hourLabel.text integerValue];
            self.setMinute = [minLabel.text integerValue];
            
            [self setAlarmTime];
        }
        
        //[self.view addSubview:stateLabel];
        //stateFrame = stateLabel.frame;
        stateFrame.origin.x = 0;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:2.0];
        [UIView setAnimationDelay:0.0];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [self performSelector:@selector(backSwipe) withObject:nil afterDelay:0.5];
        
        //stateLabel.frame = stateFrame;
        
        [UIView commitAnimations];
        
    }
}

-(void)setAlarmTime{

    NSDate *now = [[NSDate alloc]init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(kCFCalendarUnitHour | kCFCalendarUnitMinute) fromDate:now];
    NSInteger currentHour = [components hour];
    NSInteger currentMinute = [components minute];
    NSInteger diffHour,diffMin;
    if(self.setHour>currentHour){
        diffHour = self.setHour-currentHour;
    }
    else{
        diffHour = 24-(currentHour-self.setHour);
    }
    
    
    
    if(currentMinute>setMinute){
        diffHour--;
        diffMin = 60-(currentMinute-setMinute);
    }
    else{
        diffMin = setMinute-currentMinute;
    }
    
    diffLabel.alpha = 1;
    NSString *diffLabelText = [[NSString alloc] initWithFormat:@"%02d:%02d Hours Left",diffHour,diffMin];
    
    diffLabel.text = diffLabelText;
    
    NSLog(@"%@", diffLabelText);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:7.0f];
    diffLabel.alpha = 0;
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    [UIView commitAnimations];
    
}

@end

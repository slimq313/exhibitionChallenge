//
//  ECViewController.m
//  Exhibition
//
//  Created by Maarten Billemont on 2017-08-13.
//  Copyright © 2017 Maarten Billemont. All rights reserved.
//

#import "ECViewController.h"
#import "PearlUIUtils.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ECViewController()
@property (nonatomic) AVPlayer *avPlayer;
@property (nonatomic) UIImageView *circleLarge;
@property (nonatomic) UIImageView *circleFloaters;
@property (nonatomic) UIImageView *thumbnail;

@end

@implementation ECViewController


- (void)loadView {

    [super loadView];

    // Frames

    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"ornaments" ofType:@"mp4"];
    NSURL *videoURL = [NSURL fileURLWithPath: videoPath];
    
    self.avPlayer = [AVPlayer playerWithURL: videoURL];
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    videoLayer.frame = self.view.bounds;
    videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.view.layer addSublayer: videoLayer];
    [self.avPlayer play];
    
    UIImageView *frameBottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"frame_bottom"]];
    [self.view addSubview:frameBottomView];
    [frameBottomView setFrameFrom:@"-|>[ ]-|-"];
    
    UIImageView *frameTopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"frame_top"]];
    [self.view addSubview:frameTopView];
    [frameTopView setFrameFrom:@"-|-[ ]<|-"];
    
    UIImageView *frameLeftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"frame_left"]];
    [self.view addSubview:frameLeftView];
    [frameLeftView setFrameFrom:@"-|-[ ]-|<"];
    
    UIImageView *toggleNearmeOff = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toggle_nearme_off"]];
    [self.view addSubview:toggleNearmeOff];
    [toggleNearmeOff setFrameFromSize:CGSizeMake(120.0,70.0) andParentPaddingTop:3.0 right:0.0 bottom:0.0 left:60.0 constrainSize:YES];
    
    UIImageView *toggleNearmeOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toggle_nearme_on"]];
    [self.view addSubview:toggleNearmeOn];
    [toggleNearmeOn setFrameFromSize:CGSizeMake(120.0,70.0) andParentPaddingTop:3.0 right:0.0 bottom:0.0 left:60.0 constrainSize:YES];
    
    UIImageView *toggleListOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toggle_list_on"]];
    [self.view addSubview:toggleListOn];
    [toggleListOn setFrameFromSize:CGSizeMake(120.0,70.0) andParentPaddingTop:3.0 right:0.0 bottom:0.0 left:180.0 constrainSize:YES];
    
    UIImageView *toggleListOff = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toggle_list_off"]];
    [self.view addSubview:toggleListOff];
    [toggleListOff setFrameFromSize:CGSizeMake(120.0,70.0) andParentPaddingTop:3.0 right:0.0 bottom:0.0 left:180.0 constrainSize:YES];
    
    UIImageView *photoCaptainAmerica = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo_captain_america"]];
    photoCaptainAmerica.alpha = 0.10;
    [self.view addSubview:photoCaptainAmerica];
    [photoCaptainAmerica setFrameFromSize:CGSizeMake(300.0,300.0) andParentPaddingTop:200.0 right:50.0 bottom:0.0 left:50.0 constrainSize:YES];
    
    //gray dots
    UIImageView *firstDot = [[UIImageView alloc] initWithFrame: CGRectMake(310, 220, 15, 15)];
    firstDot.backgroundColor = [UIColor whiteColor];
    firstDot.alpha = 0.20;
    [firstDot.layer setCornerRadius: firstDot.frame.size.width/2];
    [firstDot.layer setBorderWidth: 1];
    [firstDot.layer setMasksToBounds: YES];
    [self.view addSubview: firstDot];
    
    UIImageView *sencondDot = [[UIImageView alloc] initWithFrame: CGRectMake(270, 350, 15, 15)];
    sencondDot.backgroundColor = [UIColor whiteColor];
    sencondDot.alpha = 0.20;
    [sencondDot.layer setCornerRadius: sencondDot.frame.size.width/2];
    [sencondDot.layer setBorderWidth: 1];
    [sencondDot.layer setMasksToBounds: YES];
    [self.view addSubview: sencondDot];
    
    UIImageView *thirdDot = [[UIImageView alloc] initWithFrame: CGRectMake(230, 420, 15, 15)];
    thirdDot.backgroundColor = [UIColor whiteColor];
    thirdDot.alpha = 0.20;
    [thirdDot.layer setCornerRadius: thirdDot.frame.size.width/2];
    [thirdDot.layer setBorderWidth: 1];
    [thirdDot.layer setMasksToBounds: YES];
    [self.view addSubview: thirdDot];
    
    UIImageView *fourthDot = [[UIImageView alloc] initWithFrame: CGRectMake(130, 450, 15, 15)];
    fourthDot.backgroundColor = [UIColor whiteColor];
    fourthDot.alpha = 0.20;
    [fourthDot.layer setCornerRadius: fourthDot.frame.size.width/2];
    [fourthDot.layer setBorderWidth: 1];
    [fourthDot.layer setMasksToBounds: YES];
    [self.view addSubview: fourthDot];
    
    UIImageView *fifthDot = [[UIImageView alloc] initWithFrame: CGRectMake(155, 350, 15, 15)];
    fifthDot.backgroundColor = [UIColor whiteColor];
    fifthDot.alpha = 0.20;
    [fifthDot.layer setCornerRadius: fifthDot.frame.size.width/2];
    [fifthDot.layer setBorderWidth: 1];
    [fifthDot.layer setMasksToBounds: YES];
    [self.view addSubview: fifthDot];
    
    //line 1
    UIBezierPath *LineOne = [UIBezierPath bezierPath];
    [LineOne moveToPoint: CGPointMake(firstDot.center.x, firstDot.center.y)];
    [LineOne addLineToPoint: CGPointMake(sencondDot.center.x, sencondDot.center.y)];
    CAShapeLayer *shapeLayerOne = [CAShapeLayer layer];
    shapeLayerOne.path = [LineOne CGPath];
    shapeLayerOne.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayerOne.lineWidth = 1.0;
    shapeLayerOne.opacity = 0.20;
    shapeLayerOne.fillColor = [[UIColor whiteColor] CGColor];
    [self.view.layer addSublayer:shapeLayerOne];
    
    //line 2
    UIBezierPath *LineTwo = [UIBezierPath bezierPath];
    [LineTwo moveToPoint: CGPointMake(sencondDot.center.x, sencondDot.center.y)];
    [LineTwo addLineToPoint: CGPointMake(thirdDot.center.x, thirdDot.center.y)];
    CAShapeLayer *shapeLayerTwo = [CAShapeLayer layer];
    shapeLayerTwo.path = [LineTwo CGPath];
    shapeLayerTwo.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayerTwo.lineWidth = 1.0;
    shapeLayerTwo.opacity = 0.20;
    shapeLayerTwo.fillColor = [[UIColor whiteColor] CGColor];
    
    //line 3
    UIBezierPath *LineThree = [UIBezierPath bezierPath];
    [LineThree moveToPoint: CGPointMake(thirdDot.center.x, thirdDot.center.y)];
    [LineThree addLineToPoint: CGPointMake(fourthDot.center.x, fourthDot.center.y)];
    CAShapeLayer *shapeLayerThree = [CAShapeLayer layer];
    shapeLayerThree.path = [LineThree CGPath];
    shapeLayerThree.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayerThree.lineWidth = 1.0;
    shapeLayerThree.opacity = 0.20;
    shapeLayerThree.fillColor = [[UIColor whiteColor] CGColor];
    
    //line 4
    UIBezierPath *LineFour = [UIBezierPath bezierPath];
    [LineFour moveToPoint: CGPointMake(fourthDot.center.x, fourthDot.center.y)];
    [LineFour addLineToPoint: CGPointMake(fifthDot.center.x, fifthDot.center.y)];
    CAShapeLayer *shapeLayerFour = [CAShapeLayer layer];
    shapeLayerFour.path = [LineFour CGPath];
    shapeLayerFour.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayerFour.lineWidth = 1.0;
    shapeLayerFour.opacity = 0.20;
    shapeLayerFour.fillColor = [[UIColor whiteColor] CGColor];
    
    //line 5
    UIBezierPath *LineFive = [UIBezierPath bezierPath];
    [LineFive moveToPoint: CGPointMake(thirdDot.center.x, thirdDot.center.y)];
    [LineFive addLineToPoint: CGPointMake(fifthDot.center.x, fifthDot.center.y)];
    CAShapeLayer *shapeLayerFive = [CAShapeLayer layer];
    shapeLayerFive.path = [LineFive CGPath];
    shapeLayerFive.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayerFive.lineWidth = 1.0;
    shapeLayerFive.opacity = 0.20;
    shapeLayerFive.fillColor = [[UIColor whiteColor] CGColor];
    
    [self.view.layer addSublayer:shapeLayerOne];
    [self.view.layer addSublayer:shapeLayerTwo];
    [self.view.layer addSublayer:shapeLayerThree];
    [self.view.layer addSublayer:shapeLayerFour];
    [self.view.layer addSublayer:shapeLayerFive];
    
    _circleFloaters = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"circle_floaters"]];
    [self.view addSubview: _circleFloaters];
    _circleFloaters.center = CGPointMake(fourthDot.center.x, fourthDot.center.y);
    
    _thumbnail = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"thumb_ca"]];
    _thumbnail.frame = CGRectMake(0, 0, 130.5, 130.5);
    [_thumbnail.layer setCornerRadius: _thumbnail.frame.size.width/2];
    [_thumbnail.layer setBorderWidth: 0];
    [_thumbnail.layer setMasksToBounds: YES];
    [self.view addSubview: _thumbnail];
    _thumbnail.center = CGPointMake(fourthDot.center.x, fourthDot.center.y);
    
    _circleLarge = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"circle_lrg"]];
    [self.view addSubview: _circleLarge];
    _circleLarge.center = CGPointMake(fourthDot.center.x, fourthDot.center.y);
    
    [self startRotateTimer];
}

- (void) startRotateTimer {
    [NSTimer scheduledTimerWithTimeInterval:40.0f
                                     target:self selector:@selector(startRotateAnimation:) userInfo:nil repeats:YES];
}

- (void) startRotateAnimation:(NSTimer *)timer {
    [self runSpinAnimationOnView:_circleFloaters duration: -20.0 rotations:0 repeat:0];
}

//rotate
- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.byValue = @(M_PI*2);
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = NO;
    rotationAnimation.repeatCount = repeat ? HUGE_VALF : 0;
    [_circleFloaters.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end

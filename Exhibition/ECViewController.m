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
@property (nonatomic) UIImageView *firstDot;
@property (nonatomic) UIImageView *sencondDot;
@property (nonatomic) UIImageView *thirdDot;
@property (nonatomic) UIImageView *fourthDot;
@property (nonatomic) UIImageView *fifthDot;

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
    
    [self setUpUnavailableModes];
    [self setUpLines];
    [self setUpCircularRings];
    [self startRotateTimer];
}

- (void) startRotateTimer {
    [NSTimer scheduledTimerWithTimeInterval:40.0f
                                     target:self selector:@selector(startRotateAnimation:) userInfo:nil repeats:YES];
}

- (void) startRotateAnimation:(NSTimer *)timer {
    [self runSpinAnimationOnView:_circleFloaters duration: -20.0 rotations:0 repeat:0];
}

//rotate circular ring
- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.byValue = @(M_PI*2);
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = NO;
    rotationAnimation.repeatCount = repeat ? HUGE_VALF : 0;
    [_circleFloaters.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

//draw Up dots for unavailable modes
- (void) setUpUnavailableModes {
    //Unavailable modes (gray dots)
    _firstDot = [[UIImageView alloc] initWithFrame: CGRectMake(310, 220, 15, 15)];
    _firstDot.backgroundColor = [UIColor whiteColor];
    _firstDot.alpha = 0.20;
    [_firstDot.layer setCornerRadius: _firstDot.frame.size.width/2];
    [_firstDot.layer setBorderWidth: 1];
    [_firstDot.layer setMasksToBounds: YES];
    [self.view addSubview: _firstDot];
    
    _sencondDot = [[UIImageView alloc] initWithFrame: CGRectMake(270, 350, 15, 15)];
    _sencondDot.backgroundColor = [UIColor whiteColor];
    _sencondDot.alpha = 0.20;
    [_sencondDot.layer setCornerRadius: _sencondDot.frame.size.width/2];
    [_sencondDot.layer setBorderWidth: 1];
    [_sencondDot.layer setMasksToBounds: YES];
    [self.view addSubview: _sencondDot];
    
    _thirdDot = [[UIImageView alloc] initWithFrame: CGRectMake(230, 420, 15, 15)];
    _thirdDot.backgroundColor = [UIColor whiteColor];
    _thirdDot.alpha = 0.20;
    [_thirdDot.layer setCornerRadius: _thirdDot.frame.size.width/2];
    [_thirdDot.layer setBorderWidth: 1];
    [_thirdDot.layer setMasksToBounds: YES];
    [self.view addSubview: _thirdDot];
    
    _fourthDot = [[UIImageView alloc] initWithFrame: CGRectMake(130, 450, 15, 15)];
    _fourthDot.backgroundColor = [UIColor whiteColor];
    _fourthDot.alpha = 0.20;
    [_fourthDot.layer setCornerRadius: _fourthDot.frame.size.width/2];
    [_fourthDot.layer setBorderWidth: 1];
    [_fourthDot.layer setMasksToBounds: YES];
    [self.view addSubview: _fourthDot];
    
    _fifthDot = [[UIImageView alloc] initWithFrame: CGRectMake(155, 350, 15, 15)];
    _fifthDot.backgroundColor = [UIColor whiteColor];
    _fifthDot.alpha = 0.20;
    [_fifthDot.layer setCornerRadius: _fifthDot.frame.size.width/2];
    [_fifthDot.layer setBorderWidth: 1];
    [_fifthDot.layer setMasksToBounds: YES];
    [self.view addSubview: _fifthDot];
}

//draw Up Circular Rings
- (void) setUpCircularRings {
    _circleFloaters = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"circle_floaters"]];
    [self.view addSubview: _circleFloaters];
    _circleFloaters.center = CGPointMake(_fourthDot.center.x, _fourthDot.center.y);
    
    _thumbnail = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"thumb_ca"]];
    _thumbnail.frame = CGRectMake(0, 0, 130.5, 130.5);
    [_thumbnail.layer setCornerRadius: _thumbnail.frame.size.width/2];
    [_thumbnail.layer setBorderWidth: 0];
    [_thumbnail.layer setMasksToBounds: YES];
    [self.view addSubview: _thumbnail];
    _thumbnail.center = CGPointMake(_fourthDot.center.x, _fourthDot.center.y);
    
    _circleLarge = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"circle_lrg"]];
    [self.view addSubview: _circleLarge];
    _circleLarge.center = CGPointMake(_fourthDot.center.x, _fourthDot.center.y);
}

//draw Up connected Lines
- (void) setUpLines {
    
    //line 1
    UIBezierPath *LineOne = [UIBezierPath bezierPath];
    [LineOne moveToPoint: CGPointMake(_firstDot.center.x, _firstDot.center.y)];
    [LineOne addLineToPoint: CGPointMake(_sencondDot.center.x, _sencondDot.center.y)];
    CAShapeLayer *shapeLayerOne = [CAShapeLayer layer];
    shapeLayerOne.path = [LineOne CGPath];
    shapeLayerOne.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayerOne.lineWidth = 1.0;
    shapeLayerOne.opacity = 0.20;
    shapeLayerOne.fillColor = [[UIColor whiteColor] CGColor];
    [self.view.layer addSublayer:shapeLayerOne];
    
    //line 2
    UIBezierPath *LineTwo = [UIBezierPath bezierPath];
    [LineTwo moveToPoint: CGPointMake(_sencondDot.center.x, _sencondDot.center.y)];
    [LineTwo addLineToPoint: CGPointMake(_thirdDot.center.x, _thirdDot.center.y)];
    CAShapeLayer *shapeLayerTwo = [CAShapeLayer layer];
    shapeLayerTwo.path = [LineTwo CGPath];
    shapeLayerTwo.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayerTwo.lineWidth = 1.0;
    shapeLayerTwo.opacity = 0.20;
    shapeLayerTwo.fillColor = [[UIColor whiteColor] CGColor];
    
    //line 3
    UIBezierPath *LineThree = [UIBezierPath bezierPath];
    [LineThree moveToPoint: CGPointMake(_thirdDot.center.x, _thirdDot.center.y)];
    [LineThree addLineToPoint: CGPointMake(_fourthDot.center.x, _fourthDot.center.y)];
    CAShapeLayer *shapeLayerThree = [CAShapeLayer layer];
    shapeLayerThree.path = [LineThree CGPath];
    shapeLayerThree.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayerThree.lineWidth = 1.0;
    shapeLayerThree.opacity = 0.20;
    shapeLayerThree.fillColor = [[UIColor whiteColor] CGColor];
    
    //line 4
    UIBezierPath *LineFour = [UIBezierPath bezierPath];
    [LineFour moveToPoint: CGPointMake(_fourthDot.center.x, _fourthDot.center.y)];
    [LineFour addLineToPoint: CGPointMake(_fifthDot.center.x, _fifthDot.center.y)];
    CAShapeLayer *shapeLayerFour = [CAShapeLayer layer];
    shapeLayerFour.path = [LineFour CGPath];
    shapeLayerFour.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayerFour.lineWidth = 1.0;
    shapeLayerFour.opacity = 0.20;
    shapeLayerFour.fillColor = [[UIColor whiteColor] CGColor];
    
    //line 5
    UIBezierPath *LineFive = [UIBezierPath bezierPath];
    [LineFive moveToPoint: CGPointMake(_thirdDot.center.x, _thirdDot.center.y)];
    [LineFive addLineToPoint: CGPointMake(_fifthDot.center.x, _fifthDot.center.y)];
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
}

@end

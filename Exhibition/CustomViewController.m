//
//  CustomViewController.m
//  ExhibitionChallenge
//
//  Created by CtanLI on 2017-11-15.
//  Copyright © 2017 Maarten Billemont. All rights reserved.
//

#import "CustomViewController.h"
#import "ECViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create an instance of Class1
    ECViewController *class1Instance =  [ECViewController new];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reShuffled)];
    singleTap.numberOfTapsRequired = 1;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reShuffled {
    NSLog(@"single Tap on imageview");
}

@end

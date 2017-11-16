//
//  ECAppDelegate.m
//  Exhibition
//
//  Created by Maarten Billemont on 2017-08-13.
//  Copyright © 2017 Maarten Billemont. All rights reserved.
//

#import "ECAppDelegate.h"
#import "ECViewController.h"

@interface ECAppDelegate()

@end

@implementation ECAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [UIWindow new];
    self.window.rootViewController = [ECViewController new];
    [self.window makeKeyAndVisible];

    return YES;
}

@end

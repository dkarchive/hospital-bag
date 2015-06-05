//
//  AppDelegate.m
//  hospital-bag
//
//  Created by Daniel Khamsing on 6/1/15.
//  Copyright (c) 2015 dkhamsing. All rights reserved.
//

#import "AppDelegate.h"

// Controllers
#import "ListController.h"

// Defines
#import "HBDefines.h"

// Libraries
#import "SloppySwiper.h"

@interface AppDelegate () <UINavigationControllerDelegate>
@property (nonatomic, strong) SloppySwiper *swiper;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont fontWithName:hb_font size:24] };
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    [[UINavigationBar appearance] setTintColor:[UIColor grayColor]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:
                                                    [[ListController alloc] init]
                                                    ];

    self.swiper = [[SloppySwiper alloc] initWithNavigationController:navigationController];
    navigationController.delegate = self.swiper;
    
    [self.window setRootViewController:navigationController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end

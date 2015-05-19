//
//  AppDelegate+RVC.h
//  CallMe
//
//  Created by Martin Ulianko on 19/05/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (RootViewController)

- (void)setRootViewController:(UIViewController *)controller
				   transition:(NSInteger)transition;

- (void)setRootViewControllerWithIdentifier:(NSString *)identifier
							 withTransition:(NSInteger)transition;

@end

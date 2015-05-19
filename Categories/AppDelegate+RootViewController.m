//
//  AppDelegate+RVC.m
//  CallMe
//
//  Created by Martin Ulianko on 19/05/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import "AppDelegate+RootViewController.h"

@implementation AppDelegate (RootViewController)

- (void)setRootViewController:(UIViewController *)controller
				   transition:(NSInteger)transition
{
	[UIView transitionWithView:self.window
					  duration:0.5
					   options:transition
					animations:^{
						BOOL oldState = [UIView areAnimationsEnabled];
						[UIView setAnimationsEnabled:NO];
						self.window.rootViewController = controller;
						[UIView setAnimationsEnabled:oldState];
					}
					completion:^(BOOL finished) {
					}];
}

- (void)setRootViewControllerWithIdentifier:(NSString *)identifier
							 withTransition:(NSInteger)transition
{
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:identifier];
	
	[self setRootViewController:vc transition:transition];
}

@end

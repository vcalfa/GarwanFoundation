//
//  Macros.h
//
//  Created by Róbert Sabol on 11/11/14.
//  Copyright (c) 2014 Garwan Consulting. All rights reserved.
//
#define ApplicationDelegate     ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define ApplicationVersion [NSString stringWithFormat:@"%@.%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]
#define iOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_SIZE  [[UIScreen mainScreen] bounds].size
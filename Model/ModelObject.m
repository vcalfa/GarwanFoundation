//
//  ModelObject.m
//  Breweria
//
//  Created by Martin Ulianko on 02/02/15.
//  Copyright (c) 2015 Martin Ulianko. All rights reserved.
//

#import "ModelObject.h"

@implementation ModelObject

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	return nil;
}

+ (NSDateFormatter *)dateFormatter
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";

	return dateFormatter;
}
@end

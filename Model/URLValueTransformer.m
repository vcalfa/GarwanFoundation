//
//  URLValueTransformer.m
//  CallMe
//
//  Created by Martin Ulianko on 17/03/15.
//  Copyright (c) 2015 Garwan Consulting. All rights reserved.
//

#import "URLValueTransformer.h"

@implementation URLValueTransformer

+ (NSValueTransformer *)URLValueTransformer
{
	return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *url) {
		return url ? [NSURL URLWithString:url] : nil;
	} reverseBlock:^id(NSURL *url) {
		return [url absoluteString];
	}];
}

@end

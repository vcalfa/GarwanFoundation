//
//  ModelObject.h
//  Breweria
//
//  Created by Martin Ulianko on 02/02/15.
//  Copyright (c) 2015 Martin Ulianko. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ModelObject : MTLModel <MTLJSONSerializing>

+ (NSDateFormatter *)dateFormatter;
@end

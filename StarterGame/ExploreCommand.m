//
//  ExploreCommand.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/8/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "ExploreCommand.h"

@implementation ExploreCommand

-(id)init
{
    self = [super init];
    if (nil != self) {
        name = @"explore";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    [player exploreRoom];
    return NO;
}

@end

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
        [self setHelp:@"looks around the room and tells you what items are there"];
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    [player exploreRoom];
    return NO;
}

@end

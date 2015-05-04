//
//  EatCommand.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/26/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "EatCommand.h"

@implementation EatCommand
-(id)init
{
    self = [super init];
    if (nil != self) {
        name = @"eat";
        [self setHelp:@"consumes food from the player's inventory and increases health"];
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    if ([self hasSecondWord]) {
        [player eat:secondWord];
    }
    else {
        [player warningMessage:@"\nEat what?"];
    }
    return NO;
}
@end

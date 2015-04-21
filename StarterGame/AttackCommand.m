//
//  AttackCommand.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/21/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "AttackCommand.h"
#import "Command.h"

@implementation AttackCommand

-(id)init
{
    self = [super init];
    if (nil != self) {
        name = @"attack";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    if ([self hasSecondWord]) {
        [player attack:secondWord];
    }
    else {
        [player warningMessage:@"\nAttack who?"];
    }
    return NO;
}

@end

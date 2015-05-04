//
//  UnequipCommand.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/21/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "UnequipCommand.h"

@implementation UnequipCommand
-(id)init
{
    self = [super init];
    if (nil != self) {
        name = @"unequip";
        [self setHelp:@"unequips a weapon from the player's inventory"];
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    if ([self hasSecondWord]) {
        [player unEquip:secondWord];
    }
    else {
        [player warningMessage:@"\nUnequip what?"];
    }
    return NO;
}
@end

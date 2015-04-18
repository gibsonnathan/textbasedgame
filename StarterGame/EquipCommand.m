//
//  EquipCommand.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/16/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "EquipCommand.h"

@implementation EquipCommand

-(id)init
{
    self = [super init];
    if (nil != self) {
        name = @"equip";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    if ([self hasSecondWord]) {
        [player equipWeapon: secondWord];
    }
    else {
        [player warningMessage:@"\nequip what?"];
    }
    return NO;
}


@end

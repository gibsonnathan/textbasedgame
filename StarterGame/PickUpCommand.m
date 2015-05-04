//
//  PickUpCommand.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/9/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "PickUpCommand.h"

@implementation PickUpCommand

-(id)init
{
    self = [super init];
    if (nil != self) {
        name = @"pickup";
        [self setHelp:@"take an item from a room and adds it to your inventory"];
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    if ([self hasSecondWord]) {
        [player pickUp: secondWord];
    }
    else {
        [player warningMessage:@"\npickup what?"];
    }
    return NO;
}

@end

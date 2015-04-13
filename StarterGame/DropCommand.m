//
//  DropCommand.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/9/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "DropCommand.h"

@implementation DropCommand

-(id)init
{
    self = [super init];
    if (nil != self) {
        name = @"drop";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    if ([self hasSecondWord]) {
        [player dropItem:secondWord];
    }
    else {
        [player warningMessage:@"\nDrop what?"];
    }
    return NO;
}

@end

//
//  ExitsCommand.m
//  StarterGame
//
//  Created by Nathan Gibson on 5/3/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "ExitsCommand.h"

@implementation ExitsCommand

-(id)init
{
    self = [super init];
    if (nil != self) {
        name = @"exits";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    [player outputMessage:[NSString stringWithFormat:@"\n%@",[[player currentRoom] getExits]]];
    return NO;
}
@end

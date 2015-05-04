//
//  StatCommand.m
//  StarterGame
//
//  Created by Nathan Gibson on 5/3/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "StatCommand.h"

@implementation StatCommand

-(id)init
{
    self = [super init];
    if (nil != self) {
        name = @"stats";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    [player stats];
    
    return NO;
}
@end

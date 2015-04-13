//
//  BackCommand.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/9/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "BackCommand.h"

@implementation BackCommand


-(id)init
{
    self = [super init];
    if (nil != self) {
        name = @"back";
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    [player goBack];
    return NO;
}

@end

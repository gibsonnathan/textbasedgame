//
//  GameIOManager.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/18/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "GameIOManager.h"
#import "GameIO.h"
@implementation GameIOManager

+(id)sharedInstance: (NSTextView*) output{
    static GameIO* io = nil;
    if (!io) {
        io = [[GameIO alloc]initWithOutput:output];
    }
    return io;
}

+(id)sharedInstance{
    return [self sharedInstance:nil];
}
@end

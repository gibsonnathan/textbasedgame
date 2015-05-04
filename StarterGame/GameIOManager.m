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

/*
    Checks to see if there is already an instance
    of GameIO, if there is it returns it, otherwise
    it creates one and returns it
 */
+(id)sharedInstance: (NSTextView*) output{
    static GameIO* io;
    if (!io) {
        io = [[GameIO alloc]initWithOutput:output];
    }
    return io;
}

+(id)sharedInstance{
    return [self sharedInstance:nil];
}

@end

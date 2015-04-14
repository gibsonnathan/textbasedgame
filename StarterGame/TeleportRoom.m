//
//  TeleportRoom.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/13/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "TeleportRoom.h"

@implementation TeleportRoom

@synthesize delegate;
@synthesize tag;

-(id)init
{
    return [self initWithTag:@"No Tag"];
}

-(id)initWithTag:(NSString *)newTag
{
    self = [super init];
    
    if (nil != self) {
        [self setTag:newTag];
        exits = [[NSMutableDictionary alloc] initWithCapacity:10];
        previousLocations = [[NSMutableSet alloc] init];
        [self setDelegate:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLocation:) name:@"PlayerHasWalked" object:nil];
    }
    return self;
}

-(void)addLocation:(NSNotification*)notification{
    [previousLocations addObject:[notification object]];
    NSLog(@"\nlocation added");
}

-(void)setExit:(NSString *)exit toRoom:(Room *)room
{
    if(delegate){
        [exits setObject:room forKey:exit];
    }else{
        [exits setObject:room forKey:exit];
    }
}

-(Room *)getExit:(NSString *)exit
{
    if(delegate){
        return [exits objectForKey:exit];
    }else{
        return [exits objectForKey:exit];
    }
}

-(NSString *)getExits
{
    if(delegate){
        NSArray *exitNames = [exits allKeys];
        return [NSString stringWithFormat:@"Exits: %@", [exitNames componentsJoinedByString:@" "]];
    }else{
        NSArray *exitNames = [exits allKeys];
        return [NSString stringWithFormat:@"Exits: %@", [exitNames componentsJoinedByString:@" "]];
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"You are %@.\n *** %@", tag, [self getExits]];
}

-(void)dealloc
{
    [tag release];
    [exits release];
    [super dealloc];
}
@end

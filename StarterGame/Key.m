//
//  Key.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/13/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Key.h"
@implementation Key

-(id)init{
    return [self initWithName:@"key" andUnlocks:nil];
}

-(id)initWithName:(NSString*)newName andUnlocks:(Room*)newRoom{
    self = [super init];
    if (self) {
        name = newName;
        unlocks = newRoom;
    }
    return self;
}

-(int)weight{
    return 2;
}

-(BOOL)canPickup{
    return YES;
}

-(Room*)unlocks{
    return unlocks;
}

-(void)dealloc{
    [name release];
    [super dealloc];
}


@end

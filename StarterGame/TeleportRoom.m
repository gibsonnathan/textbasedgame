//
//  TeleportRoom.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/13/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "TeleportRoom.h"
#import "Room.h"

@implementation TeleportRoom

-(id)init{
    return [self initWithTag:@"No Tag" andName:@"Room" andLocked:NO];
}

-(id)initWithTag:(NSString *)newTag andName:(NSString*)newName andLocked:(BOOL)newLocked{
    self = [super initWithTag:newTag andName:newName andLocked:newLocked];
    if (nil != self) {
        previousLocations = [[NSMutableArray alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLocation:) name:@"PlayerHasWalked" object:nil];
    }
    return self;
}

-(void)addLocation:(NSNotification*)notification{
    if (![previousLocations containsObject:[notification object]] && ![[notification object] isEqualTo:self]) {
        [previousLocations addObject:[notification object]];
    }
}

-(Room*)getExit:(NSString *)exit{
    if ([exit isNotEqualTo:@"outside"]) {
        return nil;
    }else{
        if ([previousLocations count] > 0) {
            NSInteger randomValue = arc4random_uniform((int)[previousLocations count]);
            Room* temp = [previousLocations objectAtIndex: randomValue];
            return temp;
        }
    }
    return nil;
}

-(NSString *)getExits{
    return [NSString stringWithFormat:@"outside"];
}

-(void)dealloc{
    [previousLocations release];
    [super dealloc];
}
@end

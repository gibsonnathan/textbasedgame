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
/*
    receives the notification that the player has moved to a new rooms, takes
    the rooms and adds it to the previousLocations list, first making sure that it
    is not already there
 */
-(void)addLocation:(NSNotification*)notification{
    if (![previousLocations containsObject:[notification object]] && ![[notification object] isEqualTo:self]) {
        [previousLocations addObject:[notification object]];
    }
}
/*
    picks an exit by looking at the previous locations list, picking a random
    location and returns it
 */
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
/*
 overrides the default behavior of room and only allows the player one exit
 */
-(NSString *)getExits{
    return [NSString stringWithFormat:@"outside"];
}

-(void)dealloc{
    [previousLocations release];
    [super dealloc];
}
@end

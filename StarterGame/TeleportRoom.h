//
//  TeleportRoom.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/13/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//
//  A more specific type of room that stores locations previously
//  visited by the player. When the player exits the room he exits
//  to a random room that he has previously been to.
//

#import <Foundation/Foundation.h>
#import "Room.h"

@interface TeleportRoom : Room{
    NSMutableArray* previousLocations;
}


@end
//
//  Key.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/13/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//
//  A more specific type of item that has the property of being
//  able to unlock a certain room
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
#import "Room.h"

@interface Key : Item{
    Room* unlocks;
}

-(id)initWithName:(NSString*)newName andUnlocks:(Room*)newRoom;

@end

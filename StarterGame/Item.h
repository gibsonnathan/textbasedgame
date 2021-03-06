//
//  Item.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/8/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//
//  A generic item that has a name, weight, and a boolean value that describes whether or not
//  it can be picked up
//

#import <Foundation/Foundation.h>
#import "Room.h"

@class Room;

@interface Item : NSObject{
    NSString* name;
    int weight;
    BOOL canPickup;
}

-(id)initWithName:(NSString*)newName andWeight:(int)newWeight andCanPickup:(BOOL)newCanPickup;
-(NSString*)name;
-(int)weight;
-(BOOL)canPickup;
-(int)damage;
-(int)nutrition;
-(Room*)unlocks;

@end

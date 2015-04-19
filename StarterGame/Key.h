//
//  Key.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/13/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "Room.h"
#import "Protocols.h"
@interface Key : NSObject  <Item>{
    
}

@property (retain, nonatomic)NSString* name;
@property (nonatomic)int weight;
@property (nonatomic)BOOL canPickup;
@property (nonatomic, retain)id<Room> unlocks;

-(id)init;
-(id)initWithName:(NSString*)newName;
-(id)initWithName:(NSString*)newName andWeight:(int)newWeight;
-(id)initWithName:(NSString*)newName andWeight:(int)newWeight andCanPickup:(BOOL)pickup;
-(id)initWithName:(NSString*)newName andWeight:(int)newWeight andCanPickup:(BOOL)pickup andUnlocks:(id<Room>)newRoom;




@end

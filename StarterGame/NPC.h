//
//  NPC.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/18/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
#import "NPC.h"

@interface NPC : NSObject <NPC>{
    
}

@property(nonatomic, retain)id<Player> delegate;
@property(nonatomic, retain)NSString* name;

-(id)initWithRoom:(id<Room>)newRoom andName:(NSString*)newName;
-(id<Room>)currentRoom;
-(void)talkToPlayer:(NSString*)message;
-(void)walk;
-(void)addToInventory:(id<Item>)item;
-(void)dropItems;

@end

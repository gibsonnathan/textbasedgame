//
//  NPC.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/18/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Player.h"
#import "Protocols.h"
@interface NPC : NSObject <NPC>{
    NSTimer* moveTimer;
    BOOL moving;
}

@property(nonatomic, retain)Player* delegate;

-(id)initWithRoom:(id<Room>)room;
-(void)encounteredPlayer:(NSNotification*)notification;
-(void)talkToPlayer:(NSString*)message;
-(void)stopWalking;
-(void)walk;
-(void)addToInventory:(id<Item>)item;
-(void)dropItem:(NSString*)item;
-(void)attack:(int)amount;

@end

//
//  NPC.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/18/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
#import "Room.h"
#import "Player.h"

@interface NPC : Player{
    
}

@property(nonatomic, retain)NSString* name;

-(id)initWithRoom:(Room*)newRoom andName:(NSString*)newName;
-(void)talkToPlayer:(NSString*)message;
-(void)walk;


@end

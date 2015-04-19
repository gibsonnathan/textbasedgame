//
//  NPC.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/18/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Player.h"

@interface NPC : Player{
    NSTimer* moveTimer;
}

-(id)initWithRoom:(id<Room>)room andHealth:(int)newHealth;
-(void)walk;
-(void)talkToPlayer;
-(void)talk;

@end

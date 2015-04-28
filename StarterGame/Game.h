//  ***
//
//  Game.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 7/14/14.
//  Copyright 2014 Columbus State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Parser.h"
#import "Player.h"
#import "GameIO.h"
#import "NPC.h"


@interface Game : NSObject {
    BOOL playing;
}

@property (retain, nonatomic)Parser *parser;
@property (retain, nonatomic)Player *player;

-(id)initWithGameIO:(GameIO*)theIO;
-(id<Room>)createWorld;
-(void)playerHasBeenDefeated:(NSNotification*)notificiation;
-(void)playerEncounteredNPC:(NSNotification*)notification;
-(void)NPCEncounteredPlayer:(NSNotification*)notification;
-(void)start;
-(void)end;
-(BOOL)execute:(NSString*)commandString;
-(NSString*)welcome;
-(NSString*)goodbye;

@end

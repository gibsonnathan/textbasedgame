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



@interface Game : NSObject {
    BOOL playing;
}

@property (retain, nonatomic)Parser *parser;
@property (retain, nonatomic)Player *player;

-(id)initWithGameIO:(GameIO *)theIO;
-(Room *)createWorld;
-(void)start;
-(void)end;
-(BOOL)execute:(NSString *)commandString;
-(NSString *)welcome;
-(NSString *)goodbye;
-(void)playerHasWalked:(NSNotification*) notification;
@end

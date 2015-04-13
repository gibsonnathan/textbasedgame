//
//  Character.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/13/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
#import "Room.h"
#import "GameIO.h"
@interface Character : NSObject <Character>{
    NSMutableDictionary* inventory;
}

@property (retain, nonatomic)id<Character> delegate;
@property (retain, nonatomic)Room *currentRoom;
@property (retain, nonatomic)GameIO *io;

-(id)init;
-(id)initWithRoom:(Room *)room andIO:(GameIO *)theIO;
-(void)walkTo:(NSString *)direction;
-(void)outputMessage:(NSString *)message;
-(void)outputMessage:(NSString *)message withColor:(NSColor *)color;
-(void)warningMessage:(NSString *)message;
-(void)errorMessage:(NSString *)message;
-(void)commandMessage:(NSString *)message;
-(void)addToInventory:(Item*) item;
-(void)dropItem:(NSString*) item;

@end

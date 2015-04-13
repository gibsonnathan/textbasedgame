//  ***
//
//  Player.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 7/14/14.
//  Copyright 2014 Columbus State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Room.h"
#import "GameIO.h"
#import "Item.h"

@interface Player : NSObject{
    NSMutableArray* previousLocations;
    NSMutableDictionary* inventory;
    int currentWeight;
    int maxWeight;
}

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
-(void)exploreRoom;
-(void)pickUp:(NSString*) item;
-(void)searchInventory;
-(void)dropItem:(NSString*) item;
-(void)goBack;
@end

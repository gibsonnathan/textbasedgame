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
#import "Protocols.h"
#import "Weapon.h"
#import "Armor.h"

@interface Player : NSObject{
    NSMutableArray* previousLocations;
    NSMutableArray* visitedRooms;
    NSMutableDictionary* inventory;
    int currentWeight;
    int maxWeight;
    int health;
    int strength;
    id<Item>weapon;
}

@property (nonatomic, retain)id<Room> currentRoom;
@property (nonatomic, retain)GameIO* io;

-(id)init;
-(id)initWithRoom:(id<Room>)room;
-(void)unEquip:(NSString*)newWeapon;
-(void)equip:(NSString*)newWeapon;
-(void)attack:(NSString*)NPC;
-(void)haveBeenAttacked:(NSNotification*)notification;
-(void)walkTo:(NSString*)direction;
-(BOOL)canVisit:(id<Room>)room;
-(void)outputMessage:(NSString*)message;
-(void)outputMessage:(NSString*)message withColor:(NSColor*)color;
-(void)warningMessage:(NSString*)message;
-(void)errorMessage:(NSString*)message;
-(void)commandMessage:(NSString*)message;
-(void)addToInventory:(id<Item>)item;
-(NSArray*)inventoryKeys;
-(void)exploreRoom;
-(void)pickUp:(NSString*)item;
-(void)searchInventory;
-(void)dropItem:(NSString*)item;
-(void)goBack;

@end

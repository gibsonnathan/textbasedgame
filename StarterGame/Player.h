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
#import "Protocols.h"
#import "Weapon.h"

@interface Player : NSObject{
    NSMutableArray* previousLocations;
    NSMutableDictionary* inventory;
    int currentWeight;
    int maxWeight;
    int health;
    int strength;
    Weapon* weapon;
    int maxHealth;
    BOOL alive;
}

@property (nonatomic, retain)Room* currentRoom;
@property (nonatomic, retain)GameIO* io;

-(id)init;
-(id)initWithRoom:(Room*)room;
-(id)initWithoutNotifications:(Room*)room;
-(NSMutableDictionary*)inventory;
-(void)eat:(NSString*)food;
-(void)unEquip:(NSString*)newWeapon;
-(void)equip:(NSString*)newWeapon;
-(void)attackNPC:(NSString*)NPC;
-(void)playerHasBeenAttacked:(NSNotification*)notification;
-(void)walkTo:(NSString*)direction;
-(BOOL)canVisit:(Room*)room;
-(void)outputMessage:(NSString*)message;
-(void)outputMessage:(NSString*)message withColor:(NSColor*)color;
-(void)warningMessage:(NSString*)message;
-(void)errorMessage:(NSString*)message;
-(void)commandMessage:(NSString*)message;
-(void)addToInventory:(Item*)item;
-(NSArray*)inventoryKeys;
-(void)exploreRoom;
-(void)pickUp:(NSString*)item;
-(void)searchInventory;
-(void)dropItem:(NSString*)item;
-(void)goBack;

@end

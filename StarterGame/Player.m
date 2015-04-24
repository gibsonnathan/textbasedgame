//  ***
//
//  Player.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 7/14/14.
//  Copyright 2014 Columbus State University. All rights reserved.
//

#import "Player.h"
#import "Key.h"
#import "GameIOManager.h"
@implementation Player


@synthesize currentRoom;
@synthesize io;

-(id)init
{
	return [self initWithRoom:nil];
}

-(id)initWithRoom:(id<Room>)room
{
	self = [super init];
    
	if (nil != self) {
		[self setCurrentRoom:room];
        [self setIo:[GameIOManager sharedInstance]];
        inventory = [[NSMutableDictionary alloc]init];
        previousLocations = [[NSMutableArray alloc]init];
        visitedRooms = [[NSMutableArray alloc]init];
        currentWeight = 0;
        maxWeight = 10;
        health = 100;
        strength = 100;
        weapon = nil;
    }
	return self;
}

-(void)equip:(NSString*)newWeapon{
    id<Item> temp = [inventory objectForKey:newWeapon];
    if(temp){
        weapon = temp;
        [inventory removeObjectForKey:[temp name]];
    }else{
        [self warningMessage:[NSString stringWithFormat:@"\nCannot equip %@", newWeapon]];
    }
}

-(void)unEquip:(NSString*)newWeapon{
    if (weapon) {
        if ([newWeapon isEqualTo:[weapon name]]) {
            [inventory setObject:weapon forKey:newWeapon];
            weapon = nil;
        }
        else{
            [self warningMessage:[NSString stringWithFormat:@"\n%@ not equipped", newWeapon]];
        }
    }else{
        [self warningMessage:[NSString stringWithFormat:@"\nNo weapon equipped"]];
    }
}

-(void)attack:(NSString*)NPC{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerHasAttackedNPC" object:nil];
}

-(void)haveBeenAttacked:(NSNotification*)notification{
    
}

-(void)goBack{
    id<Room> lastRoom = [previousLocations lastObject];
    if(lastRoom){
        [previousLocations removeLastObject];
        currentRoom = lastRoom;
        [self outputMessage:[NSString stringWithFormat:@"\n%@",[currentRoom description]]];
    }else{
        [self warningMessage: @"\nNo more previous locations"];
    }
}

-(void)dropItem:(NSString*) item{
    id<Item> temp = [inventory objectForKey:item];
    if(temp){
        [inventory removeObjectForKey:item];
        [currentRoom addToItems:temp];
        currentWeight -= [temp weight];
    }else{
        [self warningMessage:[NSString stringWithFormat:@"\nCannot find %@", item]];
    }
}

-(void)searchInventory{
    if([[inventory allKeys] count] > 0){
        NSString* header = @"\nItems in inventory:";
        NSString* temp = @"";
        for (int i = 0; i < [[inventory allKeys] count]; i++) {
            temp = [NSString stringWithFormat:@"%@, %@", temp, [[inventory allKeys] objectAtIndex:i]];
        }
        temp = [temp substringFromIndex:1];
        NSString* final = [NSString stringWithFormat:@"%@ %@\n%d/%d", header, temp, currentWeight, maxWeight];
        [self outputMessage:final];
    }else{
        [self outputMessage:@"\nEmpty Inventory"];
    }
}

-(void)pickUp:(NSString*) item{
    Item* temp = [currentRoom itemForKey:item];
    if(temp){
        if([temp canPickup]){
            if(currentWeight + [temp weight] <= maxWeight){
                [inventory setObject:[currentRoom itemForKey:item] forKey:item];
                currentWeight += [[currentRoom itemForKey:item] weight];
                [currentRoom removeFromItems:item];
            }else{
                [self warningMessage:[NSString stringWithFormat:@"\nYour inventory is too full to pickup %@", item]];
            }
        }else{
            [self warningMessage:[NSString stringWithFormat:@"\n%@ is not an item you can pickup", item]];
        }
    }else{
        [self warningMessage:[NSString stringWithFormat:@"\nCannot find %@", item]];
    }
}

-(void) exploreRoom{
    NSArray *items = [currentRoom items];
    if([items count] > 0){
        NSString* header = @"\nItems in room:";
        NSString* temp = @"";
        for (int i = 0; i < [items count]; i++) {
            temp = [NSString stringWithFormat:@"%@, %@", temp, [items objectAtIndex:i]];
        }
        temp = [temp substringFromIndex:1];
        NSString* final = [NSString stringWithFormat:@"%@ %@", header, temp];
        [self outputMessage:final];
    }else{
        [self outputMessage:@"\nEmpty Room"];
    }
}

-(BOOL)canVisit:(id<Room>) room{
    if([room isLocked] == NO){
        return YES;
    }else{
        for (id<Item> x in [inventory allValues]) {
            if ([x isKindOfClass:[Key class]]) {
                if ([[(Key*)x unlocks] isEqual:room]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

-(void)walkTo:(NSString *)direction
{
	Room *nextRoom = [currentRoom getExit:direction];
	if (nextRoom) {
        if([self canVisit:nextRoom]){
            [previousLocations addObject:currentRoom];
            [visitedRooms addObject:currentRoom];
            [self setCurrentRoom:nextRoom];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerHasWalked" object:currentRoom];
            NSLog(@"\nPlayer is in %@", [currentRoom name]);
            if ([currentRoom isLocked] == YES) {
                [currentRoom setIsLocked: NO];
            }
            [self outputMessage:[NSString stringWithFormat:@"\n%@", nextRoom]];
        }else{
            [self warningMessage:@"\nDoor is locked"];
        }
    }
	else {
        [self errorMessage:[NSString stringWithFormat:@"\nThere is no door on %@!", direction]];
	}
}

-(void)outputMessage:(NSString *)message
{
    [io sendLines:message];
}

-(void)outputMessage:(NSString *)message withColor:(NSColor *)color
{
    NSColor *lastColor = [io currentColor];
    [io setCurrentColor:color];
    [self outputMessage:message];
    [io setCurrentColor:lastColor];
}

-(void)errorMessage:(NSString *)message
{
    [self outputMessage: message withColor:[NSColor redColor]];
}

-(void)warningMessage:(NSString *)message
{
    [self outputMessage: message withColor:[NSColor orangeColor]];
}

-(void)commandMessage:(NSString *)message
{
    [self outputMessage: message withColor:[NSColor brownColor]];
}

-(void)addToInventory:(Item*) newItem{
    [inventory setObject: newItem forKey: [newItem name]];
}

-(NSArray*)inventoryKeys{
    return [inventory allKeys];
}

-(void)dealloc
{
	[currentRoom release];
    [io release];
	
	[super dealloc];
}

@end

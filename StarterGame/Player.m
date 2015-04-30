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
#import "Food.h"
@implementation Player


@synthesize currentRoom;
@synthesize io;

-(id)init
{
	return [self initWithRoom:nil];
}

-(id)initWithRoom:(Room*)room
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
        maxHealth = 100;
        health = 100;
        strength = 10;
        alive = YES;
        weapon = nil;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerHasBeenAttacked:) name:@"NPCAttackedPlayer" object:nil];
    }
	return self;
}

-(id)initWithoutNotifications:(Room*)room
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
        maxHealth = 100;
        health = 100;
        strength = 100;
        weapon = nil;
       
    }
    return self;
}

-(void)eat:(NSString*)food{
    Item* temp = [inventory objectForKey:food];
    if(temp && [temp isKindOfClass:[Food class]]){
        if (health + [temp nutrition] > maxHealth) {
            health = maxHealth;
        }else{
            health += [temp nutrition];
        }
        [inventory removeObjectForKey:food];
        currentWeight -= [temp weight];
        NSString* output = [NSString stringWithFormat:@"\nPlayer health %d", health];
        [self outputMessage:output];
    }else{
        [self warningMessage:[NSString stringWithFormat:@"\nCannot eat %@", food]];
    }
}

-(void)equip:(NSString*)newWeapon{
    Weapon* temp = [inventory objectForKey:newWeapon];
    if(temp && [temp isKindOfClass:[Weapon class]]){
        weapon = temp;
        NSString* output = [NSString stringWithFormat:@"\nPlayer's currently equipped weapon: %@", [weapon name]];
        [self outputMessage:output];
    }else{
        [self warningMessage:[NSString stringWithFormat:@"\nCannot equip %@", newWeapon]];
    }
}

-(void)unEquip:(NSString*)newWeapon{
    if (weapon) {
        if ([newWeapon isEqualTo:[weapon name]]) {
            weapon = nil;
            NSString* output = [NSString stringWithFormat:@"\nPlayer's currently equipped weapon: none"];
            [self outputMessage:output];
        }
        else{
            [self warningMessage:[NSString stringWithFormat:@"\n%@ not equipped", newWeapon]];
        }
    }else{
        [self warningMessage:[NSString stringWithFormat:@"\nNo weapon equipped"]];
    }
}

-(void)attackNPC:(NSString*)NPC{
    NSNumber* attack = [[[NSNumber alloc]initWithInt: weapon ? arc4random() % (strength + [weapon damage]) : arc4random() % (strength)] autorelease];
    NSDictionary* data = [[NSDictionary alloc]initWithObjectsAndKeys:attack, @"attack", NPC, @"name", currentRoom, @"room", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PlayerHasAttackedNPC" object:nil userInfo:data];
}

-(void)playerHasBeenAttacked:(NSNotification*)notification{
    NSDictionary* data = [notification userInfo];
    NSNumber* attack = [data objectForKey:@"attack"];
    Room* room = [data objectForKey:@"room"];
    NSString* name = [data objectForKey:@"name"];
    if ([currentRoom isEqual:room] && alive) {
        if (health - [attack intValue] > 0) {
            health -= [attack intValue];
            NSString* output = [NSString stringWithFormat:@"\nPlayer attacked by %@! Health:%d",name, health];
            [self outputMessage:output withColor:[NSColor redColor]];
        }else{
            [self defeated];
        }
    }
}

-(void)defeated{
    if (alive) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PlayerHasBeenDefeated" object:nil];
    }
    alive = NO;
    
}

-(void)goBack{
    Room* lastRoom = [previousLocations lastObject];
    if(lastRoom){
        [previousLocations removeLastObject];
        currentRoom = lastRoom;
        [self outputMessage:[NSString stringWithFormat:@"\n%@",[currentRoom description]]];
    }else{
        [self warningMessage: @"\nNo more previous locations"];
    }
}

-(NSMutableDictionary*)inventory{
    return inventory;
}

-(void)dropItem:(NSString*) item{
    Item* temp = [[inventory objectForKey:item] retain];
    if(temp){
        if ([temp isEqual:weapon]) {
            [self warningMessage:@"\nCannot drop equipped weapon"];
        }else{
            [inventory removeObjectForKey:item];
            [currentRoom addToItems:temp];
            currentWeight -= [temp weight];
        }
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

-(BOOL)canVisit:(Room*) room{
    if([room isLocked] == NO){
        return YES;
    }else{
        for (Item* x in [inventory allValues]) {
            if ([[x unlocks] isEqual:room]) {
                return YES;
            }
        }
    }
    return NO;
}

-(void)walkTo:(NSString *)direction
{
	Room* nextRoom = [currentRoom getExit:direction];
	if (nextRoom) {
        if([self canVisit:nextRoom]){
            [previousLocations addObject:currentRoom];
            [visitedRooms addObject:currentRoom];
            [self setCurrentRoom:nextRoom];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerHasWalked" object:currentRoom];
            NSLog(@"\nPlayer is in %@", [currentRoom name]);
            if ([currentRoom isLocked] == YES) {
                [currentRoom unlock];
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
    [weapon release];
    [inventory release];
    [visitedRooms release];
    [previousLocations release];
	
	[super dealloc];
}

@end

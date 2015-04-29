//  ***
//
//  Game.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 7/14/14.
//  Copyright 2014 Columbus State University. All rights reserved.
//

#import "Game.h"
#import "Item.h"
#import "Key.h"
#import "TeleportRoom.h"
#import "GameIOManager.h"
#import "Alien.h"
#import "Food.h"

@implementation Game

@synthesize parser;
@synthesize player;


-(id)initWithGameIO:(GameIO *)theIO
{
	self = [super init];
	if (nil != self) {
		[self setParser:[[[Parser alloc] init] autorelease]];
		[self setPlayer:[[[Player alloc] initWithRoom:[self createWorld]] autorelease]];
        playing = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerEncounteredNPC:) name:@"PlayerHasWalked" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NPCEncounteredPlayer:) name:@"NPCHasWalked" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerHasBeenDefeated:) name:@"PlayerHasBeenDefeated" object:nil];
        
    }
	return self;
}

-(void)playerHasBeenDefeated:(NSNotification*)notificiation{
    [self end];
}

-(void)playerEncounteredNPC:(NSNotification*)notification{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NPCEncounteredByPlayer" object:[notification object]];
}

-(void)NPCEncounteredPlayer:(NSNotification*)notification{
    NSDictionary* data = [notification userInfo];
    NSString* name = [data objectForKey:@"name"];
    id<Room> room = [data objectForKey:@"room"];
    if ([room isEqual:[player currentRoom]]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PlayerEncounteredByNPC" object:name];
    }
}
-(Room *)createWorld
{
    
    
    id<Room> armory, crewCabin, teleport, hallway, probeRoom, library, gym, navigationRoom, scienceLab, greenHouse;
    
    
    armory = [[[Room alloc] initWithTag:@"in the armory room" andName:@"armory" andLocked:NO] autorelease];
    crewCabin = [[[Room alloc] initWithTag:@"in the crew cabin" andName:@"crew cabin" andLocked:NO] autorelease];
    teleport = [[[TeleportRoom alloc] initWithTag:@"in the teleport room" andName:@"teleport" andLocked:NO] autorelease];
    hallway = [[[Room alloc] initWithTag:@"in the hallway" andName:@"hallway" andLocked:NO] autorelease];
    probeRoom = [[[Room alloc] initWithTag:@"in the probe room" andName:@"probe room" andLocked:NO] autorelease];
    library = [[[Room alloc] initWithTag:@"in the library" andName:@"library" andLocked:NO] autorelease];
    gym = [[[Room alloc] initWithTag:@"in the gym" andName:@"gym" andLocked:NO] autorelease];
    navigationRoom = [[[Room alloc] initWithTag:@"in the navigation room" andName:@"navigation room" andLocked:YES] autorelease];
    scienceLab = [[[Room alloc] initWithTag:@"in the science lab" andName:@"science lab" andLocked:NO] autorelease];
    greenHouse = [[[Room alloc] initWithTag:@"in the green house" andName:@"green house" andLocked:NO] autorelease];
    
    [probeRoom setExit:@"east" toRoom:hallway];
    
    [hallway setExit:@"north" toRoom:crewCabin];
    [hallway setExit:@"south" toRoom:library];
    [hallway setExit:@"east" toRoom:scienceLab];
    [hallway setExit:@"west" toRoom:probeRoom];
    
    [library setExit:@"north" toRoom:hallway];
    
    [crewCabin setExit:@"north" toRoom:armory];
    [crewCabin setExit:@"east" toRoom:teleport];
    [crewCabin setExit:@"south" toRoom:hallway];
    
    [armory setExit:@"south" toRoom:crewCabin];
    
    [teleport setExit:@"west" toRoom:crewCabin];
    
    [scienceLab setExit:@"north" toRoom:navigationRoom];
    [scienceLab setExit:@"west" toRoom:hallway];
    [scienceLab setExit:@"east" toRoom:greenHouse];
    [scienceLab setExit:@"south" toRoom:gym];
    
    [gym setExit:@"north" toRoom:scienceLab];
    
    [navigationRoom setExit:@"south" toRoom:scienceLab];
    
    [greenHouse setExit:@"west" toRoom:scienceLab];
    
    id<Item> nav_key, cheese, yogurt, statue, ray_gun, book,  weights, flowerbed;
    
    nav_key = [[Key alloc]initWithName:@"navigation_key" andUnlocks:navigationRoom];
    cheese = [[Food alloc]initWithName:@"cheese" andNutrition:10];
    yogurt = [[Food alloc]initWithName:@"yogurt" andNutrition:10];
    statue = [[Item alloc]initWithName:@"statue" andWeight:30 andCanPickup:NO];
    ray_gun = [[Weapon alloc]initWithName:@"ray_gun" andWeight:5 andDamage:15];
    book = [[Item alloc]initWithName:@"book" andWeight:1 andCanPickup:YES];
    weights = [[Item alloc]initWithName:@"weights" andWeight:20 andCanPickup:YES];
    flowerbed = [[Item alloc]initWithName:@"flowerbed" andWeight:20 andCanPickup:NO];
    
    [gym addToItems:weights];
    [hallway addToItems:cheese];
    [crewCabin addToItems:yogurt];
    [hallway addToItems:statue];
    [armory addToItems:ray_gun];
    [library addToItems:book];
    

    Alien* alien1 = [[Alien alloc]initWithHealth:100 andStrength:10 andRoom:hallway andName:@"guard1" andMoveTime:15 andMessage:@"I am alien1"];
    Alien* alien2 = [[Alien alloc]initWithHealth:100 andStrength:10 andRoom:scienceLab andName:@"guard2" andMoveTime:10 andMessage:@"I am alien2"];
    Alien* alien3 = [[Alien alloc]initWithHealth:100 andStrength:20 andRoom:gym andName:@"overlord" andMoveTime:30 andMessage:@"I am overlord"];
    
    [alien3 addToInventory:nav_key];
    
    
    return probeRoom;
    
    
}

-(void)start
{
    playing = YES;
    [player outputMessage:[self welcome]];
}

-(void)end
{
    [player outputMessage:[self goodbye]];
    playing = NO;
}

-(BOOL)execute:(NSString *)commandString
{
	BOOL finished = NO;
    if (playing) {
        [player commandMessage:[NSString stringWithFormat:@"\n>%@",commandString]];
        Command *command = [parser parseCommand:commandString];
        if (command) {
            finished = [command execute:player];
        }
        else {
            [player errorMessage:@"\nI dont' understand..."];
        }
    }
    return finished;
}

-(NSString *)welcome
{
	NSString *message = @"Welcome to the World of CSU!\n\nThe World of CSU is a new, incredibly boring adventure game.\n\nType 'help' if you need help.";
	return [NSString stringWithFormat:@"%@\n%@", message, [player currentRoom]];
}

-(NSString *)goodbye
{
    return @"\nThank you for playing, Goodbye.\n";
}

-(void)dealloc
{
	[parser release];
	[player release];
	
	[super dealloc];
}

@end

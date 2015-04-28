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
        
    }
	return self;
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
	id<Room> outside, cctParking, boulevard, universityParking, parkingDeck, cct, theGreen, universityHall, schuster, teleport;
	
	outside = [[[Room alloc] initWithTag:@"outside the main entrance of the university" andName:@"outside" andLocked:NO] autorelease];
	cctParking = [[[Room alloc] initWithTag:@"in the parking lot at CCT" andName:@"cctParking" andLocked:NO] autorelease];
	boulevard = [[[Room alloc] initWithTag:@"on the boulevard" andName:@"boulevard" andLocked:NO] autorelease];
    universityParking = [[[Room alloc] initWithTag:@"in the parking lot at University Hall" andName:@"university parking" andLocked:NO] autorelease];
	parkingDeck = [[[Room alloc] initWithTag:@"in the parking deck" andName:@"parking deck" andLocked:NO] autorelease];
	cct = [[[Room alloc] initWithTag:@"in the CCT building" andName:@"cct" andLocked:NO] autorelease];
	theGreen = [[[Room alloc] initWithTag:@"in the green in front of Schuster Center" andName:@"the green" andLocked:NO] autorelease];
	universityHall = [[[Room alloc] initWithTag:@"in University Hall" andName:@"university hall" andLocked:NO] autorelease];
	schuster = [[[Room alloc] initWithTag:@"in the Schuster Center" andName:@"schuster" andLocked:NO] autorelease];
    teleport = [[[TeleportRoom alloc] initWithTag:@"in the Teleport Room" andName:@"teleport" andLocked:YES] autorelease];
    
	[outside setExit:@"west" toRoom:boulevard];
	
	[boulevard setExit:@"east" toRoom:outside];
	[boulevard setExit:@"south" toRoom:cctParking];
	[boulevard setExit:@"west" toRoom:theGreen];
	[boulevard setExit:@"north" toRoom:universityParking];
    [boulevard setExit:@"teleport" toRoom:teleport];
    [teleport setExit:@"north" toRoom:cct];
	[cctParking setExit:@"west" toRoom:cct];
	[cctParking setExit:@"north" toRoom:boulevard];
	
	[cct setExit:@"east" toRoom:cctParking];
	[cct setExit:@"north" toRoom:schuster];
	
	[schuster setExit:@"south" toRoom:cct];
	[schuster setExit:@"north" toRoom:universityHall];
	[schuster setExit:@"east" toRoom:theGreen];
	
	[theGreen setExit:@"west" toRoom:schuster];
	[theGreen setExit:@"east" toRoom:boulevard];
	
	[universityHall setExit:@"south" toRoom:schuster];
	[universityHall setExit:@"east" toRoom:universityParking];
	
	[universityParking setExit:@"south" toRoom:boulevard];
	[universityParking setExit:@"west" toRoom:universityHall];
	[universityParking setExit:@"north" toRoom:parkingDeck];
	
	[parkingDeck setExit:@"south" toRoom:universityParking];
	
    id<Item> wood = [[[Item alloc]initWithName:@"wood" andWeight:5 andCanPickup:YES] autorelease];
    id<Item> dog = [[[Item alloc]initWithName:@"dog" andWeight:5 andCanPickup:YES] autorelease];
    id<Item> cat = [[[Item alloc]initWithName:@"cat" andWeight:5 andCanPickup:YES] autorelease];
    id<Item> car = [[[Item alloc]initWithName:@"car" andWeight:5 andCanPickup:NO] autorelease];
    id<Item> teleportKey = [[[Key alloc]initWithName:@"teleport-key" andUnlocks:teleport ]autorelease];
    id<Item> hamburger = [[[Food alloc]initWithName:@"Hamburger" andNutrition:10]autorelease ];
    id<Item> weapon = [[[Weapon alloc] initWithName:@"weapon" andWeight:5 andDamage:10] autorelease];
    
    Alien* alien2 = [[Alien alloc] initWithHealth:200 andStrength:100 andRoom:boulevard andName:@"NPC2" andMoveTime:20 andMessage:@"I am NPC2"];
    Alien* alien3 = [[Alien alloc] initWithHealth:200 andStrength:100 andRoom:schuster andName:@"NPC3" andMoveTime:20 andMessage:@"I am NPC3"];
    
    
    [boulevard addToItems:wood];
    [boulevard addToItems:dog];
    [boulevard addToItems:cat];
    [boulevard addToItems:car];
    [boulevard addToItems:teleportKey];
    [boulevard addToItems:hamburger];
    [boulevard addToItems:weapon];

    
	return outside;
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

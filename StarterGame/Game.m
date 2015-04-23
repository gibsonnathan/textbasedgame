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
        
	}
	return self;
}


-(Room *)createWorld
{
	Room *outside, *cctParking, *boulevard, *universityParking, *parkingDeck, *cct, *theGreen, *universityHall, *schuster;
    
    TeleportRoom* teleport;
	
	outside = [[[Room alloc] initWithTag:@"outside the main entrance of the university" andName:@"outside"] autorelease];
	cctParking = [[[Room alloc] initWithTag:@"in the parking lot at CCT" andName:@"cctParking"] autorelease];
	boulevard = [[[Room alloc] initWithTag:@"on the boulevard" andName:@"boulevard"] autorelease];
    universityParking = [[[Room alloc] initWithTag:@"in the parking lot at University Hall" andName:@"university parking"] autorelease];
	parkingDeck = [[[Room alloc] initWithTag:@"in the parking deck" andName:@"parking deck"] autorelease];
	cct = [[[Room alloc] initWithTag:@"in the CCT building" andName:@"cct"] autorelease];
	theGreen = [[[Room alloc] initWithTag:@"in the green in front of Schuster Center" andName:@"the green"] autorelease];
	universityHall = [[[Room alloc] initWithTag:@"in University Hall" andName:@"university hall"] autorelease];
	schuster = [[[Room alloc] initWithTag:@"in the Schuster Center" andName:@"schuster"] autorelease];
    teleport = [[TeleportRoom alloc] initWithTag:@"in the Teleport Room" andName:@"teleport"];
    
    [teleport setIsLocked:YES];
    Key* teleportKey = [[Key alloc] initWithName:@"teleport-key" andWeight:1 andCanPickup:YES andUnlocks:teleport];
    [boulevard addToItems:teleportKey];
    
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
	
    Item* wood = [[Item alloc]initWithName:@"wood" andWeight:5];
    [boulevard addToItems:wood];
    
    Item* dog = [[Item alloc]initWithName:@"dog" andWeight:5];
    [boulevard addToItems:dog];
    
    Item* cat = [[Item alloc]initWithName:@"cat" andWeight:5];
    [boulevard addToItems:cat];
    
    Item* car = [[Item alloc]initWithName:@"car" andWeight:5 andCanPickup:NO];
    [boulevard addToItems:car];
    
    Weapon* weapon = [[Weapon alloc] initWithName:@"weapon" andDamage:1 andWeight:1 andCanPickUp:YES];
    [boulevard addToItems:weapon];
    
    Alien* alien1 = [[Alien alloc] initWithHealth:50 andStrength:5 andRoom:schuster andName:@"NPC1" andMoveTime:10 andMessage:@"I am NPC1"];
    Alien* alien2 = [[Alien alloc] initWithHealth:20 andStrength:5 andRoom:universityParking andName:@"NPC2" andMoveTime:10 andMessage:@"I am NPC2"];
    
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

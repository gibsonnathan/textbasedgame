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
    [self performSelector:@selector(end) withObject:nil afterDelay:1];
}

-(void)playerEncounteredNPC:(NSNotification*)notification{
    //check to see if where the player has moved is the win location
    if ([[[notification object] name] isEqualTo:@"navigation room"]) {
        [self performSelector:@selector(won) withObject:nil afterDelay:1];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NPCEncounteredByPlayer" object:[notification object]];
}

-(void)NPCEncounteredPlayer:(NSNotification*)notification{
    NSDictionary* data = [notification userInfo];
    NSString* name = [data objectForKey:@"name"];
    Room* room = [data objectForKey:@"room"];
    if ([room isEqual:[player currentRoom]]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PlayerEncounteredByNPC" object:name];
    }
}
-(Room *)createWorld
{
    Room* armory, *crewCabin, *teleport, *hallway, *probeRoom, *library, *gym, *navigationRoom, *scienceLab, *greenHouse;
    
    armory = [[[Room alloc] initWithTag:@"in the armory room. This seems to be where they store their weapons and other items for battling" andName:@"armory" andLocked:NO] autorelease];
    crewCabin = [[[Room alloc] initWithTag:@"in the crew cabin. It appears that this is the housing quarter for the inhabitants" andName:@"crew cabin" andLocked:NO] autorelease];
    teleport = [[[TeleportRoom alloc] initWithTag:@"in the teleport room" andName:@"teleport" andLocked:NO] autorelease];
    hallway = [[[Room alloc] initWithTag:@"in the hallway" andName:@"hallway" andLocked:NO] autorelease];
    probeRoom = [[[Room alloc] initWithTag:@"in the probe room. There are all sorts of tools lying around to disect humans" andName:@"probe room" andLocked:NO] autorelease];
    library = [[[Room alloc] initWithTag:@"in the library. This species seems to be very intelligent" andName:@"library" andLocked:NO] autorelease];
    gym = [[[Room alloc] initWithTag:@"in the gym" andName:@"gym" andLocked:NO] autorelease];
    navigationRoom = [[[Room alloc] initWithTag:@"in the navigation room" andName:@"navigation room" andLocked:YES] autorelease];
    scienceLab = [[[Room alloc] initWithTag:@"in the science lab. The instruments in this lab look very advanced" andName:@"science lab" andLocked:NO] autorelease];
    greenHouse = [[[Room alloc] initWithTag:@"in the green house. It looks like this is where they grow their food and other vegetation" andName:@"green house" andLocked:NO] autorelease];
    
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
    
    Item *nav_key, *cheese, *yogurt, *statue, *ray_gun, *book, *weights, *flowerbed, *phaser, *mango, *grapes;
    
    nav_key = [[Key alloc]initWithName:@"navigation_key" andUnlocks:navigationRoom];
    cheese = [[Food alloc]initWithName:@"cheese" andNutrition:20];
    yogurt = [[Food alloc]initWithName:@"yogurt" andNutrition:20];
    statue = [[Item alloc]initWithName:@"statue" andWeight:30 andCanPickup:NO];
    ray_gun = [[Weapon alloc]initWithName:@"ray_gun" andWeight:5 andDamage:15];
    phaser = [[Weapon alloc]initWithName:@"phaser" andWeight:5 andDamage:30];
    book = [[Item alloc]initWithName:@"book" andWeight:1 andCanPickup:YES];
    weights = [[Item alloc]initWithName:@"weights" andWeight:20 andCanPickup:YES];
    flowerbed = [[Item alloc]initWithName:@"flowerbed" andWeight:20 andCanPickup:NO];
    mango = [[Food alloc]initWithName:@"mango" andNutrition:10];
    grapes = [[Food alloc]initWithName:@"grapes" andNutrition:15];
    
    [gym addToItems:weights];
    [hallway addToItems:cheese];
    [crewCabin addToItems:yogurt];
    [hallway addToItems:statue];
    [armory addToItems:ray_gun];
    [library addToItems:book];
    [greenHouse addToItems:flowerbed];
    [gym addToItems:weights];
    [armory addToItems:ray_gun];
    
    //NPC* alien1 = [[NPC alloc]initWithHealth:100 andStrength:5 andRoom:armory andName:@"guard1" andMoveTime:15 andMessage:@"guard1: What are you doing? You are not supposed to be roaming this ship!"];
    //NPC* alien2 = [[NPC alloc]initWithHealth:100 andStrength:10 andRoom:library andName:@"guard2" andMoveTime:0 andMessage:@"guard2: You aren't supposed to be here!"];
    //NPC* alien3 = [[NPC alloc]initWithHealth:100 andStrength:20 andRoom:scienceLab andName:@"overlord" andMoveTime:0 andMessage:@"overlord: I am the alien overlord, you are not supposed to be roaming around this ship. Prepare for your demise."];
    
    //[alien3 addToInventory:nav_key];
    //[alien2 addToInventory:mango];
    //[alien1 addToInventory:phaser];
    //[alien1 addToInventory:grapes];
    
    return probeRoom;
    
    
}

-(void)start
{
    playing = YES;
    [player outputMessage:[self welcome]];
}

-(void)won{
    [player outputMessage: [NSString stringWithFormat: @"\nCongratulations, you have reached the navigation room! You will soon be back on planet Earth! %@", [self goodbye]]];
    
    playing = NO;
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
	NSString *message = @"\nYou wake up and realize that you are on an alien spacecraft. In order to get back home you must find your way to the navigation room and set the craft to navigate back to Earth; however, the inhabitants of the craft will not make this an easy task.\n";
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

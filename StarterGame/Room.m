//  ***
//
//  Room.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 7/14/14.
//  Copyright 2014 Columbus State University. All rights reserved.
//


#import "Room.h"
@implementation Room 

@synthesize tag;
@synthesize name;

-(id)init
{
    return [self initWithTag:@"No Tag" andName:@"Room" andLocked:NO];
}

-(id)initWithTag:(NSString *)newTag andName:(NSString*)newName andLocked:(BOOL)newLocked;
{
	self = [super init];
    
	if (nil != self) {
		[self setTag:newTag];
        [self setName:newName];
		exits = [[NSMutableDictionary alloc] initWithCapacity:10];
        items = [[NSMutableDictionary alloc] initWithCapacity:10];
        locked = newLocked;
	}
    
	return self;
}

-(NSArray*)items{
    return [items allKeys];
}
-(Item*)itemForKey:(NSString*) key{
    return [items objectForKey:key];
}

-(void)addToItems:(Item*) newItem{
    [items setObject: newItem forKey: [newItem name]];
}

-(Item*)removeFromItems:(NSString*)item{
    Item* temp = [items objectForKey:item];
    [items removeObjectForKey:item];
    return temp;
}

-(void)setExit:(NSString *)exit toRoom:(Room*)room
{
	[exits setObject:room forKey:exit];
}

-(Room*)getExit:(NSString *)exit
{
	return [exits objectForKey:exit];
}

-(NSString *)getExits
{
	NSArray *exitNames = [exits allKeys];
	return [NSString stringWithFormat:@"%@", [exitNames componentsJoinedByString:@" "]];
}

-(NSString *)description
{
	return [NSString stringWithFormat:@"You are %@.\n *** %@", tag, [self getExits]];
}

-(void)lock{
    locked = YES;
}
-(void)unlock{
    locked = NO;
}
-(BOOL)isLocked{
    return locked;
}

-(void)dealloc
{
	[tag release];
	[exits release];
    [items release];
    [name release];
	[super dealloc];
}

@end

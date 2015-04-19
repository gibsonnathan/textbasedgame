//  ***
//
//  Room.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 7/14/14.
//  Copyright 2014 Columbus State University. All rights reserved.
//

#import "Room.h"
#import "Item.h"

@implementation Room 

@synthesize isLocked;
@synthesize tag;

-(id)init
{
	return [self initWithTag:@"No Tag"];
}

-(id)initWithTag:(NSString *)newTag
{
	self = [super init];
    
	if (nil != self) {
		[self setTag:newTag];
		exits = [[NSMutableDictionary alloc] initWithCapacity:10];
        items = [[NSMutableDictionary alloc] initWithCapacity:10];
	}
    
	return self;
}

-(NSArray*) items{
    return [items allKeys];
}
-(id<Item>)itemForKey:(NSString*) key{
    return [items objectForKey:key];
}

-(void)addToItems:(id<Item>) newItem{
    [items setObject: newItem forKey: [newItem name]];
}

-(id<Item>)removeFromItems:(NSString*)item{
    id<Item> temp = [items objectForKey:item];
    [items removeObjectForKey:item];
    return temp;
}

-(void)setExit:(NSString *)exit toRoom:(id<Room>)room
{
	[exits setObject:room forKey:exit];
}

-(id<Room>)getExit:(NSString *)exit
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

-(void)dealloc
{
	[tag release];
	[exits release];
	
	[super dealloc];
}

@end

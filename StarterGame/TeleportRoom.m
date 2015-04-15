//
//  TeleportRoom.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/13/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "TeleportRoom.h"

@implementation TeleportRoom

@synthesize delegate;
@synthesize tag;
@synthesize isLocked;

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
        previousLocations = [[NSMutableArray alloc] init];
        Room* x = [[Room alloc]init];
        [self setDelegate:x];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLocation:) name:@"PlayerHasWalked" object:nil];
    }
    return self;
}

-(void)addLocation:(NSNotification*)notification{
    if (![previousLocations containsObject:[notification object]] && ![[notification object] isEqualTo:self]) {
        [previousLocations addObject:[notification object]];
    }
}

-(void)setExit:(NSString *)exit toRoom:(id<Room>)room
{
    [delegate setExit:exit toRoom:room];
}

-(id<Room>)getExit:(NSString *)exit{
    if (![exit isEqualTo:@"outside"]) {
        return nil;
    }else{
        NSInteger randomValue = arc4random_uniform((int)[previousLocations count]);
        id<Room> temp = [previousLocations objectAtIndex: randomValue];
        return temp;
    }
}
-(NSString *)getExits{
    return [NSString stringWithFormat:@"Exits: outside"];
}

-(void)addToItems:(id<Item>) newItem{
    [delegate addToItems:newItem];
}
-(id<Item>)removeFromItems:(NSString*)item{
    return [delegate removeFromItems:item];
}
-(id<Item>)itemForKey:(NSString*) key{
    return [delegate itemForKey:key];

}
-(NSArray*) items{
    return [delegate items];
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

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
        [self setDelegate:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLocation:) name:@"PlayerHasWalked" object:nil];
    }
    return self;
}

-(void)addLocation:(NSNotification*)notification{
    if (![previousLocations containsObject:[notification object]] && ![[notification object] isEqualTo:self]) {
        [previousLocations addObject:[notification object]];
    }
}

-(void)setExit:(NSString *)exit toRoom:(id<Rooms>)room
{
    if(delegate){
        [delegate setExit:exit toRoom:room];
    }else{
        [exits setObject:room forKey:exit];
    }
}

-(id<Rooms>)getExit:(NSString *)exit{
    if (delegate) {
        return [delegate getExit: exit];
    }
    else{
        if (![exit isEqualTo:@"outside"]) {
            return nil;
        }else{
            NSInteger randomValue = arc4random_uniform((int)[previousLocations count]);
            id<Rooms> temp = [previousLocations objectAtIndex: randomValue];
            return temp;
        }
    }
}
-(NSString *)getExits
{
    if(delegate){
        return [delegate getExits];
    }else{
        return [NSString stringWithFormat:@"Exits: outside"];
    }
}

-(void)addToItems:(Item*) newItem{
    if(delegate){
        [delegate addToItems:newItem];
    }else{
        
    }

}
-(Item*)removeFromItems:(NSString*)item{
    if(delegate){
        return [delegate removeFromItems:item];
    }else{
        return nil;
    }
}
-(Item*)itemForKey:(NSString*) key{
    if(delegate){
        return [delegate itemForKey:key];
    }else{
        return nil;
    }
}
-(NSArray*) items{
    if(delegate){
        return [delegate items];
    }else{
        return nil;
    }
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

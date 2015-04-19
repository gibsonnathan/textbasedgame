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

-(id)init{
    return [self initWithTag:@"No Tag" andName:@"Room"];
}

-(id)initWithTag:(NSString *)newTag andName:(NSString*)newName{
    self = [super init];
    
    if (nil != self) {
        [self setDelegate:[[Room alloc]initWithTag:newTag andName:newName]];
        previousLocations = [[NSMutableArray alloc] init];
        [delegate setTag:newTag];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLocation:) name:@"PlayerHasWalked" object:nil];
    }
    return self;
}

-(void)addLocation:(NSNotification*)notification{
    if (![previousLocations containsObject:[notification object]] && ![[notification object] isEqualTo:self]) {
        [previousLocations addObject:[notification object]];
    }
}

-(void)setExit:(NSString *)exit toRoom:(id<Room>)room{
    [delegate setExit:exit toRoom:room];
}

-(void)setName:(NSString*)newName{
    [delegate setName:newName];
}
-(NSString*)name{
    return [delegate name];
}

-(id<Room>)getExit:(NSString *)exit{
    if ([exit isNotEqualTo:@"outside"]) {
        return nil;
    }else{
        if ([previousLocations count] > 0) {
            NSInteger randomValue = arc4random_uniform((int)[previousLocations count]);
            id<Room> temp = [previousLocations objectAtIndex: randomValue];
            return temp;
        }
    }
    return nil;
}
-(NSString *)getExits{
    return [NSString stringWithFormat:@"outside"];
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

-(void)setIsLocked:(BOOL)locked{
    [delegate setIsLocked:locked];
}
-(BOOL)isLocked{
    return [delegate isLocked];
}

-(void)setTag:(NSString*)newTag{
    [delegate setTag:newTag];
}
-(NSString*)tag{
    return [delegate tag];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"You are %@.\n *** %@", [delegate tag], [self getExits]];
}

-(void)dealloc{
    [exits release];
    [super dealloc];
}
@end

//
//  Item.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/8/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Item.h"

@implementation Item

@synthesize name;
@synthesize weight;
@synthesize canPickup;

-(id)init{
    return [self initWithName:@"Item"];
}
-(id)initWithName:(NSString*) newName{
    return [self initWithName:newName andWeight:10];
}

-(id)initWithName:(NSString *)newName andWeight:(int)newWeight{
    return[self initWithName:newName andWeight:newWeight andCanPickup:true];
}

-(id)initWithName:(NSString*) newName andWeight: (int) newWeight andCanPickup:(BOOL)pickup{
    self = [super init];
    if(self){
        [self setCanPickup:pickup];
        [self setName: newName];
        [self setWeight: newWeight];
    }
    return self;
}
-(NSString*)description{
    return [NSString stringWithFormat:@" %@ %d", [self name], [self weight]];
}

-(void)dealloc{
    [name release];
    [super dealloc];
}

@end

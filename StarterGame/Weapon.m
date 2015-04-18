//
//  Weapon.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/15/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Weapon.h"

@implementation Weapon

@synthesize name;
@synthesize weight;
@synthesize damage;
@synthesize canPickup;

-(id) init{
    return [self initWithName:@"weapon"];
}
-(id) initWithName:(NSString*)newName{
    return [self initWithName:newName andWeight:10];
}
-(id) initWithName:(NSString*)newName andWeight:(int)newWeight{
    return [self initWithName:newName andDamage:10 andWeight:newWeight andCanPickUp:YES];
}
-(id) initWithName:(NSString *)newName andDamage:(int)newDamage andWeight:(int)newWeight andCanPickUp:(BOOL*) newCanPickup{
    self = [super init];
    if (self) {
        [self setName: newName];
        [self setWeight:newWeight];
        [self setCanPickup:newCanPickup];
        [self setDamage:newDamage];
    }
    return self;
}

@end

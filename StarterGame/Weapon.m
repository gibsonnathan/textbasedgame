//
//  Weapon.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/15/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Weapon.h"
@implementation Weapon

-(id)init{
    return [self initWithName:@"unknown-weapon" andWeight:5 andDamage:10];
}

-(id)initWithName:(NSString*)newName andWeight:(int)newWeight andDamage:(int)newDamage{
    
    self = [super init];
    if (self){
        name = newName;
        weight = newWeight;
        damage = newDamage;
    }
    return self;
}

-(int)weight{
    return weight;
}

-(BOOL)canPickup{
    return YES;
}

-(int)damage{
    return damage;
}

-(void)dealloc{
    [name release];
    [super dealloc];
}

@end

//
//  Weapon.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/15/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Weapon.h"
@implementation Weapon

-(id)initWithName:(NSString*)newName andWeight:(int)newWeight andDamage:(int)newDamage{
    
    self = [super init];
    if (self){
        name = newName;
        weight = newWeight;
        damage = newDamage;
    }
    return self;
}

-(NSString*)name{
    return name;
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
-(int)nutrition{
    return 0;
}
-(Room*)unlocks{
    return nil;
}

@end

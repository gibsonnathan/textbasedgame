//
//  Weapon.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/15/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//
//  A specific type of item that that has a damage and a weight
//

#import <Foundation/Foundation.h>
#import "Room.h"
#import "Item.h"

@interface Weapon : Item{
    int damage;
}

-(id)initWithName:(NSString*)newName andWeight:(int)newWeight andDamage:(int)newDamage;

@end

//
//  Weapon.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/15/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"
#import "Item.h"

@interface Weapon : Item{
  
    int damage;
}

-(id)initWithName:(NSString*)newName andWeight:(int)newWeight andDamage:(int)newDamage;


-(NSString*)name;
-(int)weight;
-(BOOL)canPickup;
-(int)damage;
-(int)nutrition;
-(Room*)unlocks;


@end

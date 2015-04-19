//
//  Weapon.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/15/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
@interface Weapon : NSObject <Item>{

}

@property (nonatomic, retain)NSString* name;
@property (nonatomic) int weight;
@property (nonatomic) BOOL canPickup;
@property (nonatomic) int damage;

-(id)init;
-(id)initWithName:(NSString*)newName;
-(id)initWithName:(NSString*)newName andWeight:(int)newWeight;
-(id)initWithName:(NSString *)newName andDamage:(int)newDamage andWeight:(int)newWeight andCanPickUp:(BOOL*) newCanPickup;

@end

//
//  Food.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/26/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//
//  A more specific type of item that when consumed increased the player's
//  health by the amount of nutrition in the food
//

#import <Foundation/Foundation.h>
#import "Room.h"
#import "Item.h"

@interface Food : Item{
    int nutrition;
}

-(id)initWithName:(NSString*)newName andNutrition:(int)newNutrition;


@end

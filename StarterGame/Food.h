//
//  Food.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/26/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"
@interface Food : NSObject <Item>{
    NSString* name;
    int nutrition;
}
-(id)initWithName:(NSString*)newName andNutrition:(int)newNutrition;
-(NSString*)name;
-(int)weight;
-(BOOL)canPickup;
-(int)damage;
-(int)nutrition;
-(Room*)unlocks;



@end

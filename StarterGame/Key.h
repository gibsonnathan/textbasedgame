//
//  Key.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/13/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
@interface Key : NSObject <Item>{
    NSString* name;
    Room* unlocks;
}

-(id)initWithName:(NSString*)newName andUnlocks:(Room*)newRoom;
-(NSString*)name;
-(int)weight;
-(BOOL)canPickup;
-(int)damage;
-(int)nutrition;
-(Room*)unlocks;


@end

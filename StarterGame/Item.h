//
//  Item.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/8/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
@interface Item : NSObject <Item>{
    NSString* name;
    int weight;
    BOOL canPickup;
}

-(id)initWithName:(NSString*)newName andWeight:(int)newWeight andCanPickup:(BOOL)newCanPickup;
-(NSString*)name;
-(int)weight;
-(BOOL)canPickup;
-(int)damage;
-(int)nutrition;
-(id<Room>)unlocks;
@end

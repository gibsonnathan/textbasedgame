//
//  Key.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/13/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Key.h"

@implementation Key

-(id) init{
    return [self initWithName:@"Key"];
}
-(id) initWithName:(NSString*) newName{
    return [self initWithName:newName andWeight:10];
}

-(id) initWithName:(NSString *)newName andWeight:(int)newWeight{
    return[self initWithName:newName andWeight:newWeight andCanPickup:true];
}

-(id) initWithName:(NSString*) newName andWeight: (int) newWeight andCanPickup:(BOOL)pickup{
    return [self initWithName:newName andWeight:newWeight andCanPickup:YES andUnlocks:nil];
}

-(id) initWithName:(NSString*) newName andWeight: (int) newWeight andCanPickup: (BOOL) pickup andUnlocks:(id<Room>) newRoom{

    self = [super init];
    if(self){
        [self setCanPickup:pickup];
        [self setName: newName];
        [self setWeight: newWeight];
        [self setUnlocks:newRoom];
    }
    return self;
}

@end

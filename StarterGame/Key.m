//
//  Key.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/13/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Key.h"
@implementation Key

-(id)initWithName:(NSString*)newName andUnlocks:(Room*)newRoom{
    self = [super init];
    if (self) {
        name = newName;
        unlocks = newRoom;
    }
    return self;
}

-(NSString*)name{
    return name;
}
-(int)weight{
    return 2;
}
-(BOOL)canPickup{
    return YES;
}
-(int)damage{
    return 0;
}
-(int)nutrition{
    return 0;
}
-(Room*)unlocks{
    return unlocks;
}


@end

//
//  Item.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/8/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Item.h"
@implementation Item

-(id)initWithName:(NSString*)newName andWeight:(int)newWeight andCanPickup:(BOOL)newCanPickup{
    
    self = [super init];
    if(self){
        name = newName;
        weight = newWeight;
        canPickup = newCanPickup;
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
    return canPickup;
}
-(int)damage{
    return 0;
}
-(int)nutrition{
    return 0;
}
-(Room*)unlocks{
    return nil;
}

@end

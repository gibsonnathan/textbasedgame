//
//  Food.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/26/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Food.h"

@implementation Food

-(id)init{
    return [self initWithName:@"food" andNutrition:1];
}

-(id)initWithName:(NSString*)newName andNutrition:(int)newNutrition{
    self = [super init];
    if(self){
        name = newName;
        nutrition = newNutrition;
    }
    return self;
}

-(int)weight{
    return 2;
}
-(BOOL)canPickup{
    return YES;
}

-(int)nutrition{
    return nutrition;
}

-(void)dealloc{
    [name release];
    [super dealloc];
}
@end

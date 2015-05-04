//
//  InventoryCommand.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/9/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "InventoryCommand.h"

@implementation InventoryCommand


-(id)init
{
    self = [super init];
    if (nil != self) {
        name = @"inventory";
        [self setHelp:@"looks at the items the player is currently holding"];
    }
    return self;
}

-(BOOL)execute:(Player *)player
{
    [player searchInventory];
    return NO;
}

@end

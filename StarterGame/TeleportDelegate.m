//
//  TeleportDelegate.m
//  StarterGame
//
//  Created by csu on 4/30/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "TeleportDelegate.h"

@implementation TeleportDelegate

-(Room*)getExit:(NSString *)exit{
    if ([exit isNotEqualTo:@"outside"]) {
        return nil;
    }
    return nil;
}
-(NSString *)getExits{
    return [NSString stringWithFormat:@"outside"];
}

@end

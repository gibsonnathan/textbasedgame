//
//  BackCommand.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/9/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"

@interface BackCommand : Command

-(id)init;
-(BOOL)execute:(Player *)player;

@end

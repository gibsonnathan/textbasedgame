//
//  ExitsCommand.h
//  StarterGame
//
//  Created by Nathan Gibson on 5/3/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"

@interface ExitsCommand : Command

-(id)init;
-(BOOL)execute:(Player *)player;

@end

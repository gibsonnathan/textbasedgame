//
//  AttackCommand.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/21/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "NPC.h"
#import "Command.h"
@interface AttackCommand : Command
-(id)init;
-(BOOL)execute:(Player *)player;
@end

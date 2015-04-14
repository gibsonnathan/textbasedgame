//
//  Protocols.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/12/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"

@protocol RoomProtocol <NSObject>

-(void)setExit:(NSString *)exit toRoom:(Room *)room;
-(Room*)getExit:(NSString *)exit;
-(NSString *)getExits;

@end

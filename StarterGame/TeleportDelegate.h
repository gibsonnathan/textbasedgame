//
//  TeleportDelegate.h
//  StarterGame
//
//  Created by csu on 4/30/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
#import "Room.h"
@interface TeleportDelegate : NSObject{

}

-(id<Room>)getExit:(NSString *)exit;
-(NSString *)getExits;

@end

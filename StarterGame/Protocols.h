//
//  Protocols.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/14/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//
#include "Item.h"
#import <Foundation/Foundation.h>

@protocol Rooms <NSObject>
-(id)init;
-(id)initWithTag:(NSString *)newTag;
-(void)setExit:(NSString *)exit toRoom:(id<Rooms>)room;
-(id<Rooms>)getExit:(NSString *)exit;
-(NSString *)getExits;
-(void)addToItems:(Item*) newItem;
-(Item*)removeFromItems:(NSString*)item;
-(Item*)itemForKey:(NSString*) key;
-(NSArray*) items;
@end

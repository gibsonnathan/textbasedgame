//  ***
//
//  Room.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 7/14/14.
//  Copyright 2014 Columbus State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Room.h"
#import "Item.h"

@class Item;

@interface Room : NSObject{
	NSMutableDictionary *exits;
    NSMutableDictionary *items;
    BOOL locked;
}

@property (retain, nonatomic)NSString *tag;
@property (retain, nonatomic)NSString* name;

-(id)initWithTag:(NSString *)newTag andName:(NSString*)newName andLocked:(BOOL)newLocked;
-(NSString*)tag;
-(NSString*)name;
-(void)setExit:(NSString*)exit toRoom:(Room*)room;
-(Room*)getExit:(NSString*)exit;
-(NSString*)getExits;
-(void)addToItems:(Item*)newItem;
-(Item*)removeFromItems:(NSString*)item;
-(Item*)itemForKey:(NSString*)key;
-(NSArray*)items;
-(void)lock;
-(void)unlock;
-(BOOL)isLocked;

@end

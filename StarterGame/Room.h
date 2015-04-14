//  ***
//
//  Room.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 7/14/14.
//  Copyright 2014 Columbus State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Item.h"
@interface Room : NSObject{
	NSMutableDictionary *exits;
    NSMutableDictionary *items;
}

@property (nonatomic)BOOL isLocked;
@property (retain, nonatomic)NSString *tag;


-(id)init;
-(id)initWithTag:(NSString *)newTag;
-(void)setExit:(NSString *)exit toRoom:(Room *)room;
-(Room *)getExit:(NSString *)exit;
-(NSString *)getExits;
-(void)addToItems:(Item*) newItem;
-(Item*)removeFromItems:(NSString*)item;
-(Item*)itemForKey:(NSString*) key;
-(NSArray*) items;
@end

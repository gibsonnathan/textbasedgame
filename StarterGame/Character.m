//
//  Character.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/13/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Character.h"
#import "Player.h"
@implementation Character

@synthesize delegate;

-(id)init
{
    return [self initWithRoom:nil andIO:nil];
}

-(id)initWithRoom:(Room *)room andIO:(GameIO *)theIO
{
    return [self initWithRoom:room andIO:theIO andDelegate:nil];
}
-(id)initWithRoom:(Room *)room andIO:(GameIO *)theIO andDelegate:(Character*) delegateCharacter
{
    self = [super init];
    if(self){
        [self setCurrentRoom:room];
        [self setIo:theIO];
        [self setDelegate:delegateCharacter];
    }
    return self;
}

-(void)walkTo:(NSString *)direction{
    [delegate walkTo:direction];
}
-(void)outputMessage:(NSString *)message{
    [delegate outputMessage:message];
}
-(void)outputMessage:(NSString *)message withColor:(NSColor *)color{
    [delegate outputMessage:message withColor:color];
}
-(void)warningMessage:(NSString *)message{
    [delegate warningMessage:message];
}
-(void)errorMessage:(NSString *)message{
    [delegate errorMessage:message];
}
-(void)commandMessage:(NSString *)message{
    [delegate commandMessage:message];
}
-(void)addToInventory:(Item*) item{
    [delegate addToInventory:item];
}
-(void)dropItem:(NSString*) item{
    [delegate dropItem:item];
}

@end

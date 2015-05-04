//  ***
//
//  HelpCommand.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 3/7/12.
//  Copyright 2012 Columbus State University. All rights reserved.
//
//  Modified by Rodrigo A. Obando on 3/7/13.

#import "HelpCommand.h"


@implementation HelpCommand

@synthesize words;

-(id)init
{
	return [self initWithWords:[[[CommandWords alloc] init] autorelease]];
}

-(id)initWithWords:(CommandWords *)newWords
{
	self = [super init];
    
	if (nil != self) {
		[self setWords:newWords];
        name = @"help";
        [self setHelp:@"tells the player about the game or a command"];
	}
    
	return self;
}

-(BOOL)execute:(Player *)player
{
    if ([self hasSecondWord]) {
        
        NSString* help = [[[self words]get:secondWord] help];
        if (help) {
            [player outputMessage:[NSString stringWithFormat:@"\n%@", help]];
        }else{
            [player outputMessage: @"\nI don't have that command."];
        }
        
        
    }
    else {
        [player outputMessage:[NSString stringWithFormat:@"\nYou are on an alien spacecraft. You are looking for the navigation room so that you can guide the craft back to your home planet. You are lost. You are alone. Your available commands are: %@", [words description]  ]];
    }
	return NO;
}

-(void)dealloc
{
	[words release];
	[super dealloc];
}

@end

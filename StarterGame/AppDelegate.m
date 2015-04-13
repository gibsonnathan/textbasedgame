//
//  AppDelegate.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 7/14/14.
//  Copyright 2014 Columbus State University. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize command;
@synthesize output;

- (void)dealloc
{
    [gameIO release];
    [game release];
    
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    gameIO = [[GameIO alloc] initWithOutput:output];
    game = [[Game alloc] initWithGameIO:gameIO];
    [game start];
}

- (IBAction)receiveCommandFrom:(id)sender {
    if ([game execute: [sender stringValue]]) {
        [game end];
    }
    [sender setStringValue:@""];
}
@end

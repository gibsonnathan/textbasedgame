//
//  AppDelegate.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 7/14/14.
//  Copyright 2014 Columbus State University. All rights reserved.
//

#import "AppDelegate.h"
#import "GameIOManager.h"

@implementation AppDelegate

@synthesize command;
@synthesize output;

- (void)dealloc
{

    [game release];
    
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    gameIO = [GameIOManager sharedInstance:output];
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


//  ***
//
//  AppDelegate.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 7/14/14.
//  Copyright 2014 Columbus State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GameIO.h"
#import "Game.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    GameIO *gameIO;
    Game *game;
}

@property (assign) IBOutlet NSTextField *command;
@property (assign) IBOutlet NSTextView *output;

@property (assign) IBOutlet NSWindow *window;

- (IBAction)receiveCommandFrom:(id)sender;

@end

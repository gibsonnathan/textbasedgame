//  ***
//
//  GameIO.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 7/14/14.
//  Copyright 2014 Columbus State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameIO : NSObject{
    NSTextView *output;
    NSColor *currentColor;
}

@property (retain, nonatomic)NSColor *currentColor;

-(id)initWithOutput:(NSTextView*)theOutput;
-(void)sendLines:(NSString*)input;
-(void)clear;

@end

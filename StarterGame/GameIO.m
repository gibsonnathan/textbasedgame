//  ***
//
//  GameIO.m
//  StarterGame
//
//  Created by Rodrigo A. Obando on 7/14/14.
//  Copyright 2014 Columbus State University. All rights reserved.
//

#import "GameIO.h"

@implementation GameIO

@synthesize currentColor;

-(id)initWithOutput:(NSTextView *)theOutput
{
    self = [super init];
    
    if (nil != self) {
        output = theOutput;
        [self setCurrentColor:[NSColor blueColor]];
        [self clear];
    }
    
    return self;
}

-(void)sendLines:(NSString *)input
{
    NSInteger start = [[output string] length];
    [[output textStorage] appendAttributedString:[[NSAttributedString alloc] initWithString: input]];
    NSInteger end = [[output string] length];
    [output setTextColor:[self currentColor] range:NSMakeRange(start, end - start)];
    [output scrollRangeToVisible:NSMakeRange([[output string] length], 0)];
}

-(void)clear
{
    [output setString:@""];
    [output setTextColor:[self currentColor]];
}

-(void)dealloc
{
    [super dealloc];
}

@end

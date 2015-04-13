//
//  Item.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/8/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject{
    
}

@property (retain, nonatomic) NSString *name;
@property (nonatomic) int weight;
@property (nonatomic) BOOL canPickup;


-(id) init;
-(id) initWithName:(NSString*) newName;
-(id) initWithName:(NSString*) newName andWeight: (int) newWeight;
-(id) initWithName:(NSString*) newName andWeight: (int) newWeight andCanPickup: (BOOL) pickup;

@end

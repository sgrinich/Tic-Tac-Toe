//
//  Button.h
//  Tic Tac Toe
//
//  Created by Stephen Grinich on 4/14/14.
//  Copyright (c) 2014 Stephen Grinich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OurButton : UIButton

@property int color;
@property BOOL isSet;
@property int whoHasPressed; //Either: None: 0, Red: -1, Blue: 1

void setColor(int newColor);

- (IBAction)ourButtonPressed:(id)sender;

void resetButton();

@end

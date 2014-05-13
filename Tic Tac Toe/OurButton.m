//
//  Button.m
//  Tic Tac Toe
//
//  Created by Stephen Grinich on 4/14/14.
//  Copyright (c) 2014 Stephen Grinich. All rights reserved.
//

#import "OurButton.h"

@implementation OurButton : UIButton

int color;
BOOL isSet;

void setColor(int newColor){
    color = newColor;

}

- (IBAction)ourButtonPressed:(id)sender {
    isSet = true;
    setColor(color);
    
}

void resetButton(){
    color = 0; // make color gray
    isSet = false;
}








@end

//
//  ViewController.h
//  Tic Tac Toe 2
//
//  Created by Stephen Grinich on 4/16/14.
//  Copyright (c) 2014 Stephen Grinich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OurButton.h"

@interface ViewController : UIViewController

@property IBOutlet UIView* tttBoardView;

-(IBAction)buttonPressed:(id)button;

void reDrawFromState();

int checkGameResult();


@end

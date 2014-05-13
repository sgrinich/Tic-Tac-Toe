//
//  ViewController.m
//  Tic Tac Toe
//
//  Written by Stephen Grinich, Michael Wheatman, Gordon Loery
//  Mobile Applicaiton Development, Spring 2014
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

// Initialize variables
NSMutableArray *gameArray;
int redTurn = 1;
int spaceTaken[9];
int currentBackgroundColor = 0;
int m = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    gameArray = [[NSMutableArray alloc] initWithCapacity:9];

    int i;
    for (i = 1; i<10; i++) {
        spaceTaken[i-1] = 0;
    }
    for (int i = 1; i<10; i++) {
        OurButton *button = [[OurButton alloc] init];
        [gameArray addObject:button];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Red Wins = int value of red, Blue Wins = int value of blue, Draw = 1, Game Not Over = 0
- (int) checkGameResult {
    int j;
    j = 0;
    int winner;
    
    // This is monotonous, but it is the same amount of code as writing loops to do the same
    // Checks if at any point there is a winning state
    winner = [self checkWinner:0 and:1 and:2];
    if(winner >0) {
        return winner;
    }
    winner = [self checkWinner:3 and:4 and:5];
    if(winner >0) {
        return winner;
    }
    winner = [self checkWinner:6 and:7 and:8];
    if(winner>0) {
        return winner;
    }
    winner = [self checkWinner:0 and:3 and:6];
    if(winner>0) {
        return winner;
    }
    winner = [self checkWinner:1 and:4 and:7];
    if(winner>0) {
        return winner;
    }
    winner = [self checkWinner:2 and:5 and:8];
    if(winner>0) {
        return winner;
    }
    winner = [self checkWinner:0 and:4 and:8];
    if(winner>0) {
        return winner;
    }
    winner = [self checkWinner:2 and:4 and:6];
    if(winner>0) {
        return winner;
    }
    
    // Check for draw
    int i;
    for(i=1; i<10; i++){
       // OurButton *thisButton = [gameArray objectAtIndex:i]; // this might not work !!!
        if((spaceTaken[i-1] != 0)){
            j++;
        }
    }
    
    if(j==9){
        return -1; // game is a draw
    }
    
    return 0; // game not over
    
}

// Returns int of winner color
// why do these 'and's make the error go away?
- (int) checkWinner:(int) a and: (int) b and: (int) c {
    
    if (spaceTaken[a] ==  0) {
        return 0;
    }
    
    if(spaceTaken[a] == spaceTaken[b] && spaceTaken[c] == spaceTaken[b]){
        //OurButton *thisButton = [gameArray objectAtIndex:a]; // this might not work !!!
        return 1;
    }
    else{
        return 0;
    }
}

// Responds to any button touch, proceeds according to tag of button
-(IBAction)buttonPressed:(id)button {

    // index becomes tag of button touched
    int index = (int)[button tag];
    
    // Reset background color
    if(index == 100) {
        button = (UIButton *)[self.view viewWithTag:0];
        m++;
        m = (m%5);
        if(m==1)
            [button setBackgroundColor:[UIColor orangeColor]];
        if(m==2)
            [button setBackgroundColor:[UIColor yellowColor]];
        if(m==3)
            [button setBackgroundColor:[UIColor greenColor]];
        if(m==4)
            [button setBackgroundColor:[UIColor purpleColor]];
        if(m==0)
            [button setBackgroundColor:[UIColor whiteColor]];
        
        return;
    }
    
    // Reset Game if new game button is touched
    if(index == 99) {
        int i;
        for(i = 1; i<10; i++){
            spaceTaken[i-1] = 0;
            button = (UIButton *)[self.view viewWithTag:i];
            [button setBackgroundColor:[UIColor lightGrayColor]];
            
        }
        redTurn = 1;
        return;
    }
    
    if(redTurn == 1 && spaceTaken[index-1] == 0) {
        [button setBackgroundColor:[UIColor redColor]];
        spaceTaken[index-1] = 1;
    }
    if(redTurn == -1 && spaceTaken[index-1] == 0) {
        [button setBackgroundColor:[UIColor blueColor]];
        spaceTaken[index-1] = -1;
    }
    
    int status;
    status = [self checkGameResult];
    
    // Game is over
    if(status != 0) {
        int n;
        for(n = 1; n<10; n++){
            if(spaceTaken[n-1] == 0){
                // Can't click buttons anymore once game is over
                spaceTaken[n-1] = 3;
            }
        }
        // It is a draw
        if (status == -1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tic Tac Toe"
                                                            message:@"Game is a draw!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            

        }
        
        if(status > 0 ){
            if (redTurn == 1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tic Tac Toe"
                                                                message:@"Red has won!"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            
            if (redTurn == -1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tic Tac Toe"
                                                                message:@"Blue has won!"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    }
    if(status == 0){
        redTurn = -redTurn;
    }
    
}

// Saves sate
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    // Converts c array to NSArray
    NSMutableArray * gameSavedState = [[NSMutableArray alloc] initWithCapacity: 10];
    if(gameSavedState)
    {
        for(int i = 1; i<10; i++)
        {
            [gameSavedState addObject: [NSNumber numberWithInt:spaceTaken[i-1]]];
        }
        
        if (redTurn == 1) {
            [gameSavedState addObject:[NSNumber numberWithInt:1]];
        }
        
        if (redTurn == -1) {
            [gameSavedState addObject:[NSNumber numberWithInt:-1]];
        }
        
    }
    
    [coder encodeObject:gameSavedState forKey:@"State of game"];
    [super encodeRestorableStateWithCoder:coder];
}

// Loads from saved state
-(void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    // Must convert NSArray to c array
    NSArray *gameSavedSate = [coder decodeObjectForKey:@"State of game"];
    [super decodeRestorableStateWithCoder:coder];
    
    for (int i = 0; i < 9; i++) {
        spaceTaken[i] = [[gameSavedSate objectAtIndex:i] intValue];
    }
    
    redTurn = [[gameSavedSate objectAtIndex:9] intValue];
    [self reDrawFromState];
}

// Redraws board from saved state
-(void)reDrawFromState{
        int i;
        for(i = 1; i<10; i++){
            int taken;
            UIButton *button;
            taken = spaceTaken[i-1];
            button = (UIButton *)[self.view viewWithTag:i];
            if (taken == 1){
                [button setBackgroundColor:[UIColor redColor]];
            }
            if (taken == -1){
                [button setBackgroundColor:[UIColor blueColor]];
            }
            if (taken == 0){
                [button setBackgroundColor:[UIColor lightGrayColor]];
            }
        }
        return;
    
}

@end
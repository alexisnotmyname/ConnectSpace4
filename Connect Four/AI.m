//
//  AI.m
//  Connect Four
//
//  Created by Training on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AI.h"

@interface AI ()

@end

@implementation AI

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)Easy:(NSArray *)gameBoard
{
    BOOL invalidTurn = false, badMove = false;
    int cpuMove;
    UIImage *black = [UIImage imageNamed:@"black.png"];
    
    int i=0;
    for(int r=0; r<6;r++) //Stores the values of NSArray gameBoard into a C-type 2D array named holes.
    {
        for(int c=0; c<7; c++)
        {
            holes[r][c] = [gameBoard objectAtIndex:i];
            i++;
        }
    }
    
    do
    {
       
        cpuMove = (arc4random()%7); //generate random move
        for(int row=5; row>=0; row--)
        {
             badMove = false;
            if([holes[row][cpuMove].image isEqual:black])
            {
                //holes[row][cpuMove].image = [UIImage imageNamed:@"yellow.png"];
                invalidTurn = false;
                badMove = [self aiBadMoveGetRow:row andCol:cpuMove];
                if(badMove)
                {
                    NSLog(@"Bad move move at r:%i c:%i",row,cpuMove);
                    holes[winningRow][winningCol].image = [UIImage imageNamed:@"yellow.png"];
                    badMove = false;
                }
                else 
                {
                    NSLog(@"Good move at r:%i c:%i",row,cpuMove);
                    holes[row][cpuMove].image = [UIImage imageNamed:@"yellow.png"];
                    
                }
                break;
            }
            else if(![holes[0][cpuMove].image isEqual:black])
            {
                invalidTurn = true;
                break;
            }
        }
        
        if(!invalidTurn)
        {
            break;
        }
        
    } while (invalidTurn);
}

- (void)Normal:(NSArray *)gameBoard
{
    int turn=0;
    UIImage *red = [UIImage imageNamed:@"red.png"];
    UIImage *black = [UIImage imageNamed:@"black.png"];
    UIImage *yellow = [UIImage imageNamed:@"yellow.png"];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    int i=0;
    for(int r=0; r<6;r++) //Stores the values of NSArray gameBoard into a C-type 2D array named holes.
    {
        for(int c=0; c<7; c++)
        {
            holes[r][c] = [gameBoard objectAtIndex:i];
            i++;
        }
    }
    
    for(int c=0;c<6;c++) //horizontal defensive moves(rows)
    {    
        for(int d=0;d<4;d++)
        {
            if(c==5) //if(c==5) means that if the pieces are in the lowest row.
            {   
                if([holes[c][d].image isEqual:red] && [holes[c][d].image isEqual:holes[c][d+1].image] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+3].image isEqual:black] && turn==0)
                {  
                    holes[c][d+3].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d].image isEqual:red]  && [holes[c][d].image isEqual:holes[c][d+2].image] && [holes[c][d+2].image isEqual:holes[c][d+3].image] && [holes[c][d+1].image isEqual:black] && turn==0){  
                    holes[c][d+1].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d].image isEqual:red] && [holes[c][d].image isEqual:holes[c][d+1].image] && [holes[c][d+1].image isEqual:holes[c][d+3].image] && [holes[c][d+2].image isEqual:black] && turn==0){  
                    holes[c][d+2].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:red] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+2].image isEqual:holes[c][d+3].image] && [holes[c][d].image isEqual:black] && turn==0){  
                    holes[c][d].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:red] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+3].image isEqual:black]&& [holes[c][d].image isEqual:black] && turn==0){  
                    holes[c][d+3].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:red] && [holes[c][d+1].image isEqual:holes[c][d+3].image] && [holes[c][d+2].image isEqual:black] && [holes[c][d].image isEqual:black] && turn==0){  
                    holes[c][d+2].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
            }
            else //if not in the last row
            {    //validates if the slot below where the winning piece will be placed is not empty.
                if([holes[c][d].image isEqual:red] && [holes[c][d].image isEqual:holes[c][d+1].image] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+3].image isEqual:black] && ![holes[c+1][d+3].image isEqual:black] && turn==0){  
                    holes[c][d+3].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d].image isEqual:red] && [holes[c][d].image isEqual:holes[c][d+2].image] && [holes[c][d+2].image isEqual:holes[c][d+3].image] && [holes[c][d+1].image isEqual:black] && ![holes[c+1][d+1].image isEqual:black] && turn==0)   {  
                    holes[c][d+1].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d].image isEqual:red] && [holes[c][d].image isEqual:holes[c][d+1].image] && [holes[c][d+1].image isEqual:holes[c][d+3].image] && [holes[c][d+2].image isEqual:black] && ![holes[c+1][d+2].image isEqual:black]&& turn==0){  
                    holes[c][d+2].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:red] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+2].image isEqual:holes[c][d+3].image] && [holes[c][d].image isEqual:black] && ![holes[c+1][d].image isEqual:black] && turn==0){  
                    holes[c][d].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:red] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+3].image isEqual:black] && ![holes[c+1][d+3].image isEqual:black] && [holes[c][d].image isEqual:black] && ![holes[c+1][d].image isEqual:black] && turn==0){  
                    holes[c][d+3].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:red] && [holes[c][d+1].image isEqual:holes[c][d+3].image] && [holes[c][d+2].image isEqual:black] && ![holes[c+1][d+2].image isEqual:black] && [holes[c][d].image isEqual:black] && ![holes[c+1][d].image isEqual:black] && turn==0){  
                    holes[c][d+2].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
            }
        }
    }
    
    for(int e=5;e>2;e--) //vertical defensive moves(columns)
    {   
        for(int f=6;f>=0;f--)
        {	
            if([holes[e][f].image isEqual:red] && [holes[e][f].image isEqual:holes[e-1][f].image] && [holes[e-1][f].image isEqual:holes[e-2][f].image] && [holes[e-3][f].image isEqual:black] && turn==0)
            {
                holes[e-3][f].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }
        }
    }
    
    for(int g=5;g>2;g--) //defensive moves for diagonals leaning to the right
    {
        for(int h=0;h<4;h++)	
        {	
            if ([holes[g][h].image isEqual:red] && [holes[g][h].image isEqual:holes[g-1][h+1].image] && [holes[g-1][h+1].image isEqual:holes[g-2][h+2].image] && [holes[g-3][h+3].image isEqual:black] && ![holes[g-2][h+3].image isEqual:black]  && turn==0)
            {   //This block checks if the last piece of the diagonal is empty then fill it to avoid the opponent from connecting 4 "X" marks. The diagonal check is from bottom to top. 
                holes[g-3][h+3].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }
            if ([holes[g][h].image isEqual:red] && [holes[g][h].image isEqual:holes[g-1][h+1].image] && [holes[g-1][h+1].image isEqual:holes[g-3][h+3].image] && [holes[g-2][h+2].image isEqual:black] &&  ![holes[g-1][h+2].image isEqual:black] && turn==0)
            {   //This block checks if the third piece of the diagonal is empty then fill it to avoid the opponent from connecting 4 "X" marks. The diagonal check is from bottom to top. 
                holes[g-2][h+2].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }               
            if ([holes[g][h].image isEqual:red] && [holes[g][h].image isEqual:holes[g-2][h+2].image] && [holes[g-2][h+2].image isEqual:holes[g-3][h+3].image] && [holes[g-1][h+1].image isEqual:black] && ![holes[g][h+1].image isEqual:black] && turn==0)
            {   //This block checks if the second piece of the diagonal is empty then fill it to avoid the opponent from connecting 4 "X" marks. The diagonal check is from bottom to top.
                holes[g-1][h+1].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }
            if(g==5)//This if-else block checks if the first piece of the diagonal is empty then fill it to avoid the opponent from connecting 4 "X" marks. The diagonal check is from bottom to top. 
            {       //if(i==5) means that if the last piece will be on the lowest row.
                if ([holes[g-1][h+1].image isEqual:red] && [holes[g-1][h+1].image isEqual:holes[g-2][h+2].image] && [holes[g-2][h+2].image isEqual:holes[g-3][h+3].image] && [holes[g][h].image isEqual:black] && turn==0)
                {
                    holes[g][h].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;
                }
            }
            else  //validates if the slot below where the blocking piece will be placed is not empty.
            {
                if ([holes[g-1][h+1].image isEqual:red] && [holes[g-1][h+1].image isEqual:holes[g-2][h+2].image]  && [holes[g-2][h+2].image isEqual:holes[g-3][h+3].image] && [holes[g][h].image isEqual:black] && ![holes[g+1][h].image isEqual:black] && turn==0)
                {
                    holes[g][h].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;
                }
            }
            
        }
    }
    
    for(int i=5;i>2;i--) //defensive moves for diagonals leaning to the left
    {
        for(int j=6;j>2;j--)
        {	
            if ([holes[i][j].image isEqual:red] && [holes[i][j].image isEqual:holes[i-1][j-1].image] && [holes[i-1][j-1].image isEqual:holes[i-2][j-2].image] && [holes[i-3][j-3].image isEqual:black] && ![holes[i-2][j-3].image isEqual:black] && turn==0)  
            {   //This block checks if the last piece of the diagonal is empty then fill it to avoid the opponent from connecting 4 "X" marks. The diagonal check is from bottom to top.
                holes[i-3][j-3].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }
            if ([holes[i][j].image isEqual:red] && [holes[i][j].image isEqual:holes[i-1][j-1].image] && [holes[i-1][j-1].image isEqual:holes[i-3][j-3].image] && [holes[i-2][j-2].image isEqual:black] && ![holes[i-1][j-2].image isEqual:black] && turn==0)  
            {   //This block checks if the third piece of the diagonal is empty then fill it to avoid the opponent from connecting 4 "X" marks. The diagonal check is from bottom to top.
                holes[i-2][j-2].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }
            if ([holes[i][j].image isEqual:red] && [holes[i][j].image isEqual:holes[i-2][j-2].image] && [holes[i-2][j-2].image isEqual:holes[i-3][j-3].image] && [holes[i-1][j-1].image isEqual:black] && ![holes[i][j-1].image isEqual:black] && turn==0)  
            {   //This block checks if the second piece of the diagonal is empty then fill it to avoid the opponent from connecting 4 "X" marks. The diagonal check is from bottom to top.
                holes[i-1][j-1].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }
            if(i==5)//This if-else block checks if the first piece of the diagonal is empty then fill it to avoid the opponent from connecting 4 "X" marks. The diagonal check is from bottom to top.    
            {       //if(k==5) means that if the last piece will be on the lowest row.
                if ([holes[i-1][j-1].image isEqual:red] && [holes[i-1][j-1].image isEqual:holes[i-2][j-2].image] && [holes[i-2][j-2].image isEqual:holes[i-3][j-3].image] && [holes[i][j].image isEqual:black] && turn==0)  
                {
                    holes[i][j].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;
                }
            }
            else //validates if the slot below where the blocking piece will be placed is not empty.
            {
                if ([holes[i-1][j-1].image isEqual:red] && [holes[i-1][j-1].image isEqual:holes[i-2][j-2].image] && [holes[i-2][j-2].image isEqual:holes[i-3][j-3].image] && [holes[i][j].image isEqual:black] && ![holes[i+1][j].image isEqual:black] && turn==0)  
                {    
                    holes[i][j].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;
                }
            }
            
        }
    }
    
//    for(int e=5;e>2;e--) //vertical defensive moves(columns)
//    {   
//        for(int f=6;f>=0;f--)
//        {	
//            if([holes[e][f].image isEqual:red] && [holes[e][f].image isEqual:holes[e-1][f].image] && [holes[e-2][f].image isEqual:black] && turn==0)
//            {
//                holes[e-2][f].image = [UIImage imageNamed:@"yellow.png"];
//                turn=1;
//                break;
//            }
//        }
//    }
    
    for(int c=0;c<6;c++) //horizontal offensive moves(rows)
    {    
        for(int d=0;d<4;d++)
        {
            if(c==5) //if(c==5) means that if the pieces are in the lowest row.
            {   
                if([holes[c][d].image isEqual:yellow] && [holes[c][d].image isEqual:holes[c][d+1].image] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+3].image isEqual:black] && turn==0){
                    holes[c][d+3].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d].image isEqual:yellow] && [holes[c][d].image isEqual:holes[c][d+2].image] && [holes[c][d+2].image isEqual:holes[c][d+3].image] && [holes[c][d+1].image isEqual:black] && turn==0){ 
                    holes[c][d+1].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d].image isEqual:yellow] && [holes[c][d].image isEqual:holes[c][d+1].image] && [holes[c][d+1].image isEqual:holes[c][d+3].image] && [holes[c][d+2].image isEqual:black] && turn==0){ 
                    holes[c][d+2].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+2].image isEqual:holes[c][d+3].image] && [holes[c][d].image isEqual:black] && turn==0){
                    holes[c][d].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+3].image isEqual:black] && [holes[c][d].image isEqual:black] && turn==0){  
                    holes[c][d+3].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+3].image] && [holes[c][d+2].image isEqual:black] && [holes[c][d].image isEqual:black] && turn==0){
                    holes[c][d+2].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
            }
            else //if not in the last row
            {    //validates if the slot below where the winning piece will be placed is not empty.
                if([holes[c][d].image isEqual:yellow] && [holes[c][d].image isEqual:holes[c][d+1].image] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+3].image isEqual:black] && ![holes[c+1][d+3].image isEqual:black] && turn==0){  
                    holes[c][d+3].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d].image isEqual:yellow] && [holes[c][d].image isEqual:holes[c][d+2].image] && [holes[c][d+2].image isEqual:holes[c][d+3].image] && [holes[c][d+1].image isEqual:black] && ![holes[c+1][d+1].image isEqual:black] && turn==0){  
                    holes[c][d+1].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d].image isEqual:yellow] && [holes[c][d].image isEqual:holes[c][d+1].image] && [holes[c][d+1].image isEqual:holes[c][d+3].image] && [holes[c][d+2].image isEqual:black] && ![holes[c+1][d+2].image isEqual:black] && turn==0){ 
                    holes[c][d+2].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+2].image isEqual:holes[c][d+3].image] && [holes[c][d].image isEqual:black] && ![holes[c+1][d].image isEqual:black] && turn==0){
                    holes[c][d].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+3].image isEqual:black] && ![holes[c+1][d+3].image isEqual:black] && [holes[c][d].image isEqual:black] && ![holes[c+1][d].image isEqual:black] && turn==0){
                    holes[c][d+3].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+3].image] && [holes[c][d+2].image isEqual:black] && ![holes[c+1][d+2].image isEqual:black] && [holes[c][d].image isEqual:black] && ![holes[c+1][d].image isEqual:black] && turn==0){  
                    holes[c][d+2].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
            }
        }
    }
       
    for(int e=5;e>2;e--) //vertical offensive moves(columns)
    {   
        for(int f=6;f>=0;f--)
        {	
            if([holes[e][f].image isEqual:yellow] && [holes[e][f].image isEqual:holes[e-1][f].image] && [holes[e-1][f].image isEqual:holes[e-2][f].image] && [holes[e-3][f].image isEqual:black] && turn==0){
                holes[e-3][f].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }
        }
    }
    
    //Random Move
    if(turn==0) //calls easy method for random move
    {
        for (int i=0; i<6; i++)
        {
            for (int j=0; j<7; j++)
            {
                [temp addObject:holes[i][j]];
            }
        }
        [self Easy:temp];
        turn=1;
    }  
}

- (void)Hard:(NSArray *)gameBoard
{
    int turn=0;
    //UIImage *red = [UIImage imageNamed:@"red.png"];
    UIImage *black = [UIImage imageNamed:@"black.png"];
    UIImage *yellow = [UIImage imageNamed:@"yellow.png"];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    int i=0;
    for(int r=0; r<6;r++) //Stores the values of NSArray gameBoard into a C-type 2D array named holes.
    {
        for(int c=0; c<7; c++)
        {
            holes[r][c] = [gameBoard objectAtIndex:i];
            i++;
        }
    }
    
    for(int c=0;c<6;c++) //horizontal offensive moves(rows)
    {    
        for(int d=0;d<4;d++)
        {
            if(c==5) //if(c==5) means that if the pieces are in the lowest row.
            {   
                if([holes[c][d].image isEqual:yellow] && [holes[c][d].image isEqual:holes[c][d+1].image] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+3].image isEqual:black] && turn==0){
                    holes[c][d+3].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d].image isEqual:yellow] && [holes[c][d].image isEqual:holes[c][d+2].image] && [holes[c][d+2].image isEqual:holes[c][d+3].image] && [holes[c][d+1].image isEqual:black] && turn==0){ 
                    holes[c][d+1].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d].image isEqual:yellow] && [holes[c][d].image isEqual:holes[c][d+1].image] && [holes[c][d+1].image isEqual:holes[c][d+3].image] && [holes[c][d+2].image isEqual:black] && turn==0){ 
                    holes[c][d+2].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+2].image isEqual:holes[c][d+3].image] && [holes[c][d].image isEqual:black] && turn==0){
                    holes[c][d].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
//                if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+3].image isEqual:black] && [holes[c][d].image isEqual:black] && turn==0){  
//                    holes[c][d+3].image = [UIImage imageNamed:@"yellow.png"];
//                    turn=1;
//                    break;  
//                }
//                if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+3].image] && [holes[c][d+2].image isEqual:black] && [holes[c][d].image isEqual:black] && turn==0){
//                    holes[c][d+2].image = [UIImage imageNamed:@"yellow.png"];
//                    turn=1;
//                    break;  
//                }
            }
            else //if not in the last row
            {    //validates if the slot below where the winning piece will be placed is not empty.
                if([holes[c][d].image isEqual:yellow] && [holes[c][d].image isEqual:holes[c][d+1].image] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+3].image isEqual:black] && ![holes[c+1][d+3].image isEqual:black] && turn==0){  
                    holes[c][d+3].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d].image isEqual:yellow] && [holes[c][d].image isEqual:holes[c][d+2].image] && [holes[c][d+2].image isEqual:holes[c][d+3].image] && [holes[c][d+1].image isEqual:black] && ![holes[c+1][d+1].image isEqual:black] && turn==0){  
                    holes[c][d+1].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d].image isEqual:yellow] && [holes[c][d].image isEqual:holes[c][d+1].image] && [holes[c][d+1].image isEqual:holes[c][d+3].image] && [holes[c][d+2].image isEqual:black] && ![holes[c+1][d+2].image isEqual:black] && turn==0){ 
                    holes[c][d+2].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+2].image isEqual:holes[c][d+3].image] && [holes[c][d].image isEqual:black] && ![holes[c+1][d].image isEqual:black] && turn==0){
                    holes[c][d].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
//                if(d>=0 && d<=2)
//                {
//                    if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+3].image isEqual:black] && ![holes[c+1][d+3].image isEqual:black] && [holes[c][d].image isEqual:black] && ![holes[c+1][d].image isEqual:black] && [holes[c][d+4].image isEqual:black] && ![holes[c+1][d+4].image isEqual:black] && turn==0){
//                        holes[c][d+3].image = [UIImage imageNamed:@"yellow.png"];
//                        turn=1;
//                        break;  
//                    }
//                    if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+3].image] && [holes[c][d+2].image isEqual:black] && ![holes[c+1][d+2].image isEqual:black] && [holes[c][d].image isEqual:black] && ![holes[c+1][d].image isEqual:black] && [holes[c][d+4].image isEqual:black] && ![holes[c+1][d+4].image isEqual:black] && turn==0){  
//                        holes[c][d+2].image = [UIImage imageNamed:@"yellow.png"];
//                        turn=1;
//                        break;  
//                    }
//                }
            }
        }
    }
    
    for(int e=5;e>2;e--) //vertical offensive moves(columns)
    {   
        for(int f=6;f>=0;f--)
        {	
            if([holes[e][f].image isEqual:yellow] && [holes[e][f].image isEqual:holes[e-1][f].image] && [holes[e-1][f].image isEqual:holes[e-2][f].image] && [holes[e-3][f].image isEqual:black] && turn==0){
                holes[e-3][f].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }
        }
    }
    
    for(int i=5;i>2;i--) //offensive moves for diagonals leaning to the right
    {
        for(int j=0;j<4;j++)	
        {	
            if ([holes[i][j].image isEqual:yellow] && [holes[i][j].image isEqual:holes[i-1][j+1].image] && [holes[i-1][j+1].image isEqual:holes[i-2][j+2].image] && [holes[i-3][j+3].image isEqual:black] && ![holes[i-2][j+3].image isEqual:black] && turn==0)
            {   //This block checks if the last piece of the diagonal is empty then fill it to form a diagonal with 4 "O" marks. The diagonal check is from bottom to top.
                holes[i-3][j+3].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }
            if ([holes[i][j].image isEqual:yellow] && [holes[i][j].image isEqual:holes[i-1][j+1].image] && [holes[i-1][j+1].image isEqual:holes[i-3][j+3].image] && [holes[i-2][j+2].image isEqual:black] && ![holes[i-1][j+2].image isEqual:black] && turn==0)
            {   //This block checks if the third piece of the diagonal is empty then fill it to form a diagonal with 4 "O" marks. The diagonal check is from bottom to top.   
                holes[i-2][j+2].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }               
            if ([holes[i][j].image isEqual:yellow] && [holes[i][j].image isEqual:holes[i-2][j+2].image] && [holes[i-2][j+2].image isEqual:holes[i-3][j+3].image] && [holes[i-1][j+1].image isEqual:black] && ![holes[i][j+1].image isEqual:black] && turn==0)
            {   //This block checks if the second piece of the diagonal is empty then fill it to form a diagonal with 4 "O" marks. The diagonal check is from bottom to top. 
                holes[i-1][j+1].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }
            if(i==5)//This if-else block checks if the first piece of the diagonal is empty then fill it to form a diagonal with 4 "O" marks. The diagonal check is from bottom to top.    
            {       //if(i==5) means that if the last piece will be on the lowest row.
                if ([holes[i-1][j+1].image isEqual:yellow] && [holes[i-1][j+1].image isEqual:holes[i-2][j+2].image] && [holes[i-2][j+2].image isEqual:holes[i-3][j+3].image] && [holes[i][j].image isEqual:black] && turn==0)
                {       
                    holes[i][j].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;
                }
            }
            else  //validates if the slot below where the first piece will be placed is not empty.
            {
                if ([holes[i-1][j+1].image isEqual:yellow] && [holes[i-1][j+1].image isEqual:holes[i-2][j+2].image] && [holes[i-2][j+2].image isEqual:holes[i-3][j+3].image] && [holes[i][j].image isEqual:black] &&  ![holes[i+1][j].image isEqual:black] && turn==0)
                {      
                    holes[i][j].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;
                }
            }
            
        }
    }
    
    for(int k=5;k>2;k--) //offensive moves for diagonals leaning to the left
    {
        for(int l=6;l>2;l--)
        {	
            if ([holes[k][l].image isEqual:yellow] && [holes[k][l].image isEqual:holes[k-1][l-1].image] && [holes[k-1][l-1].image isEqual:holes[k-2][l-2].image] && [holes[k-3][l-3].image isEqual:black] && ![holes[k-2][l-3].image isEqual:black] && turn==0)  
            {   //This block checks if the last piece of the diagonal is empty then fill it to form a diagonal with 4 "O" marks. The diagonal check is from bottom to top.
                holes[k-3][l-3].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }
            if ([holes[k][l].image isEqual:yellow] && [holes[k][l].image isEqual:holes[k-1][l-1].image] && [holes[k-1][l-1].image isEqual:holes[k-3][l-3].image] && [holes[k-2][l-2].image isEqual:black] && ![holes[k-1][l-2].image isEqual:black] && turn==0)  
            {   //This block checks if the third piece of the diagonal is empty then fill it to form a diagonal with 4 "O" marks. The diagonal check is from bottom to top.
                holes[k-2][l-2].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }
            if ([holes[k][l].image isEqual:yellow] && [holes[k][l].image isEqual:holes[k-2][l-2].image] && [holes[k-2][l-2].image isEqual:holes[k-3][l-3].image] && [holes[k-1][l-1].image isEqual:black] && ![holes[k][l-1].image isEqual:black] && turn==0)  
            {   //This block checks if the second piece of the diagonal is empty then fill it to form a diagonal with 4 "O" marks. The diagonal check is from bottom to top. 
                holes[k-1][l-1].image = [UIImage imageNamed:@"yellow.png"];
                turn=1;
                break;
            }
            if(k==5)//This if-else block checks if the first piece of the diagonal is empty then fill it to form a diagonal with 4 "O" marks. The diagonal check is from bottom to top.    
            {       //if(k==5) means that if the last piece will be on the lowest row.
                if ([holes[k-1][l-1].image isEqual:yellow] && [holes[k-1][l-1].image isEqual:holes[k-2][l-2].image] && [holes[k-2][l-2].image isEqual:holes[k-3][l-3].image] && [holes[k][l].image isEqual:black] && turn==0)  
                {    
                    holes[k][l].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;
                }
            }
            else //validates if the slot below where the first piece will be placed is not empty.
            {
                if ([holes[k-1][l-1].image isEqual:yellow] && [holes[k-1][l-1].image isEqual:holes[k-2][l-2].image] && [holes[k-2][l-2].image isEqual:holes[k-3][l-3].image] && [holes[k][l].image isEqual:black] && ![holes[k+1][l].image isEqual:black] && turn==0)  
                {    
                    holes[k][l].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;
                }
            }
        }
    }
    
    //DEFENSE
    if(turn==0) //calls normal method for defensive behavior
    {
        for (int i=0; i<6; i++)
        {
            for (int j=0; j<7; j++)
            {
                [temp addObject:holes[i][j]];
            }
        }
        [self Normal:temp];
        turn=1;
    }

    
    for(int c=0;c<6;c++) //horizontal offensive moves(rows)
    {    
        for(int d=0;d<4;d++)
        {
            if(c==5) //if(c==5) means that if the pieces are in the lowest row.
            {   
                //[holes[c][d+1].image isEqual:holes[c][d+2].image]
                //[holes[c][d+3].image isEqual:black]
                if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+3].image isEqual:black] && [holes[c][d].image isEqual:black] && turn==0){  
                    holes[c][d+3].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+3].image] && [holes[c][d+2].image isEqual:black] && [holes[c][d].image isEqual:black] && turn==0){  
                    holes[c][d+2].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
            }
            else //if not in the last row
            {    //validates if the slot below where the winning piece will be placed is not empty.
                if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+2].image] && [holes[c][d+3].image isEqual:black] && ![holes[c+1][d+3].image isEqual:black] && [holes[c][d].image isEqual:black] && ![holes[c+1][d].image isEqual:black] && turn==0){  
                    holes[c][d+3].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
                if([holes[c][d+1].image isEqual:yellow] && [holes[c][d+1].image isEqual:holes[c][d+3].image] && [holes[c][d+2].image isEqual:black] && ![holes[c+1][d+2].image isEqual:black] && [holes[c][d].image isEqual:black] && ![holes[c+1][d].image isEqual:black] && turn==0){  
                    holes[c][d+2].image = [UIImage imageNamed:@"yellow.png"];
                    turn=1;
                    break;  
                }
            }
        }
    }
    
       
    //RANDOM MOVE
    if(turn==0) //calls easy method for random move
    {
        for (int i=0; i<6; i++)
        {
            for (int j=0; j<7; j++)
            {
                [temp addObject:holes[i][j]];
            }
        }
        [self Easy:temp];
        turn=1;
    }  
}

-(BOOL)aiBadMoveGetRow:(int) row andCol:(int) col
{
    UIImage *red = [UIImage imageNamed:@"red.png"];
    UIImage *black = [UIImage imageNamed:@"black.png"];
    //UIImage *yellow = [UIImage imageNamed:@"yellow.png"];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    WinningCombinations *wc = [[WinningCombinations alloc] init];
    BOOL wrongMove = false;
    
    
    for(int r=0; r<6;r++) //store to temp array
    {
        for(int c=0; c<7; c++)
        {
            holesTemp[r][c] = holes[r][c];
        }
    }
    
    holesTemp[row][col].image = [UIImage imageNamed:@"yellow.png"]; //fills the hole that matches the ai move
    
    for(int c=6; c>=0;c--)
    {
        BOOL colCheckFinish = false;
        int r=5;
        do
        {
            colCheckFinish = false;
            if([holesTemp[r][c].image isEqual:black])
            {
                colCheckFinish = true;
                holesTemp[r][c].image = [UIImage imageNamed:@"red.png"];
                for (int i=0; i<6; i++)
                {
                    for (int j=0; j<7; j++)
                    {
                        [temp addObject:holesTemp[i][j]]; //store to another temp array(NSArray)
                        
                    }
                }
                
                wrongMove = [self checkWin:temp]; //check if it will cause the player to win

                if(wrongMove){
                    holesTemp[r][c].image = [UIImage imageNamed:@"black.png"];
                    holesTemp[row][col].image = [UIImage imageNamed:@"black.png"];
                    NSLog(@"Good move at r:%i c%i",r,c);
                    if(r==5)
                    {
                        winningRow = r;
                        winningCol = c;
                    }
                    else 
                    {
                        if(![holesTemp[r+1][c].image isEqual:black])
                        {
                            winningRow = r;
                            winningCol = c;
                        }
                        else {
                            wrongMove = false;
//                            winningRow = r;
//                            winningCol = c;
                        }
                    }
                    
                    NSLog(@"Player will win at row:%i col%i",r,c);
                    break;
                }
                else {
                    holesTemp[r][c].image = [UIImage imageNamed:@"black.png"];
                    //holesTemp[row][col].image = [UIImage imageNamed:@"black.png"];
                }
                //break;

            }
            else {
                r--;
                
                if(r==-1)
                {
                    break;
                }
            }
            
            if (colCheckFinish) {
                break;
            }
            
            
            NSLog(@"%i",r);
        }while(!colCheckFinish);
        
        if(wrongMove)
        {
            break;
        }
        
    }
     
    return wrongMove;
    
//    for(int r=0; r<6;r++)
//    {
//        for(int c=0; c<7; c++)
//        {
//            if([holesTemp[r][c].image isEqual:black])
//            {
//                holes[r][c].image = [UIImage imageNamed:@"red.png"];
//                for (int i=0; i<6; i++)
//                {
//                    for (int j=0; j<7; j++)
//                    {
//                        [temp addObject:holes[i][j]];
//                    }
//                }
//    
//                wrongMove = [wc checkWin:temp];
//                
//                if(wrongMove){
//                    break;
//                }
//            }
//        }
//    }

}

- (BOOL)checkWin:(NSArray *)gameBoard
{
    BOOL gameOver=false;
    UIImage *black = [UIImage imageNamed:@"black.png"];
    UIImage *red = [UIImage imageNamed:@"red.png"];
    
    
    int i=0;
    for(int r=0; r<6;r++)
    {
        for(int c=0; c<7; c++)
        {
            holes[r][c] = [gameBoard objectAtIndex:i];
            i++;
        }
    }
    
    for(int hr=0; hr<6;hr++) //checks winning pattern by row
    {
        for(int hc=0; hc<4; hc++)
        {
            if([holes[hr][hc].image isEqual:red] && 
               [holes[hr][hc].image isEqual:holes[hr][hc+1].image] && 
               [holes[hr][hc+1].image isEqual:holes[hr][hc+2].image] && 
               [holes[hr][hc+2].image isEqual:holes[hr][hc+3].image])
            {
                gameOver = true;
                break;
            }
        }
    }
    
        
    /////////
    
    for(int vr=0; vr<3;vr++) //checks winning pattern by column
    {
        for(int vc=0; vc<7; vc++)
        {
            if([holes[vr][vc].image isEqual:red] && 
               [holes[vr][vc].image isEqual:holes[vr+1][vc].image] && 
               [holes[vr+1][vc].image isEqual:holes[vr+2][vc].image] && 
               [holes[vr+2][vc].image isEqual:holes[vr+3][vc].image])
            {
                gameOver = true;
                break;
            }
        }
    }
    
    for(int drr=5; drr>2;drr--) //checks winning pattern for diagonals leaning to the right
    {
        for(int drc=0; drc<4; drc++)
        {
            if(drr==5)
            {
                if([holes[drr][drc].image isEqual:red] && 
                   [holes[drr][drc].image isEqual:holes[drr-1][drc+1].image] &&
                   [holes[drr-1][drc+1].image isEqual:holes[drr-2][drc+2].image] && 
                   [holes[drr-2][drc+2].image isEqual:holes[drr-3][drc+3].image] &&
                   ![holes[drr][drc+1].image isEqual:black] &&
                   ![holes[drr-1][drc+2].image isEqual:black] &&
                   ![holes[drr-2][drc+3].image isEqual:black] )
                {
                    gameOver = true;
                    break;
                }

            }
            else {
                if([holes[drr][drc].image isEqual:red] && 
                   [holes[drr][drc].image isEqual:holes[drr-1][drc+1].image] &&
                   [holes[drr-1][drc+1].image isEqual:holes[drr-2][drc+2].image] && 
                   [holes[drr-2][drc+2].image isEqual:holes[drr-3][drc+3].image] &&
                   ![holes[drr+1][drc].image isEqual:black] &&
                   ![holes[drr][drc+1].image isEqual:black] &&
                   ![holes[drr-1][drc+2].image isEqual:black] &&
                   ![holes[drr-2][drc+3].image isEqual:black] )
                {
                    gameOver = true;
                    break;
                }

            }
        }
    }
    
    for(int dlr=5; dlr>2;dlr--) //checks winning pattern for diagonals leaning to the left
    {
        for(int dlc=6; dlc<2; dlc--)
        {
            if(dlr==5)
            {
                if([holes[dlr][dlc].image isEqual:red] && 
                   [holes[dlr][dlc].image isEqual:holes[dlr-1][dlc-1].image] &&
                   [holes[dlr-1][dlc-1].image isEqual:holes[dlr-2][dlc-2].image] && 
                   [holes[dlr-2][dlc-2].image isEqual:holes[dlr-3][dlc-3].image] &&
                   ![holes[dlr][dlc-1].image isEqual:black] &&
                   ![holes[dlr-1][dlc-2].image isEqual:black] &&
                   ![holes[dlr-2][dlc-3].image isEqual:black])
                {
                    gameOver = true;
                    break;
                }

            }
            else 
            {
                if([holes[dlr][dlc].image isEqual:red] && 
                   [holes[dlr][dlc].image isEqual:holes[dlr-1][dlc-1].image] &&
                   [holes[dlr-1][dlc-1].image isEqual:holes[dlr-2][dlc-2].image] && 
                   [holes[dlr-2][dlc-2].image isEqual:holes[dlr-3][dlc-3].image] &&
                   ![holes[dlr+1][dlc].image isEqual:black] &&
                   ![holes[dlr][dlc-1].image isEqual:black] &&
                   ![holes[dlr-1][dlc-2].image isEqual:black] &&
                   ![holes[dlr-2][dlc-3].image isEqual:black])
                {
                    gameOver = true;
                    break;
                }

            }           
            
            
        }
    }
    
    return gameOver;
}


@end

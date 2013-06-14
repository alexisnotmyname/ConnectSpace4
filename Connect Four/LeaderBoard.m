//
//  LeaderBoard.m
//  Connect Four
//
//  Created by Training on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LeaderBoard.h"
#import "TableCellSub.h"

@interface LeaderBoard ()

@end

@implementation LeaderBoard
@synthesize resetBtn;
@synthesize tableLeaderBoard;
@synthesize segmentCtrl;


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
    scores = [[NSMutableArray alloc] init];
    clear = [NSUserDefaults standardUserDefaults];

    [scores addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"easy"]];
    NSSortDescriptor *sortAscnd = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES];
    [scores sortUsingDescriptors:[NSMutableArray arrayWithObject:sortAscnd]];
    [self deleteLowScores];

    tableLeaderBoard.tableHeaderView = segmentCtrl;
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return scores.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    static NSString *CellIdentifier = @"Cell";
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        TableCellSub *tableSubClass = [[TableCellSub alloc] init];
        tableSubClass.scores = scores;
        cell = [tableSubClass tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)viewDidUnload
{
    [self setTableLeaderBoard:nil];
    [self setSegmentCtrl:nil];
    [self setResetBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)segmentChange:(id)sender {

    NSSortDescriptor *sortAscnd = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES];
    switch (self.segmentCtrl.selectedSegmentIndex) {
        case 0:
            [scores removeAllObjects];
            [scores addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"easy"]];
            
            [scores sortUsingDescriptors:[NSMutableArray arrayWithObject:sortAscnd]];
            [self deleteLowScores];
            break;
        case 1:
            
            [scores removeAllObjects];            
            [scores addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"normal"]]; 
            
            [scores sortUsingDescriptors:[NSMutableArray arrayWithObject:sortAscnd]];
            [self deleteLowScores];

            break;
        case 2:
            [scores removeAllObjects];
            [scores addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"hard"]];
           
            [scores sortUsingDescriptors:[NSMutableArray arrayWithObject:sortAscnd]];
            [self deleteLowScores];

            break;
        default:
            break;
    }
    [tableLeaderBoard reloadData];
}

-(void)deleteLowScores
{
    if(scores.count>10)
    {
        for(int a=10; scores.count!=10;)
        {
            [scores removeObjectAtIndex:a];
        }
        
    }
}

- (IBAction)backBtn:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)resetBtn:(id)sender {
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];

    switch (self.segmentCtrl.selectedSegmentIndex) {
        case 0:
            [clear removeObjectForKey:@"easy"]; 
            [tableLeaderBoard reloadData];
            [scores removeAllObjects];
            //tableSubClass.scores = scores;
            [clear synchronize];
            break;
        case 1:
            [clear removeObjectForKey:@"normal"];
            [tableLeaderBoard reloadData];
            [scores removeAllObjects];
            [clear synchronize];
            break;
        case 2:
            [clear removeObjectForKey:@"hard"];
            [tableLeaderBoard reloadData];
            [scores removeAllObjects];
            [clear synchronize];
            break;
        default:
            break;
    }
}
@end

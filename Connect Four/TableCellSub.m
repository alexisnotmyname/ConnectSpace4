//
//  TableCellSub.m
//  Connect Four
//
//  Created by Training on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableCellSub.h"

@interface TableCellSub ()

@end

@implementation TableCellSub
@synthesize scores;
@synthesize clear;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        scores = [[NSMutableArray alloc] init];     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *photo;
    UILabel *nameLabel, *scoreLabel, *timeLabel;
    UILabel *nameHeader, *scoreHeader;
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if(indexPath.row == 0)
        {
            nameHeader = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 160, cell.frame.size.height)]; //Score
            nameHeader.font = [UIFont boldSystemFontOfSize:16];
            
            scoreHeader.tag = 5;
            
            scoreHeader = [[UILabel alloc] initWithFrame:CGRectMake(221, 0, 90, cell.frame.size.height)]; //Score
            scoreHeader.font = [UIFont boldSystemFontOfSize:16];
            scoreHeader.textAlignment = UITextAlignmentRight;
            scoreHeader.tag = 6;
        }
        
        photo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.height, cell.frame.size.height)]; //Score
        photo.tag = 4;
        [[cell contentView] addSubview:photo];  
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+cell.frame.size.height, 0, 160, cell.frame.size.height)]; //name
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.backgroundColor = [UIColor blackColor];
        nameLabel.tag = 1;
        [[cell contentView] addSubview:nameLabel];  
        
        scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(221, 0, 90, cell.frame.size.height/2)]; //Score
        scoreLabel.textColor = [UIColor whiteColor];
        scoreLabel.backgroundColor = [UIColor blackColor];
        scoreLabel.textAlignment = UITextAlignmentRight;
        scoreLabel.tag = 2;
        [[cell contentView] addSubview:scoreLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(221, cell.frame.size.height/2, 90, cell.frame.size.height/2)]; //time
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.backgroundColor = [UIColor blackColor];
        timeLabel.textAlignment = UITextAlignmentRight;
        timeLabel.tag = 3;
        [[cell contentView] addSubview:timeLabel];
    }
    else {
        nameLabel = (UILabel *)[cell viewWithTag:1];
        scoreLabel = (UILabel *)[cell viewWithTag:2];
        timeLabel = (UILabel *)[cell viewWithTag:3];
        photo = (UIImageView *) [cell viewWithTag:4];
        nameHeader = (UILabel *) [cell viewWithTag:5];
        scoreHeader = (UILabel *) [cell viewWithTag:6];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if(indexPath.row == 0)
    {
        nameHeader.text = @"Player Name";
        nameHeader.backgroundColor = [UIColor blackColor];
        nameHeader.textColor = [UIColor whiteColor];
        [[cell contentView] addSubview:nameHeader];
        scoreHeader.text = @"Score/Time";
        scoreHeader.backgroundColor = [UIColor blackColor];
        scoreHeader.textColor = [UIColor whiteColor];
        [[cell contentView] addSubview:scoreHeader];
    }
    else {
        if([scores count]>0)
        {
            photo.image = [UIImage imageWithData:[[scores objectAtIndex:indexPath.row-1] objectForKey:@"photo"]]; 
            
            nameLabel.text = [NSString stringWithFormat:@" %i. %@",indexPath.row, [[scores objectAtIndex:indexPath.row-1] objectForKey:@"name"]]; 
            
            scoreLabel.text = [NSString stringWithFormat:@"%@ pts",[[scores objectAtIndex:indexPath.row-1] objectForKey:@"points"]];
            
            //This block converts the format to h m s
            NSString *time = [[scores objectAtIndex:indexPath.row-1] objectForKey:@"time"];
            NSString *minutes = [time substringToIndex:5];
            NSString *newTimeFormat;
            
            int hour = [time substringToIndex:2].intValue, min = [minutes substringFromIndex:3].intValue, sec = [time substringFromIndex:6].intValue;
            
            NSString *hour1 = [NSString stringWithFormat:@"%ih",hour], *min1 = [NSString stringWithFormat:@"%im",min], *sec1 = [NSString stringWithFormat:@"%is",sec];
            
            if(hour>0) {
                if(min > 0) {
                    if(sec >0) {
                        newTimeFormat = [NSString stringWithFormat:@"%@ %@ %@", hour1, min1, sec1];
                    }
                    else {
                        newTimeFormat = [NSString stringWithFormat:@"%@ %@", hour1, min1];
                    }
                }
                else {
                    if(sec >0) {
                        newTimeFormat = [NSString stringWithFormat:@"%@ %@", hour1, sec1];
                    }
                    else {
                        newTimeFormat = [NSString stringWithFormat:@"%@", hour1];
                    }
                }
            }
            else {
                if(min > 0) {
                    if(sec >0) {
                        newTimeFormat = [NSString stringWithFormat:@"%@ %@", min1, sec1];
                    }
                    else {
                        newTimeFormat = [NSString stringWithFormat:@"%@", min1];
                    }
                }
                else {
                    if(sec >0) {
                        newTimeFormat = [NSString stringWithFormat:@"%@", sec1];
                    }
                    else {
                        newTimeFormat = @"";
                    }
                }       
            }
            timeLabel.text = newTimeFormat;
        }
    }    
    return cell;
}
@end

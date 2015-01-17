//
//  ItemTableViewController.m
//  Homepwner
//
//  Created by tirostiros on 15-1-13.
//  Copyright (c) 2015年 cn.com.tiros. All rights reserved.
//

#import "ItemTableViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "DetailViewController.h"

@interface ItemTableViewController ()

@end

@implementation ItemTableViewController

-(id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        // Custom initialization
        for (int i = 0; i < 5; i++)
        {
            [[BNRItemStore shareBNRItemStore] createItem];
        }
        [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.navigationItem setTitle:@"Home"];
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButton:)];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButton:)];
        [self.navigationItem setLeftBarButtonItem:left];
        [self.navigationItem setRightBarButtonItem:right];

    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    NSLog(@"rowsin %d",[[[BNRItemStore shareBNRItemStore] allItems] count]);
    return [[[BNRItemStore shareBNRItemStore] allItems] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //ios6之后，需要先注册了identifier，才能够deque
    /*
    You must register a class or nib file using the registerNib:forCellReuseIdentifier: or registerClass:forCellReuseIdentifier: method before calling this method.
    If you registered a class for the specified identifier and a new cell must be created, this method initializes the cell by calling its initWithStyle:reuseIdentifier: method. For nib-based cells, this method loads the cell object from the provided nib file. If an existing cell was available for reuse, this method calls the cell’s prepareForReuse method instead.
     */
    NSString *CellIdentifier = @"BNRItemCellInder";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    BNRItem *item = [[[BNRItemStore shareBNRItemStore] allItems] objectAtIndex:[indexPath row]];
    [cell.textLabel setText:[item description]];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.item = [[[BNRItemStore shareBNRItemStore] items] objectAtIndex:[indexPath row]];
    
//    [self presentViewController:detail animated:YES completion:nil];
    [self.navigationController pushViewController:detail animated:YES];
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSMutableArray *array = [[BNRItemStore shareBNRItemStore] items];
        [array removeObject:[array objectAtIndex:[indexPath row]]];
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    if ([fromIndexPath isEqual:toIndexPath])
    {
        return;
    }
    NSMutableArray *array = [[BNRItemStore shareBNRItemStore] items];
    BNRItem *from = [array objectAtIndex:[fromIndexPath row]];
    [array removeObject:from];
    
    [array insertObject:from atIndex:[toIndexPath row]];

    [self.tableView reloadData];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}
 */

/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.headerView.bounds.size.height;
}
*/



- (void)editButton:(id)sender
{
    if (self.tableView.editing)
    {
        [self.tableView setEditing:NO animated:YES];
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
    }
    else
    {
        [self.tableView setEditing:YES animated:YES];
        [sender setTitle:@"Done" forState:UIControlStateNormal];
    }
    
}

- (void)addButton:(id)sender
{
    [[BNRItemStore shareBNRItemStore] createItem];
    [self.tableView reloadData];
}

-(UIView *)headerView
{
    if (!_headerView)
    {
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 200, 50)];
        [_headerView setBackgroundColor:[UIColor redColor]];
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 10, 100, 30)];
        [addButton setTitle:@"Add" forState:UIControlStateNormal];
        [_headerView addSubview:addButton];
        [addButton addTarget:self action:@selector(addButton:) forControlEvents:UIControlEventTouchDown];
        
        UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(180, 10, 100, 30)];
        [editButton setTitle:@"Edit" forState:UIControlStateNormal];
        [_headerView addSubview:editButton];
        [editButton addTarget:self action:@selector(editButton:) forControlEvents:UIControlEventTouchDown];

    }
    return _headerView;
}
@end

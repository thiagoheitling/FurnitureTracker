//
//  MasterViewController.m
//  FurnitureTracker
//
//  Created by Thiago Heitling on 2016-02-05.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailTableViewController.h"
#import "Room.h"

@interface MasterViewController ()

@property (nonatomic, strong) NSMutableArray *rooms;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self.tableView reloadData];
}

- (void)insertNewObject:(id)sender
{
    UIAlertController *addNewRoomController = [UIAlertController alertControllerWithTitle:@"New Room" message:@"Please enter room name:" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *addRoom = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        Room *newRoom = [[Room alloc] init];
        newRoom.name = addNewRoomController.textFields[0].text;
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addObject:newRoom];
        [realm commitWriteTransaction];
        [self.tableView reloadData];
        
    }];
    
    [addNewRoomController addTextFieldWithConfigurationHandler:nil];
    [addNewRoomController addAction:cancelAction];
    [addNewRoomController addAction:addRoom];
    [self presentViewController:addNewRoomController animated:YES completion:nil];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailTableViewController *controller = (DetailTableViewController *)[segue destinationViewController];
        RLMResults<Room*> *rooms = [Room allObjects];
        Room *roomForCell = rooms[indexPath.row];
        
        controller.room = roomForCell;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    RLMResults <Room *> *rooms = [Room allObjects];
    return [rooms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    RLMResults <Room *> *rooms = [Room allObjects];
    Room *roomForPath = rooms[indexPath.row];
    cell.textLabel.text = roomForPath.name;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.rooms removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end

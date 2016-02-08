//
//  DetailTableViewController.m
//  FurnitureTracker
//
//  Created by Thiago Heitling on 2016-02-05.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

#import "DetailTableViewController.h"
#import "Furniture.h"

@interface DetailTableViewController ()

@end

@implementation DetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self.tableView reloadData];
}

- (void)insertNewObject:(id)sender
{
    UIAlertController *addNewFurnitureController = [UIAlertController alertControllerWithTitle:@"New Furniture" message:@"Please enter furniture name:" preferredStyle:UIAlertControllerStyleAlert];
    
    [addNewFurnitureController addTextFieldWithConfigurationHandler:^(UITextField *textFiled)
     {
         textFiled.placeholder = @"room name";
     }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *addFurniture = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        Furniture *newFurniture = [[Furniture alloc] init];
        newFurniture.name = addNewFurnitureController.textFields[0].text;
        newFurniture.room = self.room;
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        [realm beginWriteTransaction];
        [realm addObject:newFurniture];
        [self.room.furnitures addObject:newFurniture];
        [realm commitWriteTransaction];
        [self.tableView reloadData];
        
    }];
    
    [addNewFurnitureController addAction:cancelAction];
    [addNewFurnitureController addAction:addFurniture];
    [self presentViewController:addNewFurnitureController animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.room.furnitures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailViewCell" forIndexPath:indexPath];
    Furniture *furniture = self.room.furnitures[indexPath.row];
    cell.textLabel.text = furniture.name;
    
    return cell;
}

@end

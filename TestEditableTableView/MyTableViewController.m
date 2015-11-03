//
//  MyTableViewController.m
//  TestEditableTableView
//
//  Created by Gonzalo Castro on 11/2/15.
//  Copyright © 2015 Gonzalo Castro. All rights reserved.
//

#import "MyTableViewController.h"
#import "TestCell.h"

@interface MyTableViewController ()
@property (nonatomic, strong) NSMutableArray *section0Data;
@property (nonatomic, strong) NSMutableArray *section1Data;
@end

@implementation MyTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self.tableView registerNib:[UINib nibWithNibName:@"Main" bundle:nil] forCellReuseIdentifier:@"myCustomCell"];

    self.tableView.allowsMultipleSelectionDuringEditing = NO;

    self.section0Data = [NSMutableArray arrayWithArray:@[@"1", @"2", @"3", @"4"]];
    self.section1Data = [NSMutableArray arrayWithArray:@[@"5", @"6", @"7", @"8", @"9", @"10"]];

    UIBarButtonItem *button0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemToSection0:)];
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemToSection1:)];
    self.navigationItem.leftBarButtonItems = @[button0, button1];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

- (void)addItemToSection0:(id)sender
{
    [self.tableView beginUpdates];
    [self increaseCount:self.section0Data];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(self.section0Data.count - 1) inSection:0]]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)addItemToSection1:(id)sender
{
    [self.tableView beginUpdates];
    [self increaseCount:self.section1Data];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(self.section1Data.count - 1) inSection:1]]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)increaseCount:(NSMutableArray *)list
{
    NSString *currentItem = [list lastObject];
    NSInteger n = [currentItem integerValue] + 1;
    [list addObject:[NSString stringWithFormat:@"%ld", (long)n]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numRows = 0;

    if (section == 0)
    {
        numRows = self.section0Data.count;
    }
    else if (section == 1)
    {
        numRows = self.section1Data.count;
    }

    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestCell *cell = (TestCell *)[self.tableView dequeueReusableCellWithIdentifier:@"TestCellIdentifier"];

    if (indexPath.section == 0)
    {
        [cell updateMiddleLabelWithString:[self.section0Data objectAtIndex:indexPath.row]];
    }
    else if (indexPath.section == 1)
    {
        [cell updateMiddleLabelWithString:[self.section1Data objectAtIndex:indexPath.row]];
    }

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - UITableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section %ld", (long)section];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tableView beginUpdates];

        if (indexPath.section == 0)
        {
            [self.section0Data removeObjectAtIndex:indexPath.row];
        }
        else if (indexPath.section == 1)
        {
            [self.section1Data removeObjectAtIndex:indexPath.row];
        }

        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];

        [tableView endUpdates];
    }
}

@end
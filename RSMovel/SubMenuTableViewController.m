//
//  SubMenuTableViewController.m
//  RSMovel
//
//  Created by Marcelo Rezende on 03/10/13.
//  Copyright (c) 2013 Marcelo Alves Rezende. All rights reserved.
//

#import "SubMenuTableViewController.h"
#import "WebViewController.h"
#import "Site.h"

@interface SubMenuTableViewController ()

@end

@implementation SubMenuTableViewController

NSMutableArray *listaDetalhe;
NSMutableArray *listaUrl;
NSMutableDictionary *tmpDict;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[self.secao sites] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
	Site *site = [[self.secao sites] objectAtIndex:indexPath.row];
	cell.textLabel.text = site.tituloSite;
	[cell.textLabel setNumberOfLines:2];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)viewWillAppear:(BOOL)animated
{
	self.title = self.secao.tituloSecao;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"site"])
	{
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		WebViewController *destViewController = segue.destinationViewController;
		Site *site = [[self.secao sites] objectAtIndex:indexPath.row];
		destViewController.tituloSite = site.tituloSite;
		destViewController.urlSite = site.url;
		self.title = @" ";
	}
}

@end

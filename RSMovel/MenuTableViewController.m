//
//  MenuTableViewController.m
//  RSMovel
//
//  Created by Marcelo Alves Rezende on 02/10/13.
//  Copyright (c) 2013 Marcelo Alves Rezende. All rights reserved.
//

#import "MenuTableViewController.h"
#import "SubMenuTableViewController.h"
#import "MenuHelper.h"
#import "Site.h"
#import "WebViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

NSMutableArray *lista;
NSMutableDictionary *tmpDict;
MenuHelper *menu;

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
	
	menu = [[MenuHelper alloc] init];
	
}

- (void)viewWillAppear:(BOOL)animated
{
	self.title = @"RS Móvel";
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
	return [[menu secoes] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
	
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
	Secao *secao = [[menu secoes] objectAtIndex:indexPath.row];
	cell.textLabel.text = secao.tituloSecao;
	if (secao.arquivoIcone != nil)
	{
		cell.imageView.image = [UIImage imageNamed:secao.arquivoIcone];
	}
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"servicos"])
	{
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		SubMenuTableViewController *destViewController = segue.destinationViewController;
		Secao *s = (Secao*)[[menu secoes] objectAtIndex:indexPath.row];
		destViewController.tituloSecao = s.tituloSecao;
		destViewController.secao = s;
		self.title = @" ";
	}
	
	if ([segue.identifier isEqualToString:@"telefones"])
	{
		Site *site = [[Site alloc] initWithTitle:@"Agenda Telefônica" andUrl:@"http://m2.rs.gov.br/site/agenda"];
		WebViewController *destViewController = segue.destinationViewController;
		destViewController.tituloSite = site.tituloSite;
		destViewController.urlSite = site.url;
		self.title = @" ";
	}
}

@end

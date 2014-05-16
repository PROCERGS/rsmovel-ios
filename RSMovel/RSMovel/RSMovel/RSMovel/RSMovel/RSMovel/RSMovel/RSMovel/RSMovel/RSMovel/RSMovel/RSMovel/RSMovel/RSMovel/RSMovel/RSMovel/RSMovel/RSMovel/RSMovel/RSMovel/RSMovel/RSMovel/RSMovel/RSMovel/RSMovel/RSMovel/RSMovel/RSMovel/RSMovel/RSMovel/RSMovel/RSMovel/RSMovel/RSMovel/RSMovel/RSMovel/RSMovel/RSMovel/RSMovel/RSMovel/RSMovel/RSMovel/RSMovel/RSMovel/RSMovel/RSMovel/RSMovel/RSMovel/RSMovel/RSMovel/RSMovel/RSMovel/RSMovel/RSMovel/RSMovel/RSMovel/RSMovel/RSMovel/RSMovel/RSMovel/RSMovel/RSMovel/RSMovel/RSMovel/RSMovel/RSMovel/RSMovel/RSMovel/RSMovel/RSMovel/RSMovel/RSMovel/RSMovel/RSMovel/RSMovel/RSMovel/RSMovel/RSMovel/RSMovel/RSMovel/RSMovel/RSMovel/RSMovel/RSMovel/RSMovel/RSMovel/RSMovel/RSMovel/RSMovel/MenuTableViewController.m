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
#import "Utils.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

NSMutableArray *lista;
NSMutableDictionary *tmpDict;
NSArray *destaquesArray;
MenuHelper *menu;
NSTimer *timer;

NSInteger currentPage;
NSInteger numberOfPages;

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
		
	destaquesArray = [menu destaques];
	
}

- (void)viewWillAppear:(BOOL)animated
{
	self.title = @"RS Móvel";
	
	if (destaquesArray.count > 0) {
		[self setupDestaques];
	} else {
		self.scrollview.frame = CGRectMake(0,0,0,0);
		[self.scrollview removeFromSuperview];
	}

}

- (void)viewWillDisappear:(BOOL)animated
{
	if (timer) {
		[timer invalidate];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
		Site *site = [[Site alloc] initWithTitle:@"Agenda Telefônica" andUrl:@"http://m.rs.gov.br/site/agenda"];
		WebViewController *destViewController = segue.destinationViewController;
		destViewController.tituloSite = site.tituloSite;
		destViewController.urlSite = site.url;
		self.title = @" ";
	}
}






- (void) setupDestaques
{
	numberOfPages = destaquesArray.count;
	NSMutableArray *colorsBG = [@[@"#C93A27", @"#D9A133", @"#BAC927"] mutableCopy];
	NSArray *colorsFG = @[@"#FFFFFF", @"#FFFFFF", @"#FFFFFF"];
	NSUInteger counter = 0;
	for (int x = 0; x < [colorsBG count]; x++) {
		int randInt = (arc4random() % ([colorsBG count] - x)) + x;
		[colorsBG exchangeObjectAtIndex:x withObjectAtIndex:randInt];
	}
	
	
	for (int i = 0; i < destaquesArray.count; i++)
	{
		NSString *corFundo = [colorsBG objectAtIndex:counter];
		NSString *corTexto = [colorsFG objectAtIndex:counter];
		counter++;
		if (counter >= colorsBG.count) {
			counter = 0;
		}
		
		CGRect frame;
		frame.origin.x = self.scrollview.frame.size.width * i;
		frame.size = self.scrollview.frame.size;
		self.scrollview.pagingEnabled = YES;
        
        
        CGRect frameLabel = CGRectMake(5, 5, 310, 70);
        UILabel *msg = [[UILabel alloc] initWithFrame:frameLabel];
		msg.text = [[destaquesArray objectAtIndex:i] objectForKey:@"titulo"];
        msg.numberOfLines = 2;
        msg.lineBreakMode = NSLineBreakByWordWrapping;
        msg.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
		
		msg.textColor = [Utils colorFromHexString:corTexto];
		msg.textAlignment = NSTextAlignmentCenter;
        msg.tag = i;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnLink:)];
        [msg setUserInteractionEnabled:YES];
        [msg addGestureRecognizer:gesture];
        
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.backgroundColor = [Utils colorFromHexString:corFundo];
        [view addSubview:msg];
		
		
		
		[self.scrollview addSubview:view];
		
		
	}
	UIView *linhaBranca = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*destaquesArray.count, 1)];
	linhaBranca.backgroundColor = [Utils colorFromHexString:@"#FFFFFF"];
	[self.scrollview addSubview:linhaBranca];
	
	
	self.scrollview.contentSize =  CGSizeMake(self.scrollview.frame.size.width * destaquesArray.count, self.scrollview.frame.size.height);
    
    timer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(scrollPages) userInfo:Nil repeats:YES];
	[timer fire];
}

- (void)userTappedOnLink:(UIGestureRecognizer*)gestureRecognizer
{
	self.title = @" ";
	WebViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"webview"];
	NSString *tit = [[destaquesArray objectAtIndex:gestureRecognizer.view.tag] objectForKey:@"titulo"];
	NSString *url = [[destaquesArray objectAtIndex:gestureRecognizer.view.tag] objectForKey:@"url"];

	controller.tituloSite = tit;
	controller.urlSite = url;
	[self.navigationController pushViewController:controller animated:YES];
}

-(void)scrollToPage:(NSInteger)aPage{
    float myPageWidth = [self.scrollview frame].size.width;
    [self.scrollview setContentOffset:CGPointMake(aPage*myPageWidth,0) animated:YES];
}

-(void)scrollPages{
    [self scrollToPage:currentPage%numberOfPages];
    currentPage++;
}

@end

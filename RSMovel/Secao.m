//
//  Secao.m
//  RSMovel
//
//  Created by Marcelo Alves Rezende on 04/10/13.
//  Copyright (c) 2013 Marcelo Alves Rezende. All rights reserved.
//

#import "Secao.h"
#import "Site.h"

@implementation Secao

- (id)initWithTitle:(NSString*)t
{
	if (self == [super init])
	{
		self.tituloSecao = t;
		self.sites = [[NSMutableArray alloc] init];
	}
	return self;
}

- (id)initWithTitle:(NSString*)t andIcon:(NSString*)i
{
	if (self == [super init])
	{
		self.tituloSecao = t;
		self.arquivoIcone = i;
		self.sites = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)addSiteWithTitle:(NSString*)s andUrl:(NSString*)u
{
	Site *site = [[Site alloc] initWithTitle:s andUrl:u];
	[self.sites addObject:site];
}

@end

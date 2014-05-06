//
//  Site.m
//  RSMovel
//
//  Created by Marcelo Alves Rezende on 04/10/13.
//  Copyright (c) 2013 Marcelo Alves Rezende. All rights reserved.
//

#import "Site.h"

@implementation Site

- (id) initWithTitle:(NSString*)t andUrl:(NSString*)u
{
	if (self == [super init])
	{
		self.tituloSite = t;
		self.url = u;
	}
	return self;
}

@end

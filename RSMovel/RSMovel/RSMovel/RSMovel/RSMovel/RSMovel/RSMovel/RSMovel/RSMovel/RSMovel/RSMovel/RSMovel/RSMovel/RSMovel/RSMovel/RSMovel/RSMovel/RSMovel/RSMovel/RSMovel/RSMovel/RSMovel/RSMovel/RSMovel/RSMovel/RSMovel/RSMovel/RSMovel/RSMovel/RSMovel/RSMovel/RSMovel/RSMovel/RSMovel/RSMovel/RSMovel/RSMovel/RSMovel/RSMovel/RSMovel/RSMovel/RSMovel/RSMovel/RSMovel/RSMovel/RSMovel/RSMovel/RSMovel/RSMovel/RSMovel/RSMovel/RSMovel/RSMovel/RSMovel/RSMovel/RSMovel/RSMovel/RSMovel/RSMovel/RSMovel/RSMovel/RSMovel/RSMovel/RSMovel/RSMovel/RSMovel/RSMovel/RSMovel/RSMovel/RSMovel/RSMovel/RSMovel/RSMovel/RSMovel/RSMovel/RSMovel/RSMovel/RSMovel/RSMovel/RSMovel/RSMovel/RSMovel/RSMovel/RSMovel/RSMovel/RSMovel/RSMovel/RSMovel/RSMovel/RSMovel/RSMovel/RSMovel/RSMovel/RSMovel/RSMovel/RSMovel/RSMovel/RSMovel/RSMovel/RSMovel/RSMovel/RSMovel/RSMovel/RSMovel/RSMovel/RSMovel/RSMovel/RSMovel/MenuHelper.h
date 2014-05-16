//
//  MenuHelper.h
//  RSMovel
//
//  Created by Marcelo Alves Rezende on 04/10/13.
//  Copyright (c) 2013 Marcelo Alves Rezende. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Secao.h"

@interface MenuHelper : NSObject {
	NSMutableArray *menu;
}

- (id) init;
- (NSArray*) secoes;
- (NSArray*) sitesForSecao:(Secao*)secao;
- (NSArray*) destaques;

@end

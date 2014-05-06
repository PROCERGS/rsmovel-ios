//
//  Secao.h
//  RSMovel
//
//  Created by Marcelo Alves Rezende on 04/10/13.
//  Copyright (c) 2013 Marcelo Alves Rezende. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Secao : NSObject

@property (strong, nonatomic) NSString *tituloSecao;
@property (strong, nonatomic) NSString *arquivoIcone;
@property (strong, nonatomic) NSMutableArray *sites;

- (id)initWithTitle:(NSString*)t;
- (id)initWithTitle:(NSString*)t andIcon:(NSString*)i;
- (void)addSiteWithTitle:(NSString*)s andUrl:(NSString*)u;


@end

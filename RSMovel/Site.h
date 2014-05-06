//
//  Site.h
//  RSMovel
//
//  Created by Marcelo Alves Rezende on 04/10/13.
//  Copyright (c) 2013 Marcelo Alves Rezende. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Site : NSObject
@property (strong, nonatomic) NSString *tituloSite;
@property (strong, nonatomic) NSString *url;

- (id) initWithTitle:(NSString*)t andUrl:(NSString*)u;

@end

//
//  SubMenuTableViewController.h
//  RSMovel
//
//  Created by Marcelo Rezende on 03/10/13.
//  Copyright (c) 2013 Marcelo Alves Rezende. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Secao.h"

@interface SubMenuTableViewController : UITableViewController

@property (strong, nonatomic) NSString *tituloSecao;
@property (strong, nonatomic) Secao *secao;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

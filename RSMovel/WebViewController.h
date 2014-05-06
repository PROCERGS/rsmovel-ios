//
//  WebViewController.h
//  RSMovel
//
//  Created by Marcelo Alves Rezende on 02/10/13.
//  Copyright (c) 2013 Marcelo Alves Rezende. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property (strong, nonatomic) NSString *tituloSite;
@property (strong, nonatomic) NSString *urlSite;

@end

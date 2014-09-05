//
//  WebViewController.m
//  RSMovel
//
//  Created by Marcelo Alves Rezende on 02/10/13.
//  Copyright (c) 2013 Marcelo Alves Rezende. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.webview.delegate = self;
		
	//NSURL *url = [NSURL URLWithString:[self.urlSite stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	//NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:url];
	//[requestObj setHTTPShouldHandleCookies:YES];
	
	//[self.webview loadRequest:requestObj];
	
	self.title = self.tituloSite;
	
}

- (void)viewWillAppear:(BOOL)animated
{
	NSArray                 *cookies;
    NSDictionary            *cookieHeaders;
    NSMutableURLRequest     *request;
	
	NSURL *url = [NSURL URLWithString:[self.urlSite stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
    cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage ] cookiesForURL: url];
    if (!cookies) {
        return;
    }
	
    cookieHeaders = [NSHTTPCookie requestHeaderFieldsWithCookies: cookies];
    request = [[NSMutableURLRequest alloc] initWithURL: url];
    [request setValue: [cookieHeaders objectForKey: @"Cookie"] forHTTPHeaderField: @"Cookie"];
    [self.webview loadRequest: request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{	
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	
	NSString *jsCommand = [NSString stringWithFormat:
						   @"var elBarra = document.getElementById('%@'); elBarra.parentElement.removeChild(elBarra); $('header').remove();", @"barraGoverno"];
	[self.webview stringByEvaluatingJavaScriptFromString:jsCommand];
	
	
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self.indicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



@end

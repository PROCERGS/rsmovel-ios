//
//  Utils.m
//  RSMovel
//
//  Created by Marcelo Alves Rezende on 14/05/14.
//  Copyright (c) 2014 Marcelo Alves Rezende. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end

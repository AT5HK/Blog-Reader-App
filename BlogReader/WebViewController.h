//
//  WebViewController.h
//  BlogReader
//
//  Created by Auston Salvana on 5/30/15.
//  Copyright (c) 2015 Amit Bijlani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet NSURL *blogPostURL;


@end

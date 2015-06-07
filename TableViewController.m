//
//  TableViewController.m
//  BlogReader
//
//  Created by Amit Bijlani on 12/6/12.
//  Copyright (c) 2012 Amit Bijlani. All rights reserved.
//

#import "TableViewController.h"
#import "BlogPost.h"
#import "WebViewController.h"

NSString *const kAuthor = @"Author";
NSString *const kTitle = @"Title";

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    NSURL *blogURL = [NSURL URLWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary/"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:blogURL];
    
    NSError *error = nil;
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    self.blogPosts = [NSMutableArray array];

    NSArray *blogPostsArray = dataDictionary[@"posts"];
    
    for (NSDictionary *bpDictionary in blogPostsArray) {
        
        BlogPost *blogPost = [BlogPost blogPostWithTitle:bpDictionary[@"title"]];
        blogPost.author = bpDictionary[@"author"];
        blogPost.thumbnail = bpDictionary[@"thumbnail"];
        blogPost.date = bpDictionary[@"date"];
        blogPost.url = [NSURL URLWithString:bpDictionary[@"url"]];
        [self.blogPosts addObject:blogPost];
                              
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    
    return [self.blogPosts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    BlogPost *blogPost = self.blogPosts[indexPath.row];
    
    if ([blogPost.thumbnail isKindOfClass:[NSString class]]) {
    
        NSData*imageData = [NSData dataWithContentsOfURL:blogPost.thumbnailURL];
        UIImage*image = [UIImage imageWithData:imageData];
    
        cell.imageView.image = image;
    }
        else{
            cell.imageView.image = [UIImage imageNamed:@"space.png"];
        }
    
    cell.textLabel.text = blogPost.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Author: %@, Date: %@",blogPost.author, [blogPost formattedDate]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showBlogPost"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BlogPost*blogPost = self.blogPosts[indexPath.row];
        WebViewController*wbc = (WebViewController*)segue.destinationViewController;
        wbc.blogPostURL = blogPost.url;
        
//        [segue.destinationViewController setBlogPostURL:blogPost.url];
    }
    
    NSLog(@"preparing for segue: %@",segue.identifier);
    
}


@end

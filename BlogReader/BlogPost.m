//
//  BlogPost.m
//  BlogReader
//
//  Created by Auston Salvana on 5/30/15.
//  Copyright (c) 2015 Amit Bijlani. All rights reserved.
//

#import "BlogPost.h"

@implementation BlogPost

-(id)initWithTitle:(NSString*)title{
    
    self = [super init];
    
    if (self) {
        
        _title = title;
        self.thumbnail = nil;
        self.author = nil;
        
    }
    
    return self;
}

+(id)blogPostWithTitle:(NSString*)title{
    
    return [[self alloc] initWithTitle:title];
}


-(NSURL *)thumbnailURL{
//    NSLog(@"%@", [self.thumbnail class]);
    return [NSURL URLWithString:self.thumbnail];
}


-(NSString*)formattedDate{
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate*tempDate = [dateFormatter dateFromString:self.date];
    
    [dateFormatter setDateFormat:@"EE MMM, dd"];
    return [dateFormatter stringFromDate:tempDate];
}

@end

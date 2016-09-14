//
//  API.m
//  AppChat
//
//  Created by ThanhSon on 9/13/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "API.h"

@implementation API


+ (void)getLoginDtoprocessAPI:(NSString* )route
                             method:(NSString* )method
                             header:(NSDictionary*)headers
                               body:(UserDto*)body {
    // connect server
    NSString * strUrl = [NSString stringWithFormat:@"%@",route];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    
    // route
    request.URL = [NSURL URLWithString:strUrl];
    
    // header
//    NSMutableDictionary *allHeader = [[NSMutableDictionary alloc]init];
//    [allHeader setObject:@"application/json" forKey:@"Content-Type"];
//    [allHeader addEntriesFromDictionary:headers];
//    request.allHTTPHeaderFields = headers;
    
    //method
    request.HTTPMethod = method;
    
    //body
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    NSString *strEmail = [NSString stringWithFormat:@"aabccdef4@gmail.com"];
    [dic setObject:strEmail forKey:@"email"];
    [dic setObject:@"Aa12345" forKey:@"password"];

    NSData *dicBody = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    request.HTTPBody = dicBody ;

    
    void (^successCallback)(id data) = ^(id data) {
        NSMutableDictionary *respondData = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
        NSMutableDictionary *results = [respondData objectForKey:@"results"];
        NSLog(@"");
        
    };
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        successCallback(data);
        
    }] resume];
}

@end

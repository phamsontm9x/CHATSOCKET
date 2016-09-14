//
//  API.m
//  AppChat
//
//  Created by ThanhSon on 9/13/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "API.h"

#define server @"http://52.221.225.151:3000/user/login"

@implementation API


+ (void)getLoginDtoprocessAPI:(NSString* )route
                       method:(NSString* )method
                       header:(NSDictionary*)headers
                         body:(LoginDto*)body callback:(APICallback)callback{
    // connect server
    NSString * strUrl = [NSString stringWithFormat:@"%@",route];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    
    // route
    request.URL = [NSURL URLWithString:strUrl];
    
    // header
//    NSMutableDictionary *allHeader = [[NSMutableDictionary alloc]init];
//    [allHeader setObject:@"application/json" forKey:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
//    [allHeader addEntriesFromDictionary:headers];
//    request.allHTTPHeaderFields = headers;
    
    //method
//    request.HTTPMethod = method;
    
    //body
//    NSDictionary *dicBody = [body getJSONObject];
//    NSString *strEmail = [NSString stringWithFormat:@"aabccdef4@gmail.com"];
//    [dic setObject:strEmail forKey:@"email"];
//    [dic setObject:@"Aa12345" forKey:@"password"];
//    NSMutableString *json = [NSMutableString stringWithString:@"{"];
//    [json appendFormat:@"email: %@,",email];
//    [json appendFormat:@"password: %@",password];
//    [json appendFormat:@"}"];
    
    NSMutableString *json = [NSMutableString stringWithFormat:@"email=%@&password=%@",body.email,body.password];
    NSData *dataBody =  [json dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    request.HTTPBody = dataBody ;
    
    void (^successCallback)(id data) = ^(id data) {
        NSMutableDictionary *respondData = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
        NSMutableDictionary *results = [respondData objectForKey:@"results"];
        NSLog(@"");
        
    };
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        id dataResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        successCallback(data);
        
    }] resume];
}

//- (void)login:(LoginDto *)data callback:(APICallback)callback {
//    [self getLoginDtoprocessAPI:server method:@"POST" header:nil body:data];
//}

@end

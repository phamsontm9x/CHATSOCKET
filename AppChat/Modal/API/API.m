//
//  API.m
//  AppChat
//
//  Created by ThanhSon on 9/13/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "API.h"

#define server @"http://52.221.225.151:3000"

@implementation API


+ (void)getLoginDtoprocessAPI:(NSString* )route
                       method:(NSString* )method
                       header:(NSDictionary*)headers
                         body:(LoginDto*)body callback:(APICallback)callback{
    // connect server
    NSString * strUrl = [NSString stringWithFormat:@"%@/%@",server,route];
    
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
        callback(YES,results);
        
    };
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        id dataResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        successCallback(data);
        
    }] resume];
}

+ (void)getRegisterDtoprocessAPI:(NSString* )route
                          method:(NSString* )method
                          header:(NSDictionary*)headers
                            body:(SignDto*)body callback:(APICallback)callback {
    NSString * strUrl = [NSString stringWithFormat:@"%@/%@",server,route];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    
    // route
    request.URL = [NSURL URLWithString:strUrl];
    // header
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    //email=aabccdef3%40gmail.com&password=Aa12345&phone=0978506324&image=&birthday=1996-04-02&gender=false
    NSMutableString *json = [NSMutableString stringWithFormat:@"email=%@&password=%@&phone=%@&image=%@&birthday=%@&gender=%@",
                             body.email,
                             body.password,
                             body.phone,
                             body.image,
                             body.birthday,
                             body.gender];
    NSData *dataBody =  [json dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    request.HTTPBody = dataBody ;
    
    void (^successCallback)(id data) = ^(id data) {
        NSMutableDictionary *respondData = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
        NSMutableDictionary *results = [respondData objectForKey:@"results"];
        callback(YES,results);
        
    };
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        id dataResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

        successCallback(data);
        
    }] resume];

}


@end

//
//  API.m
//  AppChat
//
//  Created by ThanhSon on 9/13/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "API.h"

@implementation API


+ (LoginDto *)getLoginDtoprocessAPI:(NSString* )route
                             method:(NSString* )method
                             header:(NSDictionary*)headers
                               body:(UserDto*)body {
    // connect server
    NSString * strUrl = [NSString stringWithFormat:@"%@",route];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    
    // route
    request.URL = [NSURL URLWithString:strUrl];
    
    // header
    request.allHTTPHeaderFields = headers;
    
    //method
    request.HTTPMethod = method;
    
    //body
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"aabccdef4@gmail.com" forKey:@"email"];
    [dic setObject:@"Aa12345" forKey:@"password"];


    NSData *dicBody = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    request.HTTPBody = dicBody ;
    

//    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
////        dispatch_async(dispatch_get_main_queue(), ^{
////            if(!error && data) {
////                NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:nil];
////                NSMutableDictionary *results = [jsonArray objectForKey:@"results"];
//////                NSString * username = [jsonArray objectForKey:@"username"];
//////                NSString * password = [jsonArray objectForKey:@"password"];
//////                NSLog(@"Username :%@, Password :%@",username,password);
////                NSLog(@"");
////            }
//        
//            // Other Case, Failed
////        });
//        NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:nil];
//        NSMutableDictionary *results = [jsonArray objectForKey:@"results"];
//         NSLog(@"");
//        
//    }] resume];
    
    
    void (^successCallback)(id data) = ^(id data) {
        NSMutableDictionary *respondData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary *results = [respondData objectForKey:@"results"];
        NSLog(@"");
        
    };
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!error && data) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                if(httpResponse) {
                    NSInteger code = httpResponse.statusCode;
                    if(code == 200) {
                        successCallback(data);
                        
                    } else {
                        // Reset App and reLogin
                        return;
                    }
                }
            }
            
            // Other Case, Failed
        });
        
    }] resume];

    
    LoginDto * login;
    
    return login;
}

@end

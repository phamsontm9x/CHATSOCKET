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
    [dic setObject:body.username forKey:@"username"];
    [dic setObject:body.password forKey:@"password"];

    NSData *dicBody = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    request.HTTPBody = dicBody;
    
//    NSMutableDictionary *respondData = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingMutableContainers error:nil];
//    
//    NSURLResponse *response;
//    NSError *error;
//    
//    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    void (^successCallback)(id data) = ^(id data) {
        NSMutableDictionary *respondData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if(respondData) {
            BOOL serviceSuccess = [[respondData objectForKey:@"success"] boolValue];
        }
        // Other Case Error
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

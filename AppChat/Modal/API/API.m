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
    
    NSMutableString *json = [NSMutableString stringWithFormat:@"email=%@&password=%@",body.email,body.password];
    NSData *dataBody =  [json dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    request.HTTPBody = dataBody ;
    
    void (^successCallback)(id data) = ^(id data) {
        NSMutableDictionary *respondData = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
        NSMutableDictionary *statuscode = [respondData objectForKey:@"statuscode"];
        NSMutableDictionary *results = [respondData objectForKey:@"results"];
        NSString * stt = [NSString stringWithFormat:@"%@",statuscode];
        if ([stt isEqual:@"404"]) {
            callback(NO,results);
        } else {
            callback(YES,results);
        }
    };
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
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
    NSMutableString *json = [NSMutableString stringWithFormat:@"email=%@&password=%@&phone=%@&image=%@&birthday=%@&gender=%@&name=%@",
                             body.email,
                             body.password,
                             body.phone,
                             body.image,
                             body.birthday,
                             body.gender,
                             body.name];
    NSData *dataBody =  [json dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    request.HTTPBody = dataBody ;
    
    void (^successCallback)(id data) = ^(id data) {
        NSMutableDictionary *respondData = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
        NSMutableDictionary *statuscode = [respondData objectForKey:@"statuscode"];
        NSMutableDictionary *results = [respondData objectForKey:@"results"];
        NSString * stt = [NSString stringWithFormat:@"%@",statuscode];
        if ([stt isEqual:@"404"]) {
            callback(NO,results);
        } else {
            callback(YES,results);
        }
        
    };
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        successCallback(data);
        
    }] resume];
}

+ (void)getListRoomDtoprocessAPI:(NSString* )route
                          method:(NSString* )method
                          header:(NSDictionary*)headers
                        callback:(APICallback)callback {
    NSString * strUrl = [NSString stringWithFormat:@"%@/%@",server,route];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    
    // route
    request.URL = [NSURL URLWithString:strUrl];
    // header
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    // method
    request.HTTPMethod = method; 

    void (^successCallback)(id data) = ^(id data) {
        NSMutableDictionary *respondData = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
        NSMutableDictionary *statuscode = [respondData objectForKey:@"statuscode"];
        NSMutableDictionary *results = [respondData objectForKey:@"results"];
        NSString * stt = [NSString stringWithFormat:@"%@",statuscode];
        if ([stt isEqual:@"404"]) {
            callback(NO,results);
        } else {
            callback(YES,results);
        }
        
    };
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        successCallback(data);
        
    }] resume];
}

+ (void)getCreateRoomDtoprocessAPI:(NSString* )route
                            method:(NSString* )method
                            header:(NSDictionary*)headers
                              body:(RoomDto*)body callback:(APICallback)callback {
    
    NSString * strUrl = [NSString stringWithFormat:@"%@/%@",server,route];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    
    // route
    request.URL = [NSURL URLWithString:strUrl];
    // header
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    //owner=57daccd90d455841a68d71be&name=ten+room&slogan=slogan
    NSMutableString *json = [NSMutableString stringWithFormat:@"owner=%@&name=%@&slogan=%@",
                             body.idOwner,
                             body.name,
                             body.slogan];
    
    NSData *dataBody =  [json dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    request.HTTPBody = dataBody ;
    
    void (^successCallback)(id data) = ^(id data) {
        NSMutableDictionary *respondData = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
        NSMutableDictionary *statuscode = [respondData objectForKey:@"statuscode"];
        NSMutableDictionary *results = [respondData objectForKey:@"results"];
        NSString * stt = [NSString stringWithFormat:@"%@",statuscode];
        if ([stt isEqual:@"404"]) {
            callback(NO,results);
        } else {
            callback(YES,results);
        }
        
    };
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        successCallback(data);
        
    }] resume];
}

+ (void)getUserDtorocessAPI:(NSString* )route
                     method:(NSString* )method
                     header:(NSDictionary*)headers
                   callback:(APICallback)callback {
    NSString * strUrl = [NSString stringWithFormat:@"%@/%@",server,route];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    
    // route
    request.URL = [NSURL URLWithString:strUrl];
    // header
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    // method
    request.HTTPMethod = method;
    
    void (^successCallback)(id data) = ^(id data) {
        NSMutableDictionary *respondData = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
        NSMutableDictionary *statuscode = [respondData objectForKey:@"statuscode"];
        NSMutableDictionary *results = [respondData objectForKey:@"results"];
        NSString * stt = [NSString stringWithFormat:@"%@",statuscode];
        if ([stt isEqual:@"404"]) {
            callback(NO,results);
        } else {
            callback(YES,results);
        }
        
    };
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        successCallback(data);
        
    }] resume];
}

+ (void)getChangeBackgroundrocessAPI:(NSString* )route
                              method:(NSString* )method
                              header:(NSDictionary*)headers
                                body:(NSString*)body callback:(APICallback)callback {
    NSString * strUrl = [NSString stringWithFormat:@"%@/%@",server,route];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    
    // route
    request.URL = [NSURL URLWithString:strUrl];
    // header
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    // method
    request.HTTPMethod = method;
    
    NSMutableString *json = [NSMutableString stringWithFormat:@"background=%@",
                             body];
    
    NSData *dataBody =  [json dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    request.HTTPBody = dataBody ;
    
    void (^successCallback)(id data) = ^(id data) {
        NSMutableDictionary *respondData = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
        NSMutableDictionary *statuscode = [respondData objectForKey:@"statuscode"];
        NSMutableDictionary *results = [respondData objectForKey:@"results"];
        NSString * stt = [NSString stringWithFormat:@"%@",statuscode];
        if ([stt isEqual:@"404"]) {
            callback(NO,results);
        } else {
            callback(YES,results);
        }
        
    };
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        successCallback(data);
        
    }] resume];

}

@end

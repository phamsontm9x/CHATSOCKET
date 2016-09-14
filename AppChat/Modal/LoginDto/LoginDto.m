//
//  LoginDto.m
//  AppChat
//
//  Created by ThanhSon on 9/13/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "LoginDto.h"

@implementation LoginDto

- (id)initWithData: (NSDictionary * )dic {
    self = [super init];
    
    _email = [dic objectForKey:@"email"];
    _password = [dic objectForKey:@"password"];
    
    return self;
}

- (NSDictionary *)getJSONObject {
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:_email forKey:@"email"];
    [dic setObject:_password forKey:@"password"];
    
    return dic;
}


@end

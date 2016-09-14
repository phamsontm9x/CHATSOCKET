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
    
    self.email = [dic objectForKey:@"email"];
    self.password = [dic objectForKey:@"password"];
    
    return self;
}

- (NSDictionary *)getJSONOject {
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:_email forKey:@"email"];
    [dic setObject:_password forKey:@"_password"];
    
    return dic;
}


@end

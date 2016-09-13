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
    
    self.username = [dic objectForKey:@"username"];
    self.password = [dic objectForKey:@"password"];
    
    return self;
}

@end

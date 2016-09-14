//
//  SignDto.m
//  AppChat
//
//  Created by ThanhSon on 9/13/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "SignDto.h"

@implementation SignDto

- (id)initWithData: (NSDictionary * )dic {
    self = [super init];
    
    _email = [dic objectForKey:@"email"];
    _password = [dic objectForKey:@"password"];
    _phone = [dic objectForKey:@"phone"];
    _image = [dic objectForKey:@"image"];
    _birthday = [dic objectForKey:@"birthday"];
    _gender = [dic objectForKey:@"gender"];
    
    return self;
}

- (NSDictionary *)getJSONOject {
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:_email forKey:@"email"];
    [dic setObject:_password forKey:@"_password"];
    [dic setObject:_phone forKey:@"phone"];
    [dic setObject:_image forKey:@"image"];
    [dic setObject:_birthday forKey:@"birtday"];
    [dic setObject:_gender forKey:@"gender"];
    
    return dic;
}


@end

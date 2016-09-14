//
//  UserDto.m
//  AppChat
//
//  Created by ThanhSon on 9/13/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "UserDto.h"

@implementation UserDto

- (id)initWithData: (NSDictionary * )dic {
    self = [super init];
    
    _idUser = [dic objectForKey:@"_id"];
    _avatar = [dic objectForKey:@"avatar"];
    _background = [dic objectForKey:@"background"];
    _birthday = [dic objectForKey:@"birthday"];
    _email = [dic objectForKey:@"email"];
    _phone = [dic objectForKey:@"phone"];
    _gender = [dic objectForKey:@"gender"];
    
    return self;
}

- (NSDictionary *)getJSONOject {
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:_idUser forKey:@"_id"];
    [dic setObject:_avatar forKey:@"avatar"];
    [dic setObject:_background forKey:@"background"];
    [dic setObject:_birthday forKey:@"birthday"];
    [dic setObject:_email forKey:@"email"];
    [dic setObject:_phone forKey:@"phone"];
    [dic setObject:_gender forKey:@"gender"];
    
    return dic;
}
@end

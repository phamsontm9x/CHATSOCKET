//
//  UserDto.m
//  AppChat
//
//  Created by ThanhSon on 9/13/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "UserDto.h"

@implementation UserDto

- (UserDto*)initWithData: (NSDictionary * )dic {
    UserDto * data = [[UserDto alloc]init];
    data.idUser = [dic objectForKey:@"_id"];
    data.avatar = [dic objectForKey:@"avatar"];
    data.background = [dic objectForKey:@"background"];
    data.birthday = [dic objectForKey:@"birthday"];
    data.email = [dic objectForKey:@"email"];
    data.phone = [dic objectForKey:@"phone"];
    data.gender = [dic objectForKey:@"gender"];
    
    return data;
}

- (NSDictionary *)getJSONObject {
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

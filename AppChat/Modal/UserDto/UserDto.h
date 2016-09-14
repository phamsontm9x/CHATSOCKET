//
//  UserDto.h
//  AppChat
//
//  Created by ThanhSon on 9/13/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDto : NSObject

@property (nonatomic ,strong) NSString *idUser;
@property (nonatomic ,strong) NSString *avatar;
@property (nonatomic ,strong) NSString *background;
@property (nonatomic ,strong) NSString *birthday;
@property (nonatomic ,strong) NSString *email;
@property (nonatomic ,strong) NSString *phone;
@property (nonatomic ,strong) NSString *gender;

- (NSDictionary*) getJSONObject;

@end

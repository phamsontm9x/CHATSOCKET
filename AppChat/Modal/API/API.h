//
//  API.h
//  AppChat
//
//  Created by ThanhSon on 9/13/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LoginDto.h"
#import "UserDto.h"
#import "SignDto.h"

typedef void (^APICallback)(BOOL success, id data);

@interface API : NSObject


+ (void)getLoginDtoprocessAPI:(NSString* )route
                             method:(NSString* )method
                             header:(NSDictionary*)headers
                               body:(LoginDto*)body callback:(APICallback)callback;

+ (void)getRegisterDtoprocessAPI:(NSString* )route
                       method:(NSString* )method
                       header:(NSDictionary*)headers
                         body:(SignDto*)body callback:(APICallback)callback;


@end

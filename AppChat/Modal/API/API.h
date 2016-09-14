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

@interface API : NSObject

+ (void)getLoginDtoprocessAPI:(NSString* )route
                             method:(NSString* )method
                             header:(NSDictionary*)headers
                               body:(UserDto*)body;

@end

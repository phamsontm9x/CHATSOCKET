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
#import "RoomDto.h"

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

+ (void)getListRoomDtoprocessAPI:(NSString* )route
                          method:(NSString* )method
                          header:(NSDictionary*)headers
                        callback:(APICallback)callback;

+ (void)getCreateRoomDtoprocessAPI:(NSString* )route
                           method:(NSString* )method
                           header:(NSDictionary*)headers
                             body:(RoomDto*)body callback:(APICallback)callback;

+ (void)getUserDtorocessAPI:(NSString* )route
                          method:(NSString* )method
                          header:(NSDictionary*)headers
                        callback:(APICallback)callback;

+ (void)getChangeBackgroundrocessAPI:(NSString* )route
                            method:(NSString* )method
                            header:(NSDictionary*)headers
                              body:(NSString*)body callback:(APICallback)callback;


@end

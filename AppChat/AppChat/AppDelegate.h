//
//  AppDelegate.h
//  AppChat
//
//  Created by Hungpv on 9/13/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SocketIO;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong ,nonatomic) NSString *strUserName;
@property (strong ,nonatomic) NSString *strGender;
@property (strong ,nonatomic) NSString *strBrithday;
@property (strong ,nonatomic) NSString *strUserID;
@property (strong ,nonatomic) NSString *strEmail;
@property (strong ,nonatomic) NSString *strRoomID;
@property (strong ,nonatomic) NSString *strImage;

// socketIO
@property SocketIOClient * socket;



@end


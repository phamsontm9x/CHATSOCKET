//
//  LoginVC.h
//  AppChat
//
//  Created by ThanhSon on 9/15/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "API.h"
#import "AppDelegate.h"

#import "UserDto.h"
#import "LoginDto.h"
#import "SignDto.h"

#import "activityViewController.h"
#import "RegisterVC.h"
#import "RoomListVC.h"

@interface LoginVC : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *tfUserName;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;

@end

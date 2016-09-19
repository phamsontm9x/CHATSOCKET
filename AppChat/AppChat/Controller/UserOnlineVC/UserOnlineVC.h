//
//  UserOnlineVC.h
//  AppChat
//
//  Created by ThanhSon on 9/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "activityViewController.h"
#import "ProfileVC.h"

#import "UserDto.h"
#import "API.h"

#import "AppDelegate.h"

@interface UserOnlineVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblNumberUser;
@property (weak, nonatomic) IBOutlet UITableView *tbvUserOnline;

@property (strong, nonatomic) NSMutableArray* arrUser;

@end

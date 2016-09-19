//
//  ProfileVC.h
//  AppChat
//
//  Created by ThanhSon on 9/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "API.h"
#import "UserDto.h"

#import "AppDelegate.h"

#import "activityViewController.h"

@interface ProfileVC : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) UserDto * User;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthday;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthdaySt;
@property (weak, nonatomic) IBOutlet UIButton *btnIcon;

@property (weak, nonatomic) UIImage *imgUser;
@property (nonatomic, strong) NSString *strImgae;


@end

//
//  SignDto.h
//  AppChat
//
//  Created by ThanhSon on 9/13/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignDto : NSObject

@property (nonatomic ,strong) NSString * email;
@property (nonatomic ,strong) NSString * password;
@property (nonatomic ,strong) NSString * phone;
@property (nonatomic ,strong) NSString * image;
@property (nonatomic ,strong) NSString * birthday;
@property (nonatomic ,strong) NSString * gender;
@property (nonatomic ,strong) NSString * name;

- (NSDictionary*) getJSONObject;

@end

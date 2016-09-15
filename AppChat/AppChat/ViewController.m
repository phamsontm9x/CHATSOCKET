//
//  ViewController.m
//  AppChat
//
//  Created by Hungpv on 9/13/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "ViewController.h"

#import "API.h"

#import "UserDto.h"
#import "LoginDto.h"
#import "SignDto.h"

#define serverLogin @"user/login"
#define serverRegister @"user/register"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)create {
    NSURL* url = [[NSURL alloc] initWithString:@"http://localhost:8080"];
    SocketIOClient* socket = [[SocketIOClient alloc] initWithSocketURL:url config:@{@"log": @YES, @"forcePolling": @YES}];
    
    [socket on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected");
    }];
    
    [socket on:@"currentAmount" callback:^(NSArray* data, SocketAckEmitter* ack) {
        double cur = [[data objectAtIndex:0] floatValue];
        
        [socket emitWithAck:@"canUpdate" withItems:@[@(cur)]](0, ^(NSArray* data) {
            [socket emit:@"update" withItems:@[@{@"amount": @(cur + 2.50)}]];
        });
        
        [ack with:@[@"Got your currentAmount, ", @"dude"]];
    }];
    
    [socket connect];

}
- (IBAction)onClickedLogin:(UIButton *)btn {
    LoginDto * loginDto = [[LoginDto alloc]init];
    loginDto.email = @"admin@gmail.com";
    loginDto.password = @"Aa12345";
    [API getLoginDtoprocessAPI:serverLogin method:@"POST" header:nil body:loginDto callback:^(BOOL success, id data) {
        if(success) {
            NSLog(@"");
        }
    }];
    NSLog(@"");
}

- (IBAction)onClickedRegister:(UIButton *)btn {
    SignDto * signDto = [[SignDto alloc]init];
    signDto.email = @"admin@gmail.com";
    signDto.password = @"Aa12345";
    signDto.phone = @"0978506324";
    signDto.image = @"Sondeptrai";
    signDto.birthday = @"1996-04-02";
    signDto.gender = @"false";
    
    [API getRegisterDtoprocessAPI:serverRegister method:@"POST" header:nil body:signDto callback:^(BOOL success, id data) {
        if(success) {
            NSLog(@"");
        }
    }];
    
}

@end

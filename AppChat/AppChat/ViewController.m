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
    UserDto * userDto = [[UserDto alloc]init];
    userDto.username = @"aabccdef4@gmail.com";
    userDto.password = @"Aa12345";
    LoginDto * loginDto = [API getLoginDtoprocessAPI:@"http://52.221.225.151:3000/user/login" method:@"POST" header:nil body:userDto];
    NSLog(@"%@",loginDto.username);
}

@end

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

#define server @"http://52.221.225.151:3000/user/login"


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
    loginDto.email = @"aabccdef4@gmail.com";
    loginDto.password = @"Aa12345";
    [API getLoginDtoprocessAPI:server method:@"POST" header:nil body:loginDto callback:^(BOOL success, UserDto* data) {
        if(success) {
            NSLog(@"%@",data.email);
        }
    }];
    NSLog(@"");
}

@end

//
//  RegisterVC.m
//  AppChat
//
//  Created by ThanhSon on 9/15/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "RegisterVC.h"
#import "RegisterFinishVC.h"

@implementation RegisterVC {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma init


#pragma Action Button


- (IBAction)onClickedNext:(UIButton *)btn {
    //    SignDto * signDto = [[SignDto alloc]init];
    //    signDto.email = @"admin@gmail.com";
    //    signDto.password = @"Aa12345";
    //    signDto.phone = @"0978506324";
    //    signDto.image = @"Sondeptrai";
    //    signDto.birthday = @"1996-04-02";
    //    signDto.gender = @"false";
    //
    //    [API getRegisterDtoprocessAPI:serverRegister method:@"POST" header:nil body:signDto callback:^(BOOL success, id data) {
    //        if(success) {
    //            NSLog(@"");
    //        }
    //    }];
    
    RegisterFinishVC *vRegisterFinish =[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterFinishVC"];
    [self presentViewController:vRegisterFinish animated:NO completion:nil];
}

- (IBAction)onClickedHaveAcount:(UIButton *)btn {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end

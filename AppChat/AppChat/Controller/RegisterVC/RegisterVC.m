//
//  RegisterVC.m
//  AppChat
//
//  Created by ThanhSon on 9/15/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "RegisterVC.h"
#import "RegisterFinishVC.h"
#import "SignDto.h"

@implementation RegisterVC {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createTapdismissKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma init


#pragma Action Button


- (IBAction)onClickedNext:(UIButton *)btn {
    
    RegisterFinishVC *vRegisterFinish =[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterFinishVC"];
        vRegisterFinish.email = _tfUserName.text ;
        vRegisterFinish.password = _tfPassword.text;
    [self.navigationController pushViewController:vRegisterFinish animated:NO];
}

- (IBAction)onClickedHaveAcount:(UIButton *)btn {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark -Delegate UITextField

- (void)createTapdismissKeyboard {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

@end

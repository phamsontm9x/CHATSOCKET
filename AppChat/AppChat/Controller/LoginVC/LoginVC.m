//
//  LoginVC.m
//  AppChat
//
//  Created by ThanhSon on 9/15/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "LoginVC.h"

#define serverLogin @"user/login"


@implementation LoginVC {
    activityViewController *_activityView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createActivity];
    [self createTapdismissKeyboard];
    _tfUserName.text=@"thanhsoncun1@gmail.com";
    _tfPassword.text=@"Thanhson1";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma CreateLoading

-(void)createActivity{
    _activityView = [[[NSBundle mainBundle] loadNibNamed:@"activityView" owner:self options:nil] lastObject];
    [_activityView setFrame:CGRectMake(0, 0, 375, 677)];
    [self.view addSubview:_activityView];
    _activityView.hidden = YES;
    
}

- (void)controlActivity: (BOOL)control{
    if (control == YES) {
        _activityView.hidden = NO;
    } else {
        _activityView.hidden = YES;
    }
}


#pragma Action Button

- (IBAction)onClickedLogin:(UIButton *)btn {
    [self controlActivity:YES];
    LoginDto * loginDto = [[LoginDto alloc]init];
    loginDto.email = _tfUserName.text;
    loginDto.password = _tfPassword.text;
    [API getLoginDtoprocessAPI:serverLogin method:@"POST" header:nil body:loginDto callback:^(BOOL success, id data) {
        dispatch_async(dispatch_get_main_queue(), ^(){
            [self controlActivity:NO];
            NSString *mess ;
            if (success) {
                mess = @"Login success";
                 ((AppDelegate*)[UIApplication sharedApplication].delegate).strUserID = [data objectForKey:@"_id"];
                 ((AppDelegate*)[UIApplication sharedApplication].delegate).strEmail = [data objectForKey:@"email"];
                ((AppDelegate*)[UIApplication sharedApplication].delegate).strImage = [data objectForKey:@"image"];
            } else {
                mess =@"Username or password not correct";
            }
            UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"Warring"
                                                                           message:mess
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *OK =[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          if (success){
                                                              RoomListVC *vRoomList =[self.storyboard instantiateViewControllerWithIdentifier:@"RoomListVC"];
                                                              [self.navigationController pushViewController:vRoomList animated:YES];
                                                          }
                                                      }];
            [alert addAction:OK];
            [self presentViewController:alert animated:YES completion:nil];

        });
    }];
}

- (IBAction)onClickedRegister:(UIButton *)btn {
    RegisterVC *vRegister =[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterVC"];
    [self.navigationController pushViewController:vRegister animated:YES];
}

- (IBAction)onClickedForgotPassword:(UIButton *)btn {

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

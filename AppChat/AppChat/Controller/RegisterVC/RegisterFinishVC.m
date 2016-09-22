//
//  RegisterFinishVC.m
//  AppChat
//
//  Created by ThanhSon on 9/15/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "RegisterFinishVC.h"
#import "AppDelegate.h"


@implementation RegisterFinishVC {
    activityViewController *_activityView;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createActivity];
    [self createTapdismissKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    _tfFullName.text =  ((AppDelegate*)[UIApplication sharedApplication].delegate).strUserName;
    _tfGender.text =  ((AppDelegate*)[UIApplication sharedApplication].delegate).strGender;
    _tfBrithday.text =  ((AppDelegate*)[UIApplication sharedApplication].delegate).strBrithday;
}

#pragma init

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


- (IBAction)onClickedRegister:(UIButton *)btn {
    [self controlActivity:YES];
    _userRegister = [[SignDto alloc]init];
    _userRegister.email = _email;
    _userRegister.password = _password;
    _userRegister.phone = @"0978506324";
    _userRegister.image = @"";
    _userRegister.birthday = _tfBrithday.text;
    ([_tfGender isEqual:@"Male"])? (_userRegister.gender = @"false") : (_userRegister.gender = @"true");
    _userRegister.name = _tfFullName.text;
    [API getRegisterDtoprocessAPI:serverRegister method:@"POST" header:nil body:_userRegister callback:^(BOOL success, id data){
        
        dispatch_async(dispatch_get_main_queue(), ^(){
        [self controlActivity:NO];
        NSString *mess ;
        if (success) {
            mess = @"Register success";
        } else {
            mess =@"Information not correct";
        }
        UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"Warring"
                                                                       message:mess
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OK =[UIAlertAction actionWithTitle:@"OK"
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      [self Login];
                                                  }];
        [alert addAction:OK];
        [self presentViewController:alert animated:YES completion:nil];
        
        });
    }];

}

- (IBAction)onClickedPrevious:(UIButton *)btn {
    
    ((AppDelegate*)[UIApplication sharedApplication].delegate).strUserName = _tfFullName.text;
    ((AppDelegate*)[UIApplication sharedApplication].delegate).strGender = _tfGender.text;
    ((AppDelegate*)[UIApplication sharedApplication].delegate).strBrithday = _tfBrithday.text;
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)onClickedSelect:(UIButton *)btn {
    if (btn.tag == 11) {
        UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"Select Gender"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * btnMale = [UIAlertAction actionWithTitle:@"Male"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
            _tfGender.text = @"Male";
        }];
        UIAlertAction * btnFemale = [UIAlertAction actionWithTitle:@"Female"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
            _tfGender.text = @"Female";
        }];
        [alert addAction:btnMale];
        [alert addAction:btnFemale];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"\n\n\n\n\n\n\n\n\n"
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        alertController.modalInPopover = YES;
        UIDatePicker *picker = [[UIDatePicker alloc] init];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd MM yyyy"];
        [picker setDatePickerMode:UIDatePickerModeDate];
        [alertController.view addSubview:picker];
        [alertController addAction:({
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                _tfBrithday.text = [dateFormat stringFromDate:picker.date];
            }];
            action;
        })];
        [self presentViewController:alertController  animated:YES completion:nil];
    }

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

- (void)Login {
    dispatch_async(dispatch_get_main_queue(), ^(){

    [self controlActivity:YES];
    });
    LoginDto * loginDto = [[LoginDto alloc]init];
    loginDto.email = _email;
    loginDto.password = _password;
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

@end

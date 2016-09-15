//
//  RegisterFinishVC.m
//  AppChat
//
//  Created by ThanhSon on 9/15/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "RegisterFinishVC.h"


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
    _userRegister.image = @"Sondeptrai";
    _userRegister.birthday = _tfBrithday.text;
    _userRegister.gender = @"false";
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
                                                  handler:nil];
        [alert addAction:OK];
        [self presentViewController:alert animated:YES completion:nil];
        
        });
    }];

}

- (IBAction)onClickedPrevious:(UIButton *)btn {
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

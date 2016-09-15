//
//  RegisterFinishVC.m
//  AppChat
//
//  Created by ThanhSon on 9/15/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "RegisterFinishVC.h"

#import "SignDto.h"

#import "API.h"

#import "activityViewController.h"

#define serverRegister @"user/register"

@implementation RegisterFinishVC {
    activityViewController *_activityView;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createActivity];
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
    
    SignDto * signDto = [[SignDto alloc]init];
    signDto.email = @"admin1111@gmail.com";
    signDto.password = @"Aa12345";
    signDto.phone = @"0978506324";
    signDto.image = @"Sondeptrai";
    signDto.birthday = @"1996-04-02";
    signDto.gender = @"false";
    signDto.name = @"Son";
    
    [API getRegisterDtoprocessAPI:serverRegister method:@"POST" header:nil body:signDto callback:^(BOOL success, id data){         dispatch_async(dispatch_get_main_queue(), ^(){
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


@end

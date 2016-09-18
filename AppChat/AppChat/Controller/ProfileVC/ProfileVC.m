//
//  ProfileVC.m
//  AppChat
//
//  Created by ThanhSon on 9/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "ProfileVC.h"

@implementation ProfileVC {
    activityViewController *_activityView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _email = ((AppDelegate*)[UIApplication sharedApplication].delegate).strEmail;
    _User = [[UserDto alloc]init];
    
    [self createActivity];
    [self getDataProfile];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LoaddingProfile

- (void)getDataProfile {
    [self controlActivity:YES];
    [API getUserDtorocessAPI:[NSString stringWithFormat:@"user/%@",_email]
                      method:@"GET"
                      header:nil
                    callback:^(BOOL success, id data) {
        dispatch_async(dispatch_get_main_queue(), ^(){
            _lblName.text = [data objectForKey:@"name"];
            _lblEmail.text =[data objectForKey:@"email"];
            _lblBirthday.text =[data objectForKey:@"birthday"];;
            [self controlActivity:NO];
        });
    }];
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

#pragma mark ActionButton 

- (IBAction)onClickedBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickedLogout:(id)sender {

    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

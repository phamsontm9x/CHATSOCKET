//
//  ProfileVC.m
//  AppChat
//
//  Created by ThanhSon on 9/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "ProfileVC.h"
#define emailUser ((AppDelegate*)[UIApplication sharedApplication].delegate).strEmail
#define imageUser ((AppDelegate*)[UIApplication sharedApplication].delegate).strImage
#define server [NSString stringWithFormat:@"user/changebackground/%@",emailUser]

@implementation ProfileVC {
    activityViewController *_activityView;
    BOOL isSelect;
    NSString *strImageDefaut;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (!_email) {
        _email = emailUser;
        isSelect = YES;
    } else {
        if ([_email isEqual:emailUser]) {
            isSelect = YES;
        } else {
            isSelect = NO;
        }
    }
    if ([_check isEqual:@"NO"]) {
        isSelect = NO;
        _btnLogout.hidden = YES;
    } else {
        isSelect = YES;
        _btnLogout.hidden = NO;
    }
    _User = [[UserDto alloc]init];
    _strImgae = imageUser;
    strImageDefaut = imageUser;
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
            _lblBirthday.text =[data objectForKey:@"birthday"];
            NSString * strImage = [data objectForKey:@"image"];
            if (![strImage isEqual:@""]) {
                UIImage * img = [self decodeBase64ToImage:strImage];
                [_btnIcon setBackgroundImage:img forState:UIControlStateNormal];
            } else {
                [_btnIcon setBackgroundImage:[UIImage imageNamed:@"ic_user"] forState:UIControlStateNormal];
            }

            [self controlActivity:NO];
        });
    }];
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
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
    _check = @"Back";
    if (isSelect == YES && ![_strImgae isEqual: strImageDefaut]) {
        [self saveDataAPI];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)onClickedLogout:(id)sender {
    _check = @"Logout";
    if (isSelect == YES && ![_strImgae isEqual: strImageDefaut]) {
        [self saveDataAPI];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (IBAction)onClickedChangeIC:(UIButton *)sender {
    if (isSelect) {
        [self selectImageFromPhotoLibrary];
    }

}

#pragma mark - UIImagePickerController


- (void)selectImageFromPhotoLibrary {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Choose type"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *cameraAction){
                                                             if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                                                 [self showImagePickerController:UIImagePickerControllerSourceTypeCamera];
                                                             }
                                                         }];
    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"Photos Library"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *libraryAction){
                                                              [self showImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
                                                          }];
    UIAlertAction *savePhotosAction = [UIAlertAction actionWithTitle:@"Saved Photos Album"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *savePhotosAction){
                                                                 [self showImagePickerController:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
                                                             }];
    
    [alert addAction:cancelAction];
    [alert addAction:cameraAction];
    [alert addAction:libraryAction];
    [alert addAction:savePhotosAction];
    
    [self presentViewController:alert animated:true completion:nil];
}

- (void)popView {
    if ([_check isEqual:@"Back"]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


- (void)showImagePickerController:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = sourceType;
    imagePicker.allowsEditing = true;
    [self presentViewController:imagePicker animated:true completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    _imgUser = image;
    [self dismissViewControllerAnimated:true completion:nil];
    _strImgae = [self encodeToBase64String:_imgUser];
    [_btnIcon setBackgroundImage:_imgUser forState:UIControlStateNormal];
    [_btnIcon setNeedsLayout];
}

- (void)saveDataAPI {
    [self controlActivity:YES];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Change Avata"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *btnCancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          [_btnIcon setBackgroundImage:[UIImage imageNamed:@"ic_user"] forState:UIControlStateNormal];
                                                          [_btnIcon layoutIfNeeded];
                                                          [self controlActivity:NO];
                                                          [self popView];
                                                      }];
    UIAlertAction *btnOK = [UIAlertAction actionWithTitle:@"OK"
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      [API getChangeBackgroundrocessAPI:server method:@"POST" header:nil body:_strImgae callback:^(BOOL success, id data) {
                                                          if (success) {
                                                              dispatch_async(dispatch_get_main_queue(), ^(){
                                                                  [self controlActivity:NO];
                                                                  ((AppDelegate*)[UIApplication sharedApplication].delegate).strImage = _strImgae;
                                                                   [self popView];
                                                              });
                                                          }
                                                      }];
                                                  }];
    [alert addAction:btnCancel];
    [alert addAction:btnOK];
    [self presentViewController:alert animated:true completion:nil];
}


@end

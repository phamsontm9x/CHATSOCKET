//
//  UserOnlineVC.m
//  AppChat
//
//  Created by ThanhSon on 9/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "UserOnlineVC.h"
#import "ChatLeftCell.h"

#define server @"room/getUsersInRoom/"
#define roomID ((AppDelegate*)[UIApplication sharedApplication].delegate).strRoomID

@implementation UserOnlineVC {
    activityViewController *_activityView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createActivity];
    [self controlActivity:YES];
    [self createData];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createData {
    _arrUser = [[NSMutableArray alloc]init];
    [API getListRoomDtoprocessAPI:[NSString stringWithFormat:@"%@%@",server,roomID] method:@"GET" header:nil callback:^(BOOL success, id data) {
        NSDictionary * dic = [data objectForKey:@"members"];
        _arrUser =[dic copy];
        [_tbvUserOnline reloadData];
        [self controlActivity:NO];
    }];
}

#pragma mark - Activity

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


#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrUser.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dic = [_arrUser objectAtIndex:indexPath.row];
    UserDto * user = [[UserDto alloc]init];
    user.name =[dic objectForKey:@"name"];
    user.background = [dic objectForKey:@"avatar"];
    NSString * cellID;
    cellID = @"ChatLeftCell";
    ChatLeftCell * cell = [_tbvUserOnline dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (![user.background isEqual:@""]) {
//        UIImage * img = [self decodeBase64ToImage:user.background];
//        [cell.btnIcon setBackgroundImage:img forState:UIControlStateNormal];
//    } else {
        [cell.btnIcon setBackgroundImage:[UIImage imageNamed:@"ic_user"] forState:UIControlStateNormal];
   // }
    cell.lblMessager.text = user.name;
    cell.btnIcon.tag = indexPath.row;
    return cell;
}


- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}



#pragma mark UIAction
- (IBAction)onClickedBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickedProfile:(UIButton *)btn {
    ProfileVC *vProfile =[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
    NSDictionary * dic = [_arrUser objectAtIndex:btn.tag];
    vProfile.email = [dic objectForKey:@"email"];
    vProfile.check = @"NO";
    [self.navigationController pushViewController:vProfile animated:YES];
}

@end

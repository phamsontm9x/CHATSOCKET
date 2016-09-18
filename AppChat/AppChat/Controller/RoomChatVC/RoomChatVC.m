//
//  RoomChatVC.m
//  AppChat
//
//  Created by ThanhSon on 9/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "RoomChatVC.h"
#define server @"http://52.221.225.151:3000"

@implementation RoomChatVC {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tbvChatRoom.estimatedRowHeight =50;
    _lblTitle.text = _strTitle;
    [self createData];
    [self createSocketIo];
    [self createTF];
    [self listenServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createData {
    _arrMess = [[NSMutableArray alloc]init];
    _strRoomId = ((AppDelegate*)[UIApplication sharedApplication].delegate).strRoomID;
    _strUserName = ((AppDelegate*)[UIApplication sharedApplication].delegate).strEmail;
    _strUserId = ((AppDelegate*)[UIApplication sharedApplication].delegate).strUserID;
}

#pragma mark - SocketIO

- (void)createSocketIo {
    NSURL* url = [[NSURL alloc] initWithString:server];
    _socket = [[SocketIOClient alloc] initWithSocketURL:url config:@{@"log": @YES, @"forcePolling": @YES}];
    [_socket connect];
 //   [self listenServer];
    float delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.socket emit:@"client-join-room" withItems:@[_strUserId,_strRoomId]];
    });

}

-(void)listenServer{
    [self.socket once:@"server-send-message" callback:^(NSArray * data, SocketAckEmitter * ack) {
        [self listenServer];
        NSDictionary * dic = [data objectAtIndex:0];
        NSMutableDictionary *statuscode = [dic objectForKey:@"statuscode"];
        NSMutableDictionary *results = [dic objectForKey:@"results"];
        NSString * stt = [NSString stringWithFormat:@"%@",statuscode];
        if ([stt isEqual:@"200"]) {
            [self addData:results];
        }
    }];

}

-(void)addData:(NSDictionary*)data{
    MessDto * message = [[MessDto alloc]init];
    message.userName = [data valueForKey:@"owner"];
    message.mess = [data valueForKey:@"content"];
    message.image = [data valueForKey:@"image"];
    if (![message.userName isEqual:_strUserName]) {
        [_arrMess addObject:message];
        [_tbvChatRoom reloadData];
    }
}




#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrMess.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessDto * mess = [_arrMess objectAtIndex:indexPath.row];
    
    NSString * cellID;
    if ([mess.userName isEqual:_strUserName]) {
        cellID = @"ChatRightCell";
        ChatRightCell * cell = [_tbvChatRoom dequeueReusableCellWithIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lblMessager.text = mess.mess;
        cell.tag = indexPath.row;
        return cell;
    } else {
        cellID = @"ChatLeftCell";
        ChatLeftCell * cell = [_tbvChatRoom dequeueReusableCellWithIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lblMessager.text = mess.mess;
        cell.tag = indexPath.row;
        return cell;
    }
}

    
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

#pragma mark ActionButton

- (IBAction)onClickedBackView:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - UITextField

- (void)createTF {
    _tfMess.layer.borderColor = [UIColor whiteColor].CGColor;
    _tfMess.layer.borderWidth = 1.0f;
    _tfMess.text = @"Write your message...";
    _tfMess.textColor = [UIColor lightGrayColor];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    dispatch_async(dispatch_get_main_queue(), ^(){
    [self animationViewWithconstant:215];
    });
    if ([textView.text isEqualToString:@"Write your message..."]) {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self animationViewWithconstant:0];
    });
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Write your message...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

- (void)animationViewWithconstant:(NSInteger)value {
    _botConstraint.constant = value;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)onSelectedSend:(id)sender {
     MessDto * message = [[MessDto alloc]init];
    message.image =@"abc";
    message.mess = _tfMess.text;
    message.userName = _strUserName;
    message.roomID = _strRoomId;
    [_arrMess addObject:message];
    [_tbvChatRoom reloadData];
    [_socket emit:@"client-send-message" withItems:@[message.roomID,message.userName,message.mess,message.image]];
    [_tfMess resignFirstResponder];
    _tfMess.text = @"Write your message...";
    _tfMess.textColor = [UIColor lightGrayColor];
}

- (IBAction)onSelectedProfile:(UIButton*)btn {
    ProfileVC *vProfile =[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
    MessDto * mess = [_arrMess objectAtIndex:btn.tag];
    vProfile.email = mess.userName;
    [self.navigationController pushViewController:vProfile animated:YES];
}


@end

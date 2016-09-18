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
    MessDto * _Mess;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tbvChatRoom.estimatedRowHeight =50;
    _lblTitle.text = _strTitle;
    [self createData];
    [self createTF];
    [self createSocketIo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createData {
    _arrMess = [[NSMutableArray alloc]init];
    _Mess = [[MessDto alloc]init];
    _strRoomId = ((AppDelegate*)[UIApplication sharedApplication].delegate).strRoomID;
    _strUserName = ((AppDelegate*)[UIApplication sharedApplication].delegate).strEmail;
    _Mess.userName = _strUserName;
    _Mess.roomID = _strRoomId;
}

#pragma mark - SocketIO

- (void)createSocketIo {
    NSURL* url = [[NSURL alloc] initWithString:server];
    _socket = [[SocketIOClient alloc] initWithSocketURL:url config:@{@"log": @YES, @"forcePolling": @YES}];
    [_socket connect];
   // [self listenServer];
}

-(void)listenServer{

    [self.socket once:@"server-send-message" callback:^(NSArray * data, SocketAckEmitter * ack) {
        NSDictionary * dic = [data objectAtIndex:0];
        NSMutableDictionary *statuscode = [dic objectForKey:@"statuscode"];
        NSMutableDictionary *results = [dic objectForKey:@"results"];
        NSString * stt = [NSString stringWithFormat:@"%@",statuscode];
        if ([stt isEqual:@"200"]) {
            [self addData:results];
            [self listenServer];
        }
    }];

}

-(void)addData:(NSDictionary*)data{
    MessDto * message = [[MessDto alloc]init];
    NSArray * info = [data valueForKey:@"results"];
    message.userName = [info valueForKey:@"owner"];
    message.mess = [info valueForKey:@"content"];
    message.image = [info valueForKey:@"image"];
    [_arrMess addObject:message];
    [_tbvChatRoom reloadData];
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
        return cell;
    } else {
        cellID = @"ChatLeftCell";
        ChatLeftCell * cell = [_tbvChatRoom dequeueReusableCellWithIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lblMessager.text = mess.mess;
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
        textView.text = @"placeholder text here...";
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
    _Mess.image =@"abc";
    _Mess.mess = _tfMess.text;
    [_socket emit:@"client-send-message" withItems:@[_Mess.roomID,_Mess.userName,_Mess.mess,_Mess.image]];
    [self listenServer];
}

- (IBAction)onSelectedProfile:(UIButton*)btn {
    ProfileVC *vProfile =[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
    [self.navigationController pushViewController:vProfile animated:YES];
}


@end

//
//  RoomChatVC.m
//  AppChat
//
//  Created by ThanhSon on 9/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "RoomChatVC.h"
#define server @"http://52.221.225.151:3000"

@implementation RoomChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tbvChatRoom.estimatedRowHeight =50;
    _lblTitle.text = _strTitle;
    [self createTF];
    [self listenServer];
    [self createSocketIo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SocketIO

- (void)createSocketIo {
    NSURL* url = [[NSURL alloc] initWithString:server];
    _socket = [[SocketIOClient alloc] initWithSocketURL:url config:@{@"log": @YES, @"forcePolling": @YES}];
    [_socket connect];
    
    [_socket emit:@"test" withItems:@[@"test"]];
}

-(void)listenServer{
    [self.socket once:@"test" callback:^(NSArray * data, SocketAckEmitter * ack) {
        [self listenServer];
    }];
}




#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
    //return chatData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    RoomDto * room = [_arrListRoom objectAtIndex:indexPath.row];
    
    NSString * cellID;
    if (indexPath.row % 2 == 0) {
        cellID = @"ChatLeftCell";
        ChatLeftCell * cell = [_tbvChatRoom dequeueReusableCellWithIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lblMessager.text = @"asdasd asd";
        return cell;
    } else {
        cellID = @"ChatRightCell";
        ChatRightCell * cell = [_tbvChatRoom dequeueReusableCellWithIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lblMessager.text = @"asdasd asd asdsa asd sa  asd asd as a ";
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
    _tfMess.text = @"placeholder text here...";
    _tfMess.textColor = [UIColor lightGrayColor];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    dispatch_async(dispatch_get_main_queue(), ^(){
    [self animationViewWithconstant:215];
    });
    if ([textView.text isEqualToString:@"placeholder text here..."]) {
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
}

- (IBAction)onSelectedProfile:(UIButton*)btn {
    ProfileVC *vProfile =[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
    [self.navigationController pushViewController:vProfile animated:YES];
}


@end

//
//  RoomChatVC.m
//  AppChat
//
//  Created by ThanhSon on 9/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "RoomChatVC.h"

@implementation RoomChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tbvChatRoom.estimatedRowHeight =50;
    _lblTitle.text = _strTitle;
    [self createTF];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end

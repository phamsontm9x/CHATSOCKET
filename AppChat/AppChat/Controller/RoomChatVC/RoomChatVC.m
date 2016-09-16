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
        cell.lblMessager.text = @"asdasd asd asdsa asd sa  asd asd as a ";
        return cell;
    } else {
        cellID = @"ChatRightCell";
        ChatRightCell * cell = [_tbvChatRoom dequeueReusableCellWithIdentifier:cellID];
        cell.lblMessager.text = @"asdasd asd asdsa asd sa  asd asd as a ";
        return cell;
        
    }
}

    
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (IBAction)onClickedBackView:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end

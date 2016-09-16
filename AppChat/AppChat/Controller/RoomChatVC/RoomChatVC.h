//
//  RoomChatVC.h
//  AppChat
//
//  Created by ThanhSon on 9/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChatLeftCell.h"
#import "ChatRightCell.h"

@import SocketIO;

@interface RoomChatVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tbvChatRoom;
@property (strong, nonatomic) NSString *strTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

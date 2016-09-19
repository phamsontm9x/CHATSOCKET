//
//  RoomChatVC.h
//  AppChat
//
//  Created by ThanhSon on 9/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#import "ChatLeftCell.h"
#import "ChatRightCell.h"

#import "ProfileVC.h"
#import "UserOnlineVC.h"

#import "MessDto.h"

@import SocketIO;

@interface RoomChatVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbvChatRoom;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextView *tfMess;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *botConstraint;

@property (strong, nonatomic) NSString *strTitle;
@property (strong, nonatomic) NSString *strUserName;
@property (strong, nonatomic) NSString *strRoomId;
@property (strong, nonatomic) NSString *strUserId;

@property (strong, nonatomic) NSMutableArray *arrMess;

//// socketIO
//@property SocketIOClient * socket;

@end

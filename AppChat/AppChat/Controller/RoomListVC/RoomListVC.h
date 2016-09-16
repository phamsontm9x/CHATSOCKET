//
//  RoomListVC.h
//  AppChat
//
//  Created by ThanhSon on 9/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RoomDto.h"

#import "RoomLeftCell.h"
#import "RoomRightCell.h"

#import "activityViewController.h"
#import "RoomChatVC.h"

#import "API.h"


@interface RoomListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbvRoomList;
@property (weak, nonatomic) IBOutlet UILabel *lblRoomCount;
@property (strong, nonatomic) NSMutableArray * arrListRoom;

@end

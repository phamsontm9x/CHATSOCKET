//
//  RoomListVC.m
//  AppChat
//
//  Created by ThanhSon on 9/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "RoomListVC.h"

#define server @"http://52.221.225.151:3000"


@implementation RoomListVC {
    activityViewController *_activityView;
    UITapGestureRecognizer *_tap;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _arrListRoom = [[NSMutableArray alloc]init];
    [self getDataListRoom];
    [self createActivity];
    [self createSocketIo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LoadingDataAPI 

- (void)getDataListRoom {
    [self controlActivity:YES];
    [API getListRoomDtoprocessAPI:@"room" method:@"GET" header:nil callback:^(BOOL success, id data) {
        dispatch_async(dispatch_get_main_queue(), ^(){
        for(NSDictionary * dic in data) {
            RoomDto * room = [[RoomDto alloc]init];
            room.name = [dic objectForKey:@"name"];
            room.slogan= [dic objectForKey:@"slogan"];
            room.idRoom = [dic objectForKey:@"_id"];
            [_arrListRoom addObject:room];
        }
        [_tbvRoomList reloadData];
        [self controlActivity:NO];
        });
    }];
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


#pragma mark -Delegate UITextField

- (void)createTapdismissKeyboard {
    _tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:_tap];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
    [self.view removeGestureRecognizer:_tap];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tebleView numberOfRowsInSection:(NSInteger)section {
    return _arrListRoom.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RoomDto * room = [_arrListRoom objectAtIndex:indexPath.row];
    
    NSString * cellID = @"RoomLeftCell" ;
    RoomLeftCell * cell = [_tbvRoomList dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    (indexPath.row % 2 == 0)? (cell.imvBackground.image = [UIImage imageNamed:@"cellListRoomLeft"]) : (cell.imvBackground.image = [UIImage imageNamed:@"cellListRoomRight"]);
    cell.lblTitleRoom.text = room.name;
    cell.lblMenberRoom.text = room.slogan;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RoomDto * room = [_arrListRoom objectAtIndex:indexPath.row];
    /// join room socket
    NSString *user = ((AppDelegate*)[UIApplication sharedApplication].delegate).strUserID;
    [_socket emit:@"client-join-room" withItems:@[user,room.idRoom]];
    
    //
    [_socket once:@"server-join-room" callback:^(NSArray * data, SocketAckEmitter * ack) {
        NSDictionary * code = [data objectAtIndex:0];
        NSMutableDictionary *statuscode = [code objectForKey:@"statuscode"];
        NSMutableDictionary *results = [code objectForKey:@"results"];
        NSString * stt = [NSString stringWithFormat:@"%@",statuscode];
        NSString * mess ;
        if ([stt isEqual: @"200"]) {
            mess = [NSString stringWithFormat:@"%@",results];
        } else {
            mess = [NSString stringWithFormat:@"%@",results];
        }
        UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"Warring"
                                                                       message:mess
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OK =[UIAlertAction actionWithTitle:@"OK"
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      if ([stt isEqual: @"200"]){
                                                          ((AppDelegate*)[UIApplication sharedApplication].delegate).strRoomID = room.idRoom;
                                                          RoomChatVC *vRoomChat =[self.storyboard instantiateViewControllerWithIdentifier:@"RoomChatVC"];
                                                          vRoomChat.strTitle = room.name;
                                                          [self.navigationController pushViewController:vRoomChat animated:YES];
                                                      }
                                                  }];
        [alert addAction:OK];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}
- (IBAction)onClickedCreateRoom:(id)sender {
    RoomDto * room = [[RoomDto alloc]init];
    [self createTapdismissKeyboard];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CreateRoom"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [self dismissKeyboard];
                                                         }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Create"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           UITextField * txtNameRoom = alert.textFields.firstObject;
                                                           UITextField * txtMenber = alert.textFields.lastObject;
                                                           room.name = txtNameRoom.text;
                                                           room.slogan =txtMenber.text;
                                                           room.idOwner = ((AppDelegate*)[UIApplication sharedApplication].delegate).strUserID;
                                                           
                                                           [self dismissKeyboard];
                                                           
                                                           [API getCreateRoomDtoprocessAPI:@"room" method:@"POST" header:nil body:room callback:^(BOOL success, id data) {
                                                               NSString * mess;
                                                               if (success) {
                                                                   mess = @"Create success";
                                                                   [_arrListRoom addObject:room];
                                                                
                                                               } else {
                                                                   mess =@"User can only create one room";
                                                               }
                                                               UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"Warring"
                                                                                                                              message:mess
                                                                                                                       preferredStyle:UIAlertControllerStyleAlert];
                                                               UIAlertAction *OK =[UIAlertAction actionWithTitle:@"OK"
                                                                                                           style:UIAlertActionStyleDefault
                                                                                                         handler:^(UIAlertAction * _Nonnull action) {                           [_tbvRoomList reloadData];
                                                                                                             
                                                                                                         }];
                                                               [alert addAction:OK];
                                                               [self presentViewController:alert animated:YES completion:nil];
                                                           }];
                                                           
            
                                                       }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *txtNameRoom) {
        txtNameRoom.placeholder =@"Room name";
        txtNameRoom.text = @"";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *txtSlogan) {
        txtSlogan.placeholder = @"Slogan";
        txtSlogan.text = @"";
    }];
    
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)onClickedProfile:(id)sender {
    ProfileVC *vProfile =[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
    [self.navigationController pushViewController:vProfile animated:YES];
}

#pragma mark - SocketIO

- (void)createSocketIo {
    NSURL* url = [[NSURL alloc] initWithString:server];
    _socket = [[SocketIOClient alloc] initWithSocketURL:url config:@{@"log": @YES, @"forcePolling": @YES}];
    [_socket connect];
}



@end

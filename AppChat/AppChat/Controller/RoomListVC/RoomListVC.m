//
//  RoomListVC.m
//  AppChat
//
//  Created by ThanhSon on 9/16/16.
//  Copyright © 2016 hungpham. All rights reserved.
//

#import "RoomListVC.h"

@implementation RoomListVC {
    activityViewController *_activityView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _arrListRoom = [[NSMutableArray alloc]init];
    RoomDto * room = [[RoomDto alloc]init];
    for (int i = 0; i<10; i++) {
        room.name = [NSString stringWithFormat:@"say Hello %d",i];
        room.menber = @"Sep, Son, Mina, Sang";
        [_arrListRoom addObject:room];
    }

    [self createActivity];
    [self createTapdismissKeyboard];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self controlActivity:NO];
    });
    [self controlActivity:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
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
    cell.lblMenberRoom.text = room.menber;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
- (IBAction)onClickedCreateRoom:(id)sender {
    RoomDto * room = [[RoomDto alloc]init];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CreateRoom"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Create"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           UITextField * txtNameRoom = alert.textFields.firstObject;
                                                           UITextField * txtMenber = alert.textFields.lastObject;
                                                           room.name = txtNameRoom.text;
                                                           room.menber =txtMenber.text;
                                                           [_arrListRoom addObject:room];
                                                           [_tbvRoomList reloadData];
                                                       }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *txtNameRoom) {
        txtNameRoom.placeholder =@"Room name";
        txtNameRoom.text = @"";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *txtMenber) {
        txtMenber.placeholder = @"Slogan";
        txtMenber.text = @"";
    }];
    
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end

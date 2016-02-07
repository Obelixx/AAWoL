//
//  ViewController.m
//  AAWoL
//
//  Created by AMD OS X on 03/02/2016.
//  Copyright © 2016 AA. All rights reserved.
//

#import "MainViewController.h"
#import "DBHelper.h"
#import "AAWoL-Swift.h"
#import "WoLItemView.h"
#import "AddViewController.h"

@interface MainViewController ()

@property NSMutableArray *wolItems;
@property NSNumber *currentSelection;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DBHelper *db = [[DBHelper alloc] init];
    self.wolItems = db.getAll;
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.currentSelection = @-1;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WoLItemCustomView" bundle:nil] forCellReuseIdentifier:@"TabelViewCellIdentifier"];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EditButton"]) {
        
        AddViewController *av = (AddViewController *)[segue destinationViewController];
        WoLItemView *cellView = (WoLItemView *)sender;
        
        av.TFIpAddress.text = cellView.TLIp.text;
        av.TFMacAddress.text = cellView.TLMac.text;
        av.TFPort.text = cellView.TLPort.text;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wolItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *originalCell = [tableView dequeueReusableCellWithIdentifier:@"TabelViewCellIdentifier"];
    
    if(![originalCell isKindOfClass: [WoLItemView class]] || originalCell == nil) {
        originalCell = [[[NSBundle mainBundle] loadNibNamed:@"WoLItemCustomView" owner:nil options:nil] objectAtIndex:0];
    }
    
    WoLItemView *cell = (WoLItemView *) originalCell;
    
    WoLItem *item = [self.wolItems objectAtIndex:[indexPath row]];
    
    cell.TLMac.text = item.macAddress;
    cell.TLIp.text = item.ipAddress;
    cell.TLPort.text =  [[NSNumber alloc] initWithInteger: item.port].stringValue;
    cell.MainView = self;
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int rowHeight;
    if ([indexPath row] == self.currentSelection.intValue) {
        rowHeight = 65;
    }
    else
        rowHeight = 65;
    return rowHeight;
}
@end

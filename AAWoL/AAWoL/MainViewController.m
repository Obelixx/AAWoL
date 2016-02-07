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

@interface MainViewController ()

@property NSMutableArray *wolItems;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DBHelper *db = [[DBHelper alloc] init];
    self.wolItems = db.getAll;
    
    self.tableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wolItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"TabelViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:cellIdentifier];
    }
    
    WoLItem *wolItem = [self.wolItems objectAtIndex:[indexPath row]];
    cell.textLabel.text = wolItem.ipAddress;
    return cell;
}

@end

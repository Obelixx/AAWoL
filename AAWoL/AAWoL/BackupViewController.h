//
//  BackupViewController.h
//  AAWoL
//
//  Created by AMD OS X on 08/02/2016.
//  Copyright © 2016 AA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackupViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)GetClicked:(id)sender;
-(void)EditClicked:(id)sender;

@end

//
//  ViewController.h
//  AAWoL
//
//  Created by AMD OS X on 03/02/2016.
//  Copyright © 2016 AA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSString* toastText;

-(void)EditClicked:(id)sender;

-(void) makeToast: (NSString *)withMessage;

@end


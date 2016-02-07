//
//  WoLItemView.h
//  AAWoL
//
//  Created by AMD OS X on 07/02/2016.
//  Copyright © 2016 AA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface WoLItemView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *TLMac;
@property (weak, nonatomic) IBOutlet UILabel *TLIp;
@property (weak, nonatomic) IBOutlet UILabel *TLPort;
@property MainViewController *MainView;
- (IBAction)WakeClicked:(id)sender;
- (IBAction)EditClicked:(id)sender;

@end

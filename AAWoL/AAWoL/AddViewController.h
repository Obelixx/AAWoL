//
//  AddViewController.h
//  AAWoL
//
//  Created by AMD OS X on 07/02/2016.
//  Copyright © 2016 AA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAWoL-Swift.h"

@interface AddViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *TFMacAddress;
@property (weak, nonatomic) IBOutlet UITextField *TFIpAddress;
@property (weak, nonatomic) IBOutlet UITextField *TFPort;
@property WoLItem *ItemData;

- (IBAction)SaveClicked:(id)sender;

@end

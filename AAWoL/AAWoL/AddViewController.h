//
//  AddViewController.h
//  AAWoL
//
//  Created by AMD OS X on 07/02/2016.
//  Copyright © 2016 AA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController <UITextFieldDelegate>

- (IBAction)SaveClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *TFMacAddress;
@property (weak, nonatomic) IBOutlet UITextField *TFIpAddress;
@property (weak, nonatomic) IBOutlet UITextField *TFPort;

@end

//
//  AddViewController.m
//  AAWoL
//
//  Created by AMD OS X on 07/02/2016.
//  Copyright © 2016 AA. All rights reserved.
//

#import "AddViewController.h"
#import "MainViewController.h"
#import "DBHelper.h"
#import "AAWoL-Swift.h"

@interface AddViewController ()



@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.TFMacAddress setDelegate: self];
    [self.TFIpAddress setDelegate: self];
    [self.TFPort setDelegate: self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.TFMacAddress];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.TFIpAddress];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.TFPort];
    
    if (self.ItemData != nil) {
        self.TFIpAddress.text = self.ItemData.ipAddress;
        self.TFMacAddress.text = self.ItemData.macAddress;
        self.TFPort.text = [[NSNumber alloc] initWithInteger: self.ItemData.port].stringValue;
        
        
        [self textFieldChanged:(NSNotification *)self];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)textFieldChanged:(NSNotification *)notification{
    NSString *macRegexp = @"^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$";
    NSString *ipRegexp = @"\\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\b";
    
    NSPredicate *macTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", macRegexp];
    NSPredicate *ipTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ipRegexp];
    
    
    if ([macTest evaluateWithObject: self.TFMacAddress.text]){
        self.TFMacAddress.textColor = [UIColor greenColor];
    }else{
        self.TFMacAddress.textColor = [UIColor redColor];
    }
    
    if ([ipTest evaluateWithObject: self.TFIpAddress.text]){
        self.TFIpAddress.textColor = [UIColor greenColor];
    }else{
        self.TFIpAddress.textColor = [UIColor redColor];
    }
    
    if (self.TFPort.text.intValue >=0 && self.TFPort.text.intValue <= 65535){
        self.TFPort.textColor = [UIColor greenColor];
    }else{
        self.TFPort.textColor = [UIColor redColor];
    }
}


- (IBAction)SaveClicked:(id)sender {
    DBHelper *db = [[DBHelper alloc] init];
    
    if (self.TFMacAddress.textColor == [UIColor greenColor] &&
        self.TFIpAddress.textColor == [UIColor greenColor] &&
        self.TFPort.textColor == [UIColor greenColor]) {
        
            WoLItem *item = [[WoLItem alloc] initWithMacAddress:self.TFMacAddress.text
                                                   andIpAddress:self.TFIpAddress.text
                                                        andPort:self.TFPort.text.intValue];
        [db add:item];
    }
    
    if(self.ItemData != nil){
        [db remove:self.ItemData];
    }
    [self performSegueWithIdentifier:@"ToMain" sender:sender];
}


@end


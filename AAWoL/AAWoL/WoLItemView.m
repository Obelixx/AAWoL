//
//  WoLItemView.m
//  AAWoL
//
//  Created by AMD OS X on 07/02/2016.
//  Copyright © 2016 AA. All rights reserved.
//

#import "WoLItemView.h"
#import "AAWoL-Swift.h"
#import "Plugins/wol.h"
#import "MainViewController.h"

@implementation WoLItemView



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */


- (IBAction)WakeClicked:(id)sender {
    NSLog(@"WakeClicked");
    
    unsigned char *ip = (unsigned char *) [self.TLIp.text cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char *mac = (unsigned char *) [self.TLMac.text cStringUsingEncoding:NSASCIIStringEncoding];
    
    if(send_wol_packet(ip, mac, [self.TLPort.text intValue]) == 0){
        NSLog(@"Wake Send");
    }
}

- (IBAction)EditClicked:(id)sender {
    NSString *segueString = [NSString stringWithFormat:@"EditButton"];
    [self.MainView performSegueWithIdentifier:segueString sender:self];
}

@end
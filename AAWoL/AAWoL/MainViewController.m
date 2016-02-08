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
#import <UIView+Toast.h>

@interface MainViewController ()

@property NSMutableArray *wolItems;
@property NSNumber *currentSelection;
@property DBHelper *db;


@end

@implementation MainViewController{
    CGFloat previousScale;
    CGFloat scale;
    CGPoint lastPoint;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    @try{
        self.db = [[DBHelper alloc] init];
        self.wolItems = self.db.getAll;
    }
    @catch(NSException *ex){
        [self.view makeToast:@"Error on database initialisation!" duration:3.0 position:CSToastPositionBottom];
        NSLog(@"Error Deleting!");
        NSLog(@"%@", ex.reason);
    }

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.currentSelection = @-1;
    [self.tableView registerNib:[UINib nibWithNibName:@"WoLItemCustomView" bundle:nil] forCellReuseIdentifier:@"TabelViewCellIdentifier"];
    [self.tableView reloadData];
    
    if(self.toastText != nil){
        [self.view makeToast:self.toastText duration:3.0 position:CSToastPositionBottom];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EditButton"]) {
        
        AddViewController *av = (AddViewController *)[segue destinationViewController];
        
        av.ItemData = (WoLItem *)sender;
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
    
    [self addMovementGesturesToView:cell];
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

- (void)EditClicked:(WoLItem*)item {
    [self performSegueWithIdentifier:@"EditButton" sender:item];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        @try{
            [self.db remove:[self.wolItems objectAtIndex:[indexPath row]]];
            [self.wolItems removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [self.view makeToast:@"Item Deleted!" duration:3.0 position:CSToastPositionBottom];
        }
        @catch(NSException *ex){
            [self.view makeToast:@"Error Deleting!" duration:3.0 position:CSToastPositionBottom];
            NSLog(@"Error Deleting!");
            NSLog(@"%@", ex.reason);
        }
    }
}

-(void) makeToast: (NSString *)withMessage{
    if(withMessage != nil){
        [self.view makeToast:withMessage duration:3.0 position:CSToastPositionBottom];
    }
}

- (void)addMovementGesturesToView:(UIView *)view {
    view.userInteractionEnabled = YES;
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    pinchGesture.delegate = (id)self;
    [view addGestureRecognizer:pinchGesture];
}


- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender {
    if([sender state] == UIGestureRecognizerStateBegan) {
        previousScale = 1.0;
        //lastPoint = [sender locationInView:[sender view]];
    }
    
    if (
        [sender state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[[sender view].layer valueForKeyPath:@"transform.scale"] floatValue];
        
        // Constants to adjust the max/min values of zoom
        const CGFloat kMaxScale = 4.0;
        const CGFloat kMinScale = 1.0;
        
        CGFloat newScale = 1 -  (previousScale - [sender scale]); // new scale is in the range (0-1)
        newScale = MIN(newScale, kMaxScale / currentScale);
        newScale = MAX(newScale, kMinScale / currentScale);
        scale = newScale;
        
        CGAffineTransform transform = CGAffineTransformScale([[sender view] transform], newScale, newScale);
        
        [sender view].transform = transform;
        
        CGPoint point = [sender locationInView:[sender view]];
        CGAffineTransform transformTranslate = CGAffineTransformTranslate([[sender view] transform], point.x-lastPoint.x, point.y-lastPoint.y);
        
        [sender view].transform = transformTranslate;
    }
}

@end

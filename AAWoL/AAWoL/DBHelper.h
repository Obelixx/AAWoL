//
//  DBHelper.h
//  AAWoL
//
//  Created by AMD OS X on 05/02/2016.
//  Copyright © 2016 AA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "AAWoL-Swift.h"

@interface DBHelper : NSObject

-(instancetype) init;

-(NSMutableArray *) getAll;
-(void) add: (WoLItem *) wolItem;
-(void) remove: (WoLItem *) wolItem;

@end

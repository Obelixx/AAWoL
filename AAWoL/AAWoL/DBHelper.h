//
//  DBHelper.h
//  AAWoL
//
//  Created by AMD OS X on 05/02/2016.
//  Copyright © 2016 AA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DBHelper : NSObject

-(FMDatabase *) dbInit;
-(void) dbInsert;

@end

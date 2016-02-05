//
//  DBHelper.m
//  AAWoL
//
//  Created by AMD OS X on 05/02/2016.
//  Copyright © 2016 AA. All rights reserved.
//

#import "DBHelper.h"
#import "FMDB.h"

@implementation DBHelper

-(FMDatabase *)dbInit{
    NSString *path = [NSString stringWithFormat:@"%@%@%@", NSHomeDirectory(), @"/AAWoL", @".sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    return db;
}

@end

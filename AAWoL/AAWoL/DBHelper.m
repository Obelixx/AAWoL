//
//  DBHelper.m
//  AAWoL
//
//  Created by AMD OS X on 05/02/2016.
//  Copyright © 2016 AA. All rights reserved.
//

#import "DBHelper.h"
#import "FMDB.h"
#import "AAWoL-Swift.h"

@interface DBHelper ()

@property NSString *sqliteFilePath;
@property FMDatabase *db;

+(FMDatabase *)dbInit: (NSString *)withSqliteFilePath;

@end

@implementation DBHelper


- (instancetype) init{
    self = [super init];
    if (self) {
        self.sqliteFilePath = [NSString stringWithFormat:@"%@%@%@", NSHomeDirectory(), @"/AAWoL", @".sqlite"];
    }
    return self;
}

- (instancetype) init: (NSString *)withSqliteFilePath{
    self = [super init];
    if (self) {
        self.sqliteFilePath = [NSString stringWithFormat:@"%@", withSqliteFilePath];
    }
    return self;
}

-(BOOL) openDB{
    self.db = [DBHelper dbInit:self.sqliteFilePath];
    if (![self.db open]) {
        return NO;
    }
    return true;
}

-(void) closeDB{
    [self.db close];
}

-(void) createTabelIfNotExist{
    [self execute:@"CREATE TABLE IF NOT EXIST WoLItems (macAddress TEXT, ipAdress TEXT, mask TEXT, port NUMBER)"];
}

-(FMResultSet *) execute: (NSString *)query{
    FMResultSet *resultSet;
    if([self openDB]){
        if ([query containsString:@"SELECT"] || [query containsString:@"select"]) {
            resultSet = [self.db executeQuery: query];
        } else {
            [self.db executeUpdate:query];
        }
    }
    [self closeDB];
    return resultSet;
}

-(NSMutableArray *) getAll{
    NSMutableArray *WoLItems = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT macAdress, ipAdress, mask, port FROM WoLItems";
    FMResultSet *result = [self execute:query];
    
    while ([result next]) {
        WoLItem *item = [[WoLItem alloc] initWithMacAddress: [result stringForColumn:@"macAdress"]
                                              withIpAddress: [result stringForColumn:@"ipAdress"]
                                                   withMask: [result stringForColumn:@"mask"]
                                                   withPort: [result intForColumn:@"port"]];
        [WoLItems addObject:item];
    }
    return WoLItems;
}

-(void) add: (WoLItem *) wolItem{
    NSString *mac = wolItem.macAdress;
    NSString *ip = wolItem.ipAdress;
    NSString *mask = wolItem.mask;
    NSString *port = [[[NSNumber alloc] initWithInteger: wolItem.port] stringValue];
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO WoLItems (%@,%@,%@,%@)",mac,ip,mask,port];
    [self execute:query];
}

+(FMDatabase *)dbInit: (NSString *)withSqliteFilePath{
    static FMDatabase *db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db  = [FMDatabase databaseWithPath: withSqliteFilePath];
    });
    
    return db;
}

@end

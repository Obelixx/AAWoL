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
    @try{
        [self createTabelIfNotExist];
    }
    @catch(NSException *exception){
        NSLog(@"Error Creating Table!");
        NSLog(@"%@", exception.reason);
    }
    return self;
}

-(BOOL) openDB{
    self.db = [DBHelper dbInit:self.sqliteFilePath];
    if (![self.db open]) {
        return NO;
    }
    return YES;
}

-(void) closeDB{
    [self.db close];
}

-(FMResultSet *) execute: (NSString *)query :(NSArray *)values :(BOOL)closeDB{
    FMResultSet *resultSet;
    if([self openDB]){
        if ([query containsString: @"SELECT"] || [query containsString: @"select"]) {
            @try{
                resultSet = [self.db executeQuery: query];
            }
            @catch(NSException *exception){
                NSLog(@"Error on SELECT query!");
                NSLog(@"%@", exception.reason);
            }
            
        } else {
            
            @try{
                [self.db executeUpdate: query values: values error: nil];;
            }
            @catch(NSException *exception){
                NSLog(@"Error on UPDATE query!");
                NSLog(@"%@", exception.reason);
            }
        }
    }
    if(closeDB){
        [self closeDB];
    }
    return resultSet;
}

-(void) createTabelIfNotExist{
    FMResultSet *result = [self execute: @"SELECT count(*) FROM sqlite_master WHERE type='table' AND name='WoLItems';": nil: NO];
    if ([result next]) {
        if([[result stringForColumnIndex: 0] isEqualToString: @"0"]){
            [self execute: @"CREATE TABLE IF NOT EXISTS WoLItems (macAddress TEXT, ipAddress TEXT, port NUMBER)": nil: NO];
            
            WoLItem *exampleItem = [[WoLItem alloc] initWithMacAddress:@"9c:d6:43:90:fa:7d"
                                                          andIpAddress:@"78.90.30.20"
                                                               andPort:8];
            [self add:exampleItem];
        }
    }
}


-(NSMutableArray *) getAll{
    NSMutableArray *WoLItems = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT macAddress, ipAddress, port FROM WoLItems";
    FMResultSet *result = [self execute: query: nil: NO];
    
    while ([result next]) {
        WoLItem *item = [[WoLItem alloc] initWithMacAddress: [result stringForColumn: @"macAddress"]
                                              andIpAddress: [result stringForColumn: @"ipAddress"]
                                                   andPort: [result intForColumn: @"port"]];
        [WoLItems addObject:item];
    }
    [self closeDB];
    return WoLItems;
}

-(void) add: (WoLItem *) wolItem{
    NSString *mac = wolItem.macAddress;
    NSString *ip = wolItem.ipAddress;
    NSString *port = [[[NSNumber alloc] initWithInteger: wolItem.port] stringValue];
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO WoLItems VALUES (?,?,?)"];
    NSArray *values = [NSArray arrayWithObjects:mac,ip,port, nil];
    [self execute: query: values: YES];
}

-(void) remove: (WoLItem *) wolItem{
    NSString *mac = wolItem.macAddress;
    NSString *ip = wolItem.ipAddress;
    NSString *port = [[[NSNumber alloc] initWithInteger: wolItem.port] stringValue];
    
    NSString *query = [NSString stringWithFormat:@"DELETE FROM WoLItems WHERE macAddress=? AND ipAddress=? AND port=?"];
    NSArray *values = [NSArray arrayWithObjects:mac,ip,port, nil];
    [self execute: query: values: YES];
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

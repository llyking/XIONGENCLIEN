//
//  SQLiteManager.m
//  XIONGENCLIEN
//
//  Created by Ios on 2018/3/26.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "SQLiteManager.h"

@implementation SQLiteManager

+(instancetype)shareManager {
    
    static SQLiteManager *instance = nil;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        
        instance = [[SQLiteManager alloc]init];
        
    });
    return instance;
}

-(instancetype)init {
    if (self = [super init]) {
        _db = [FMDatabase databaseWithPath:[self dbPath]];
        BOOL ret = [_db open];
        NSLog(@"打开数据库%@", ret ? @"成功!" : @"失败!");
        //2, 创建表
        [self createTable];
    }
    return self;
}

-(void)createTable {
    //创建表的SQL语句
    //用户 表
    NSString *creatUserTable = @"CREATE TABLE IF NOT EXISTS 't_Good' ('ID' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'name' TEXT,'brandname' TEXT,'originname' TEXT,'modelname' TEXT,'posName' TEXT,'wareName' TEXT,'brcode' TEXT,'code' TEXT,'car' TEXT,'amount' integer,'price' real,'count' integer,'fid' integer);";
    [_db executeUpdate:creatUserTable];
}

-(NSMutableArray *)selectGood {
    
    NSMutableArray *array = [NSMutableArray new];
    NSString *sql =[NSString stringWithFormat:@"select * from t_Good"];
    FMResultSet *set = [_db executeQuery:sql];
    while (set.next) {
        GoodsModel *model = [GoodsModel new];
        model.fid = [set intForColumn:@"fid"];
        model.name = [set stringForColumn:@"name"];
        model.code =[set stringForColumn:@"code"];
        model.brcode = [set stringForColumn:@"brcode"];
        model.originname = [set stringForColumn:@"originname"];
        model.amount = [set intForColumn:@"amount"];
        model.count = [set intForColumn:@"count"];
        model.price =[set doubleForColumn:@"price"];
        [array addObject:model];
    }
    return array;
}

-(BOOL)selectGoodWithGoodFid:(int)fid {
    NSString *sql =[NSString stringWithFormat:@"select * from t_Good where fid=%d",fid];
    FMResultSet *set = [_db executeQuery:sql];
    while (set.next) {
        return YES;
    }
    return NO;
}


-(BOOL)insertGood:(GoodsModel *)good {
    NSString *sql = @"insert into t_Good(fid,name,code,brandname,originname,amount,count,price,brcode,modelname,posName,wareName) values(?,?,?,?,?,?,?,?,?,?,?,?)";
    BOOL ret = [_db executeUpdate:sql,@(good.fid),good.name,good.code,good.brandname,good.originname,@(good.amount),@(good.count),@(good.price),good.brcode,good.modelname,good.posName,good.wareName];
    
    NSLog(@"插入数据%@", ret ? @"成功!" : @"失败!");
    return  ret;
}

-(BOOL)updateWithGood:(GoodsModel *)good {
    NSString *updateSql = [NSString stringWithFormat:@"update t_Good set name='%@', code='%@', brandname='%@', originname='%@', amount='%d',count='%d', price='%.2f' brcode='%@', modelname='%@', posName='%@',wareName='%@' where fid='%d'",good.name,good.code,good.brandname,good.originname,good.amount,good.count,good.price,good.brcode,good.modelname,good.posName,good.wareName,good.fid];
    BOOL ret = [_db executeUpdate:updateSql];
    if (ret) {
        NSLog(@"更新成功");
    }
    return ret;
}

-(void)updateGoodCount:(GoodsModel *)good {
    NSString *updateSql = [NSString stringWithFormat:@"update t_Good set count='%d' where fid='%d'",good.count,good.fid];
    [_db executeUpdate:updateSql];
}

-(BOOL)deleteGood:(GoodsModel *)good {
    
    NSString *sql = @"delete from t_Good where fid=?";
    BOOL ret = [_db executeUpdate:sql,good.fid];
    NSLog(@"删除数据%@", ret ? @"成功!" : @"失败!");
    return ret;
}

-(void)delelteTable {
    NSString *sql = @"delete from t_Good";
    [_db executeUpdate:sql];
}

-(void)open {
    [_db open];
}

-(void)close {
    [_db close];
}

#pragma  mark - 数据库路径
-(NSString *)dbPath
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSLog(@"path:%@", path);
    return [path stringByAppendingPathComponent:@"GoodTable.db"];
    
}


@end

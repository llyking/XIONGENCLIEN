//
//  SQLiteManager.h
//  XIONGENCLIEN
//
//  Created by Ios on 2018/3/26.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDatabase.h"
#import "GoodsModel.h"

@interface SQLiteManager : NSObject

@property(nonatomic ,strong)FMDatabase *db;


+(instancetype)shareManager;

-(BOOL)insertGood:(GoodsModel *)good;

-(BOOL)deleteGood:(GoodsModel *)good;
-(void)delelteTable;

-(BOOL)updateWithGood:(GoodsModel *)good;
-(void)updateGoodCount:(GoodsModel *)good;

-(NSMutableArray *)selectGood;
-(BOOL)selectGoodWithGoodFid:(int)fid;

-(void)open;
-(void)close;

@end

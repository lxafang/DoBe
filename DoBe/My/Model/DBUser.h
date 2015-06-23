//
//  DBUser.h
//  DoBe
//
//  Created by liuxuan on 15/6/3.
//  Copyright (c) 2015年 liuxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBUser : NSObject

@property (nonatomic, strong) NSString *userId;                 //用户id
@property (nonatomic, strong) NSString *name;                   //用户名
@property (nonatomic, strong) NSString *headImage;              //用户头像
@property (nonatomic, strong) NSString *signature;              //签名

@property (nonatomic, strong) NSString *cellphone;              //手机号
@property (nonatomic, strong) NSString *email;                  //邮箱
@property (nonatomic, strong) NSString *city;                   //所在城市
@property (nonatomic, strong) NSString *address;                //地址
@property (nonatomic, strong) NSArray  *tags;                   //标签

@property (nonatomic, strong) NSString *focusCount;             //关注数
@property (nonatomic, strong) NSString *fans;                   //粉丝数
@property (nonatomic, strong) NSString *doCion;                 //豆币


+ (DBUser *)sharedInstance;

@end

//
//  DBCommentModel.h
//  DoBe
//
//  Created by liuxuan on 15/6/18.
//  Copyright (c) 2015年 liuxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBCommentModel : NSObject

@property (nonatomic, copy) NSString *guestId;
@property (nonatomic, copy) NSString *guestName;   //游客名称
@property (nonatomic, copy) NSString *detail;      //评论详情
@property (nonatomic, copy) NSString *likedCount;//被点赞数
@property (nonatomic, assign) BOOL    isLiked;     //是否被点赞
@property (nonatomic, copy) NSString *time;        //评论时间
@property (nonatomic, copy) NSString *message;     //回复  DBMessageModel;
@property (nonatomic, strong) UIImage *headImage;

+ (DBCommentModel *)initCommentModelWithDictionay:(NSDictionary *)dic;



@end

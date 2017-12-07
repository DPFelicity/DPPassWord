//
//  DPPasswordView.h
//  DPPassword
//
//  Created by Heaven on 2017/12/7.
//Copyright © 2017年 heaven. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PasswordBlock)(NSString *passWord);
typedef void(^CanclePayBlock)(void);


@interface DPPasswordView : UIView
@property (nonatomic,copy)PasswordBlock passWordBlock;
@property (nonatomic,copy)CanclePayBlock caneleBlock;


+(DPPasswordView *)showPaddwordViewBack:(PasswordBlock)password cancle:(CanclePayBlock)cancle;


@end

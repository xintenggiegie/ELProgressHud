//
//  ELProgressHud.h
//  ELProgressHud
//
//  Created by 李涌辉 on 16/8/27.
//  Copyright © 2016年 LiYonghui~. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ELProgressHudType) {
    ELProgressHudTypeIndicator = 0, // 普通菊花
    ELProgressHudTypeText,       // 文本
    ELProgressHudTypeProgress,   // 进度
    ELProgressHudTypeProgressWithCancel, // 带取消动作
    ELProgressHudTypeIndicatorAndText, // 菊花和文本的组合
    ELProgressHudTypeProgressAndText, // 进度和文本的组合
    ELProgressHudTypeGif,              // gif图片
    ELProgressHudTypeDrawCircle    // 画圈圈
};

typedef void(^ELCompletion)(void);

@interface ELProgressHud : UIView

/**
 *  HudType ... Default is ELProgressHudTypeIndicator
 */
@property (nonatomic, assign) ELProgressHudType hudType;

/**
 *  set this property if you want hud hide automatically
 */
@property (nonatomic, assign) NSTimeInterval delay;

/**
 *  about text hud ... you could setup this label when you need.
 *  eg. hud.textLabel.text = @"OK √"; Default is @"Loading";
 */
@property (nonatomic, strong) UILabel *textLabel;

/**
 *  for ELProgressHudTypeProgress ... set this property get the 
 */
@property (nonatomic, assign) float el_progress;

/**
 *  ELProgressHudTypeProgressWithCancel cancel callBack
 */
@property (nonatomic, copy) ELCompletion elCompletion;

/**
 *  ELProgressHudTypeGif image's name array for gif
 */
@property (nonatomic, strong) NSArray <NSString *>*el_images;


@property (nonatomic, assign) CGFloat el_strokeStart;

/**
 *  initial hud with a type
 *
 *  @param hudType enum ... hud's type
 *
 *  @return special hud
 */
- (instancetype)initWithHudType:(ELProgressHudType)hudType;
/**
 *  显示指定类型的hud
 *
 *  @param aView   which view would add Hud
 *
 */
- (void)showHudAtView:(UIView *)aView;

#pragma mark - simple method of hud

/**
 *  普通显示hud
 *
 *  @param aView  which view would add Hud
 */
+ (void)showHudAtView:(UIView *)aView;

/**
 *  隐藏hud
 *
 *  @param aView which view is hud'superView now
 */
+ (void)hideHudAtView:(UIView *)aView;

@end

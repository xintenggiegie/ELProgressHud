//
//  ELProgressHud.m
//  ELProgressHud
//
//  Created by 李涌辉 on 16/8/27.
//  Copyright © 2016年 LiYonghui~. All rights reserved.
//

#import "ELProgressHud.h"

CGFloat width = 160;
CGFloat height = 120;
CGFloat const ELProgressHudTag = 962;
@interface ELProgressHud ()

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIActivityIndicatorView *ELActivityIndicatorView;

@property (nonatomic, strong) UIProgressView *ELProgressView;
@property (nonatomic, strong) UILabel *ELProgressLabel;
@property (nonatomic, strong) UIButton *ELCancelButton;
@property (nonatomic, strong) UIImageView *ELImageView;
@property (nonatomic, strong) CAShapeLayer *ELCircleShapeLayer;
@property (nonatomic, strong) CAShapeLayer *ELProgressShapeLayer;

@end

@implementation ELProgressHud

#pragma mark - initialize hud

- (instancetype)init {
    self = [super init];
    if (self) {
        _hudType = ELProgressHudTypeIndicator;
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithHudType:(ELProgressHudType)hudType {
    self = [super init];
    if (self) {
        _hudType = hudType;
        [self setup];
    }
    return self;
}

#pragma mark - setup

- (void)setup {
    self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    self.mainView.frame = CGRectMake(0, 0, width, height);
    self.mainView.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds) - 20);
    [self addSubview:self.mainView];
    switch (_hudType) {
        case ELProgressHudTypeIndicator:
        {
            width = 80;
            height = 80;
            self.ELActivityIndicatorView.frame = CGRectMake(0, 0, 50, 50);
            self.ELActivityIndicatorView.center = CGPointMake(width / 2, height / 2);
            [self.mainView addSubview:self.ELActivityIndicatorView];
        }
            break;
        case ELProgressHudTypeText:
        {
            height = 60;
            self.textLabel.frame = CGRectMake(0, 0, width, 44);
            self.textLabel.center = CGPointMake(width / 2, height / 2);
            [self.mainView addSubview:self.textLabel];
        }
            break;
        case ELProgressHudTypeProgress:
        {
            height = 80;
            [self setupELProgressLabel];
            [self setupELProgressView];
            [self.mainView addSubview:self.ELProgressLabel];
            [self.mainView addSubview:self.ELProgressView];
        }
            break;
        case ELProgressHudTypeProgressWithCancel:
        {
            [self setupELProgressLabel];
            [self setupELProgressView];
            self.ELCancelButton.frame = CGRectMake(0, 0, width * 0.4, 36);
            self.ELCancelButton.center = CGPointMake(width / 2, height * 0.8);
            [self.mainView addSubview:self.ELProgressLabel];
            [self.mainView addSubview:self.ELProgressView];
            [self.mainView addSubview:self.ELCancelButton];
        }
            break;
        case ELProgressHudTypeIndicatorAndText:
        {
            [self setupELActivityIndicatorView];
            [self setupTextLabel];
            [self.mainView addSubview:self.ELActivityIndicatorView];
            [self.mainView addSubview:self.textLabel];
            
        }
            break;
        case ELProgressHudTypeProgressAndText:
        {
            [self setupELProgressLabel];
            [self setupELProgressView];
            [self setupTextLabel];
            [self.mainView addSubview:self.ELProgressLabel];
            [self.mainView addSubview:self.ELProgressView];
            [self.mainView addSubview:self.textLabel];
        }
            break;
        case ELProgressHudTypeGif:
        {
            self.ELImageView.frame = self.mainView.bounds;
            [self.mainView addSubview:self.ELImageView];
        }
            break;
        case ELProgressHudTypeDrawCircle:
        {
            width = 120;
            self.ELProgressShapeLayer.frame = self.mainView.bounds;
            self.ELCircleShapeLayer.frame = self.mainView.bounds;
            [self.mainView.layer addSublayer:self.ELCircleShapeLayer];
            [self.mainView.layer addSublayer:self.ELProgressShapeLayer];
            self.ELProgressLabel.frame = CGRectMake(0, 0, width * 0.5, 30);
            self.ELProgressLabel.center = CGPointMake(width / 2, height / 2);
            [self.mainView addSubview:self.ELProgressLabel];
        }
            break;
        default:
            break;
    }
}

- (void)layoutSubviews {
    self.mainView.frame = CGRectMake(0, 0, width, height);
    self.mainView.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds) - 20);
}

- (void)setupELActivityIndicatorView {
    self.ELActivityIndicatorView.frame = CGRectMake(0, 0, 50, 50);
    self.ELActivityIndicatorView.center = CGPointMake(width / 2, 50);
}

- (void)setupELProgressLabel {
    self.ELProgressLabel.frame = CGRectMake(0, 0, width * 0.5, 30);
    self.ELProgressLabel.center = CGPointMake(width / 2, height * 0.2);
}

- (void)setupELProgressView {
    self.ELProgressView.frame = CGRectMake(0, 0, width * 0.8, 1);
    self.ELProgressView.center = CGPointMake(width / 2, height * 0.5);
    self.ELProgressView.transform = CGAffineTransformMakeScale(1.0f,3.0f);
}

- (void)setupTextLabel {
    self.textLabel.frame = CGRectMake(0, 0, width, 44);
    self.textLabel.center = CGPointMake(width / 2, height - 30);
}

#pragma mark - public methods

+ (void)showHudAtView:(UIView *)aView {
    ELProgressHud *hud = [[ELProgressHud alloc] init];
    hud.tag = ELProgressHudTag;
    [hud.ELActivityIndicatorView startAnimating];
    [aView addSubview:hud];
}

+ (void)hideHudAtView:(UIView *)aView {
    ELProgressHud *hud = [aView viewWithTag:ELProgressHudTag];
    if (hud) {
        hud.mainView = nil;
        hud.ELActivityIndicatorView = nil;
        width = 160;
        height = 120;
        [hud removeFromSuperview];
        hud = nil;
    }
}

- (void)showHudAtView:(UIView *)aView {
    self.tag = ELProgressHudTag;
    [self.ELActivityIndicatorView startAnimating];
    [aView addSubview:self];
    if (self.delay) {
        [self performSelector:@selector(hide) withObject:nil afterDelay:self.delay];
    }
}

#pragma mark - private method

- (void)hide {
    self.mainView = nil;
    self.ELActivityIndicatorView = nil;
    width = 160;
    height = 120;
    [self removeFromSuperview];
}

#pragma mark - cancelbutton event

- (void)ELCancelButtonClick {
    if (self.elCompletion) {
        self.elCompletion();
    }
    self.elCompletion = nil;
    [self hide];
}

#pragma mark - setter & getter

- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [UIColor lightGrayColor];
        _mainView.layer.cornerRadius = 8;
        _mainView.layer.masksToBounds = YES;
    }
    return _mainView;
}

- (UIActivityIndicatorView *)ELActivityIndicatorView {
    if (!_ELActivityIndicatorView) {
        _ELActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _ELActivityIndicatorView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.text = @"Loading";
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

- (UIProgressView *)ELProgressView {
    if (!_ELProgressView) {
        _ELProgressView = [[UIProgressView alloc] init];
        _ELProgressView.progressTintColor = [UIColor orangeColor];
    }
    return _ELProgressView;
}

- (void)setEl_progress:(float)el_progress {
    if ([NSThread isMainThread]) {
        [self.ELProgressView setProgress:el_progress animated:YES];
        [self.ELProgressLabel setText:[NSString stringWithFormat:@"%.2f%%", el_progress * 100]];
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.ELProgressView setProgress:el_progress animated:YES];
            [self.ELProgressLabel setText:[NSString stringWithFormat:@"%.2f%%", el_progress * 100]];
        });
    }
}

- (UILabel *)ELProgressLabel {
    if (!_ELProgressLabel) {
        _ELProgressLabel = [[UILabel alloc] init];
        _ELProgressLabel.textAlignment = NSTextAlignmentCenter;
        _ELProgressLabel.textColor = [UIColor lightTextColor];
    }
    return _ELProgressLabel;
}

- (UIButton *)ELCancelButton {
    if (!_ELCancelButton) {
        _ELCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ELCancelButton addTarget:self action:@selector(ELCancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _ELCancelButton.backgroundColor = [UIColor grayColor];
        [_ELCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    }
    return _ELCancelButton;
}

- (UIImageView *)ELImageView {
    if (!_ELImageView) {
        _ELImageView = [[UIImageView alloc] init];
        _ELImageView.alpha = 0.5;
    }
    return _ELImageView;
}

- (void)setEl_images:(NSArray<NSString *> *)el_images {
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSString *imageName in el_images) {
        UIImage *image = [UIImage imageNamed:imageName];
        [imageArray addObject:image];
    }
    self.ELImageView.animationImages = imageArray;
    [self.ELImageView startAnimating];
}

- (CAShapeLayer *)ELCircleShapeLayer {
    if (!_ELCircleShapeLayer) {
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(width * (1 - 0.6) / 2, height * (1 - 0.6) / 2, width * 0.6, height * 0.6)];
        _ELCircleShapeLayer = [CAShapeLayer layer];
        _ELCircleShapeLayer.fillColor = [UIColor clearColor].CGColor;
        _ELCircleShapeLayer.strokeColor=[UIColor orangeColor].CGColor;
        _ELCircleShapeLayer.path = path.CGPath;
        _ELCircleShapeLayer.lineWidth = 3;
    }
    return _ELCircleShapeLayer;
}

- (CAShapeLayer *)ELProgressShapeLayer {
    if (!_ELProgressShapeLayer) {
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(width * (1 - 0.6) / 2, height * (1 - 0.6) / 2, width * 0.6, height * 0.6)];
        _ELProgressShapeLayer = [CAShapeLayer layer];
        _ELProgressShapeLayer.fillColor = [UIColor clearColor].CGColor;
        _ELProgressShapeLayer.strokeColor=[UIColor whiteColor].CGColor;
        _ELProgressShapeLayer.path = path.CGPath;
        _ELProgressShapeLayer.lineWidth = 3;
    }
    return _ELProgressShapeLayer;
}

- (void)setEl_strokeStart:(CGFloat)el_strokeStart {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.ELProgressShapeLayer.strokeStart = el_strokeStart;
        [self.ELProgressLabel setText:[NSString stringWithFormat:@"%.2f%%", el_strokeStart * 100]];
    });
}

@end

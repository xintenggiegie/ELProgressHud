//
//  ViewController.m
//  ELProgressHUD
//
//  Created by 李涌辉 on 16/8/30.
//  Copyright © 2016年 LiYonghui~. All rights reserved.
//

#import "ViewController.h"
#import "ELProgressHud.h"
#import "AFNetworking.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ELProgressHud";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    
    
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.text = self.dataSource[indexPath.section];
    return cell;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case ELProgressHudTypeIndicator:
        {
            [ELProgressHud showHudAtView:self.view];
            [self performSelector:@selector(hide) withObject:nil afterDelay:2.0];
        }
            break;
        case ELProgressHudTypeText:
        {
            ELProgressHud *hud = [[ELProgressHud alloc] initWithHudType:ELProgressHudTypeText];
            hud.textLabel.text = @"单纯的文本框~";
            hud.delay = 1.5;
            [hud showHudAtView:self.view];
        }
            break;
        case ELProgressHudTypeProgress:
        {
            ELProgressHud *hud = [[ELProgressHud alloc] initWithHudType:ELProgressHudTypeProgress];
            [hud showHudAtView:self.view];
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:nil];
            NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://flv2.bn.netease.com/videolib3/1607/14/SrqDm6658/SD/SrqDm6658-mobile.mp4"]] progress:^(NSProgress * _Nonnull downloadProgress) {
                
                hud.el_progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
                
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                NSLog(@"%@", targetPath);
                return targetPath;
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                [ELProgressHud hideHudAtView:self.view];
            }];
            
            [task resume];
            
        }
            break;
        case ELProgressHudTypeProgressWithCancel:
        {
            ELProgressHud *hud = [[ELProgressHud alloc] initWithHudType:ELProgressHudTypeProgressWithCancel];
            [hud showHudAtView:self.view];
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:nil];
            NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://flv2.bn.netease.com/videolib3/1607/14/SrqDm6658/SD/SrqDm6658-mobile.mp4"]] progress:^(NSProgress * _Nonnull downloadProgress) {
                
                hud.el_progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
                
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                return targetPath;
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                [ELProgressHud hideHudAtView:self.view];
            }];
            
            [task resume];
            hud.elCompletion = ^() {
                [task cancel];
            };
        }
            break;
        case ELProgressHudTypeIndicatorAndText:
        {
            ELProgressHud *hud = [[ELProgressHud alloc] initWithHudType:ELProgressHudTypeIndicatorAndText];
            hud.textLabel.text = @"一盏黄黄旧旧的灯~";
            hud.delay = 2.0;
            [hud showHudAtView:self.view];
            
        }
            break;
        case ELProgressHudTypeProgressAndText:
        {
            ELProgressHud *hud = [[ELProgressHud alloc] initWithHudType:ELProgressHudTypeProgressAndText];
            hud.textLabel.text = @"静静看着凌晨黄昏~";
            [hud showHudAtView:self.view];
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:nil];
            NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://flv2.bn.netease.com/videolib3/1607/14/SrqDm6658/SD/SrqDm6658-mobile.mp4"]] progress:^(NSProgress * _Nonnull downloadProgress) {
                
                hud.el_progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
                
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                return targetPath;
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                [ELProgressHud hideHudAtView:self.view];
            }];
            
            [task resume];
        }
            break;
        case ELProgressHudTypeGif:
        {
            ELProgressHud *hud = [[ELProgressHud alloc] initWithHudType:ELProgressHudTypeGif];
            hud.el_images = @[@"11", @"12", @"13", @"14"];
            [hud showHudAtView:self.view];
            [self performSelector:@selector(hide) withObject:nil afterDelay:5.0];
        }
            break;
        case ELProgressHudTypeDrawCircle:
        {
            ELProgressHud *hud = [[ELProgressHud alloc] initWithHudType:ELProgressHudTypeDrawCircle];
            [hud showHudAtView:self.view];
         
            
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:nil];
            NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://flv2.bn.netease.com/videolib3/1607/14/SrqDm6658/SD/SrqDm6658-mobile.mp4"]] progress:^(NSProgress * _Nonnull downloadProgress) {
                
                hud.el_strokeStart = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
                
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                return targetPath;
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                [ELProgressHud hideHudAtView:self.view];
            }];
            
            [task resume];
        }
            break;
        default:
            break;
    }
}

- (void)hide {
    [ELProgressHud hideHudAtView:self.view];
}

#pragma mark - setter & getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"ELProgressHudTypeIndicator", @"ELProgressHudTypeText", @"ELProgressHudTypeProgress", @"ELProgressHudTypeProgressWithCancel", @"ELProgressHudTypeIndicatorAndText", @"ELProgressHudTypeProgressAndText", @"ELProgressHudTypeGif", @"ELProgressHudTypeDrawCircle"]];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

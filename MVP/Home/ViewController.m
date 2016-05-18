//
//  ViewController.m
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "ViewController.h"
#import "TemplateChannelModel.h"
#import "TemplateContainerModel.h"
#import "WebViewController.h"
#import "TemplateCellProtocol.h"
#import "TemplateSorbRenderProtocol.h"
#import "UITableView+Template.h"

#import "TemplateActionHandler.h"
#import "TemplateAction.h"
#import "ViewController+Template.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,TemplateActionHandlerDelegate>

@property (nonatomic,strong) TemplateChannelModel  *floorModel;
@property (nonatomic,strong) TemplateActionHandler *handler;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Index";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registTableViewCell];
    [self addShareBarButtonItemWihtModel:nil];
    
    [self fetchData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
    //或
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

- (TapBlock)tapBlockForModel:(id<TemplateRenderProtocol>)model
{
    __weak typeof (self) weakself = self;
    return ^(NSIndexPath * indexPath){
        if ([model conformsToProtocol:@protocol(TemplateActionProtocol)]) {
            TemplateAction *action = [(id<TemplateActionProtocol>)model jumpFloorModelAtIndexPath:indexPath];
            [weakself.handler handlerAction:action];
        }
    };
}

- (void)fetchData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    __weak typeof (self) weakself = self;
    [SVProgressHUD show];
    [manager GET:@"http://sunnycn2013.github.io/MVP/food.json"
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject){
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:nil];
             weakself.floorModel = [TemplateChannelModel mj_objectWithKeyValues:dic];
             [_tableView.mj_header endRefreshing];
             [SVProgressHUD dismiss];

             //更新UI
             [weakself.tableView reloadData];
         }
         failure:^(NSURLSessionDataTask *task, NSError *error){
             [SVProgressHUD dismiss];
         }];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.floorModel.floors count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TemplateContainerModel<TemplateContainerProtocol> *list = self.floorModel.floors[section];
    return [list numberOfChildModelsInContainer];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <TemplateRenderProtocol> model = [self.floorModel rowModelAtIndexPath:indexPath];
    UITableViewCell <TemplateCellProtocol> * cell = [tableView dequeueReusableCellWithIdentifier:[model floorIdentifier]];
    [cell processData:model];
    [cell tapOnePlace:[self tapBlockForModel:model]];
    if(!cell){
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }else{
        return (UITableViewCell *)cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id <TemplateRenderProtocol>  floor = [self.floorModel rowModelAtIndexPath:indexPath];
    if ([floor respondsToSelector:@selector(floorIdentifier)]) {
        NSString *cellIdentifier = [floor floorIdentifier];
        Class<TemplateCellProtocol> viewClass = NSClassFromString(cellIdentifier);
        CGSize size = [viewClass calculateSizeWithData:floor constrainedToSize:CGSizeMake(tableView.frame.size.width, 0.0)];
        return size.height;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    id <TemplateSorbRenderProtocol,TemplateRenderProtocol> floor = self.floorModel.floors[section];
    if ([floor conformsToProtocol:@protocol(TemplateSorbRenderProtocol)]) {
        NSString *headerIdentifier = [floor headerFloorIdentifier];
        if (headerIdentifier) {
            Class<TemplateCellProtocol> viewClass = NSClassFromString(headerIdentifier);
            CGSize size = [viewClass calculateSizeWithData:floor constrainedToSize:CGSizeMake(tableView.frame.size.width, 0.0)];
            return size.height;
        }
    }

    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    id <TemplateSorbRenderProtocol,TemplateRenderProtocol> floor = self.floorModel.floors[section];
    if ([floor conformsToProtocol:@protocol(TemplateSorbRenderProtocol)]) {
        id<TemplateSorbRenderProtocol> headerModel = [floor headerFloorModelAtIndex:section];
        if (headerModel) {
            NSString *identifier = [headerModel headerFloorIdentifier];
            UIView <TemplateCellProtocol> *headerView = (UIView <TemplateCellProtocol> *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
            [headerView processData:floor];
            return headerView;
        }
    }
    return nil;
}

#pragma makk - set get

- (TemplateActionHandler *)handler
{
    if (!_handler) {
        _handler = [[TemplateActionHandler alloc] init];
        _handler.delegate = self;
    }
    return _handler;
}

@end

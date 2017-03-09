//
//  ViewController.m
//  UITableViewCell单选cell
//
//  Created by Franta on 17/3/9.
//  Copyright © 2017年 Franta. All rights reserved.
//

#import "ViewController.h"
#import "ChoseCell.h"
//屏幕宽、高
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSIndexPath * path;
    NSMutableArray * dataArr;        // 所有成员
    UITableView * userTab;
}

@end

@implementation ViewController

#pragma mark ****1.视图生命周期**
-(void)viewDidLoad{
    [super viewDidLoad];

    self.navigationItem.title = @"cell单选";
    dataArr=[NSMutableArray array];
    [self createUI];
    [self getdatas];
}

-(void)getdatas{
    for (int i=0;i<10; i++) {
        [dataArr addObject:[NSString stringWithFormat:@"测试 %d 号",i]];
    }
    [userTab reloadData];
    
}

#pragma mark ****2.ui界面**
-(void)createUI{
    
    userTab=[[UITableView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets=NO;
    userTab.delegate=self;
    userTab.dataSource=self;
    [userTab registerClass:[ChoseCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:userTab];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * inde=@"cell";
    ChoseCell* cell=[tableView dequeueReusableCellWithIdentifier:inde forIndexPath:indexPath];
    if (dataArr.count>0) {
        cell.isSele=NO;
        cell.stateV.image=[UIImage imageNamed:@"cb_side_false"];
        cell.nameLabel.text=dataArr[indexPath.row];
        
        if (indexPath==path) {
            cell.isSele=YES;
            cell.stateV.image=[UIImage imageNamed:@"cb_side_true"];
        }
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ChoseCell * cell=(ChoseCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (path) {
        ChoseCell * cell1=(ChoseCell *)[tableView cellForRowAtIndexPath:path];
        cell1.isSele=NO;
        cell1.stateV.image=[UIImage imageNamed:@"cb_side_false"];
        cell1.userInteractionEnabled=YES;
        
    }
    path = indexPath; //用来保存选中目标位置
    cell.isSele=YES;
    cell.stateV.image=[UIImage imageNamed:@"cb_side_true"];
    cell.userInteractionEnabled=NO;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


@end

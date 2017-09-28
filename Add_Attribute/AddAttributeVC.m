

//
//  AddAttributeVC.m
//  AddAttribute
//
//  Created by 陈楠 on 17/8/15.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import "AddAttributeVC.h"
#import "AddAttriCollCell.h"
#import "AddAttriCollReusableView.h"
#import "AttriModel.h"
#import "AttriSepecModel.h"
#define MaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
#define MaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度

@interface AddAttributeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,AddAttriCollCellDelegate>

/**
 自定义的规格组
 */
@property (nonatomic, retain)NSMutableArray *attriArr;
/**
 品牌名的HCInfoInputView
 */
@property (nonatomic, retain)HCInfoInputView *infoView2;
@property (nonatomic, retain)UICollectionView *collectionView;


@end

@implementation AddAttributeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //1. 添加 HCInfoInputView
    [self addhcInfoInputView];
    
    //2. 初始化 UICollectionView
    [self addConllectView];
    
    //3. 初始化 保存按钮
    [self addSaveBtn];
    
    //4. 配置数据
    [self dataInit];
}

- (void)dataInit{
    self.view.backgroundColor = [UIColor colorWithRed:222/255.0 green:223/255.0 blue:224/255.0 alpha:1];
    self.navigationItem.title = @"自定义品牌、规格参数";
    self.attriArr = [NSMutableArray array];
    
    NSMutableArray *arr = [NSMutableArray array];
    AttriModel *model = [[AttriModel alloc]init];
    AttriSepecModel *md = [[AttriSepecModel alloc]init];
    md.name = @"";
    [arr addObject:md];
    model.arrModel = arr;
    [self.attriArr addObject:model];

}

#pragma mark - HCInfoInputView的使用
- (void)addhcInfoInputView{
    
   
    HCInfoInputView *infoView = [[HCInfoInputView alloc]initWithCellborderFrame:CGRectMake(0, 10+64, kScreenW, 44) withInfoName:@"选择分类"];
    [self.view addSubview:infoView];
    __weak __typeof(infoView) weakinfoView = infoView;
    infoView.InputViewBlock = ^(NSString *textt){
    weakinfoView.detailText = @"跳到相关页面";
    };
    
    HCInfoInputView *infoView1 = [[HCInfoInputView alloc]initWithFrame:CGRectMake(0, MaxY(infoView)+10, kScreenW, 44) withInfoName:@"品牌名" withInfoPlaceholder:@"自定义您的品牌名称"];
    [self.view addSubview:infoView1];
    self.infoView2 = infoView1;
    infoView1.InputViewBlock = ^(NSString *text){
    };
    
}

#pragma mark - UICollectionView
- (void)addConllectView{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake((kScreenW - 20)/5, 35.0f/SCY);
    
    //  确定了缩进，上下左右四个偏移量
    layout.sectionInset = UIEdgeInsetsMake(5,5,5,5);
    
    //  每个cell之间的间距
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, MaxY(self.infoView2)+10, kScreenW, kScreenH - 108) collectionViewLayout:layout];
    [self.collectionView registerClass:[AddAttriCollCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.collectionView registerClass:[AddAttriCollReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
     [self.collectionView registerClass:[AddAttriCollReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    self.collectionView.backgroundColor = [UIColor colorWithRed:222/255.0 green:223/255.0 blue:224/255.0 alpha:1];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
}
#pragma mark - 保存按钮
- (void)addSaveBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, kScreenH - 44, kScreenW, 44);
    [btn setTitle:@"保存" forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [btn addTarget:self action:@selector(saveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = APPBackgroundCorlor;
    [self.view addSubview:btn];

}


#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AddAttriCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.attriTextField.delegate = self;
    AttriModel *mdoel = _attriArr[indexPath.section];
    AttriSepecModel *mo = mdoel.arrModel[indexPath.item];
    cell.delegate = self;
    cell.section = indexPath.section;
    if (indexPath.item == 0) {
        cell.attriTextField.enabled = YES;
        cell.attriTextField.placeholder = @"+添加规格";
        cell.button.hidden = YES;
        cell.attriTextField.text = @"";
    }else{
        cell.attriTextField.enabled = NO;
        cell.button.hidden = NO;
        cell.attriTextField.text = mo.name;
    }
      return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     AttriModel *mo = _attriArr[section];
    return mo.arrModel.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  self.attriArr.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

//头部视图---此处添加规格名
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        AddAttriCollReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header"forIndexPath:indexPath];
        headerView.section = indexPath.section;
        [headerView setAttriHeaderTitle:@""];
        AttriModel *md = _attriArr[indexPath.section];
        headerView.headerBlock = ^(NSString *text,NSInteger section){
            if (section>self.attriArr.count-1 ) {
                return ;
            }
             AttriModel *mo = _attriArr[section];
             mo.name = text;
        };
        if (md.name.length>0) {
            headerView.headerInfo.detailText = md.name;
        }
        if (indexPath.section == 0) {
            headerView.headerBtn.hidden = YES;
        }else{
            headerView.headerBtn.hidden = NO;
        }
        headerView.headerDeleBlock = ^(NSString *text,NSInteger section){
            [self.attriArr removeObjectAtIndex:section];
            [self.collectionView reloadData];
        };
        
        return headerView;
    }else{
        if (_attriArr.count-1 == indexPath.section) {
            AddAttriCollReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer"forIndexPath:indexPath];
            [footerView setAttriFooterTitle:@""];
            footerView.footerBlock = ^(){
                NSMutableArray *arr = [NSMutableArray array];
                AttriModel *model = [[AttriModel alloc]init];
                AttriSepecModel *md = [[AttriSepecModel alloc]init];
                md.name = @"";
                [arr addObject:md];
                model.arrModel = arr;
                [self.attriArr addObject:model];
                [self.collectionView reloadData];
            };
            return footerView;
        }else{
            return nil;
        }
    }
   
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.frame.size.width, 40);
}



// 设置section尾视图的参考大小，与tablefooterview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    NSLog(@"==========%ld=======%lu",(long)section,(unsigned long)self.attriArr.count);
    if (self.attriArr.count-1 == section) {
        return CGSizeMake(self.view.frame.size.width, 40);
    }else{
         return CGSizeMake(0, 0);
    }

}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger section = textField.tag - 100;
    AttriModel *mo = _attriArr[section];
    NSLog(@"===========%ld",section);
    if (textField.text.length > 0) {
        AttriSepecModel *model = [[AttriSepecModel alloc]init];
        model.name = textField.text;
        [mo.arrModel addObject:model];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
    }
    textField.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - AddAttriCollCellDelegate
- (void)AddAttriCollCell:(AddAttriCollCell *)AttriCollCell withSection:(NSInteger )section{
    NSLog(@"=====section==%ld",(long)section);
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:AttriCollCell];
    NSInteger row = indexPath.row;
    
    AttriModel *model = _attriArr[section];
    [model.arrModel removeObjectAtIndex:row];
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
}

#pragma mark - save data
- (void)saveBtnAction:(UIButton *)sender{
  
      NSString *sepec = @"";
    for (AttriModel *mo in _attriArr) {
        NSString *sepecStr = mo.name;
        for (AttriSepecModel *mod in mo.arrModel) {
            if (mod.name.length == 0) {//去除默认的第一个空
                continue;
            }
        sepecStr = [NSString stringWithFormat:@"%@/%@",sepecStr,mod.name];
    }
       sepec = [NSString stringWithFormat:@"%@,%@",sepec,sepecStr];
       
    }
    sepec = [sepec substringFromIndex:1];
     NSLog(@"==========保存成功===%@=====",sepec);
}



@end

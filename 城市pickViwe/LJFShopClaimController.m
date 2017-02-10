//
//  LJFShopClaimController.m
//  GroupBuy
//
//  Created by ljf on 2017/2/8.
//  Copyright © 2017年 招. All rights reserved.
//

#import "LJFShopClaimController.h"
#import "MJExtension.h"

#import "LJFProvinceModle.h"
#import "MBProgressHUD.h"

@interface LJFShopClaimController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIPickerView * locationPickView;
@property (nonatomic,strong)UITextField * textFueld;
@property (nonatomic,strong)UITextField * detailLocation;

//省
@property (nonatomic,strong)NSArray * provinces;
//市
@property (nonatomic,strong)NSArray * cites;
//县
@property (nonatomic,strong)NSArray * countes;




@end

@implementation LJFShopClaimController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubView];
    
    [self provinces];
}

-(void)addSubView{
    
    CGSize  size = [UIScreen mainScreen].bounds.size;
    //提示
    UILabel * hint = [[UILabel alloc] init];
    hint.text = @"店铺地址:";
    hint.font = [UIFont systemFontOfSize:15];
    hint.frame = CGRectMake(size.width/2-180, 100, 80, 30);
    [self.view addSubview:hint];
    
    //输入
    UITextField * textFueld = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hint.frame), 100,size.width -150 , 40)];
    textFueld.font = [UIFont systemFontOfSize:15];
    textFueld.inputView = self.locationPickView;
    self.textFueld = textFueld;
    
    [self.view addSubview:textFueld];
    
    //添加一根线
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hint.frame)-10, CGRectGetMaxY(hint.frame), CGRectGetWidth(textFueld.frame)+10, 1)];
    line.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:line];
    
   
    
    //详细地址
    //输入部分
    UITextField * detailLocation = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hint.frame), CGRectGetMaxY(textFueld.frame)+20,size.width -150 , 30)];
    detailLocation.font = [UIFont systemFontOfSize:15];
    detailLocation.placeholder = @"请输入详细地址";
    self.detailLocation = detailLocation;
    [self.view addSubview:detailLocation];
    
    //添加一根线
    UIView * detailLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hint.frame)-10, CGRectGetMaxY(detailLocation.frame)-5, CGRectGetWidth(detailLocation.frame)+10,1)];
    detailLine.backgroundColor = [UIColor grayColor];
        [self.view addSubview:detailLine];
    
    
    //添加保存按钮
    UIButton * btn = [[UIButton alloc] init];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.frame = CGRectMake(size.width * 0.2, size.height*0.7,250 , 50);
    [btn setBackgroundImage:[UIImage imageNamed:@"anniu_"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"beijingtu_"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(didClickSave) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

-(void)didClickSave{
    MBProgressHUD * mb = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mb.label.text = @"保存成功";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
//        [self.navigationController popViewControllerAnimated:YES];
        [mb hideAnimated:YES];
    });
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.detailLocation resignFirstResponder];
    [self.textFueld resignFirstResponder];
    [self.view resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIPickerView *)locationPickView{
    
    if (_locationPickView !=nil) {
        return _locationPickView;
    }
    UIPickerView * pick = [[UIPickerView alloc] init];
    pick.delegate = self;
    pick.dataSource = self;
    return pick;
}


#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return self.provinces.count;
    }else if (component == 1){
        
       NSInteger twoCom = [pickerView selectedRowInComponent:0];
        LJFProvinceModle * proM = self.provinces[twoCom];
        if (twoCom == 2) {
            
            NSLog(@"%@",proM.name);
        }
        return proM.cities.count;
    }else{
        //选种第一组的row
        NSInteger oneCom = [pickerView selectedRowInComponent:0];
        //选种第二组的row
        NSInteger twoCom = [pickerView selectedRowInComponent:1];
        
        LJFProvinceModle * provines = self.provinces[oneCom];
        LJFProvinceModle * cites = provines.cities[twoCom];

        return cites.cities.count;
    }
    
}


#pragma mark UIPickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component ==0) {
       
        LJFProvinceModle * pM = self.provinces[row];
        return [NSString stringWithFormat:@"%@",pM.name];
       }else if (component == 1){
        
        NSInteger twoCom = [pickerView selectedRowInComponent:0];
        LJFProvinceModle * proM = self.provinces[twoCom];
        LJFProvinceModle * cites = proM.cities[row];
        return [NSString stringWithFormat:@"%@",cites.name];
    }else{
       
        //选种第一组的row
        NSInteger oneCom = [pickerView selectedRowInComponent:0];
        //选种第二组的row
        NSInteger twoCom = [pickerView selectedRowInComponent:1];
        
        LJFProvinceModle * provines = self.provinces[oneCom];
        LJFProvinceModle * cites = provines.cities[twoCom];
        LJFProvinceModle *cuntes = cites.cities[row];
        return [NSString stringWithFormat:@"%@",cuntes.name];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
   
    if (component == 0) {
        
        //刷新第二组及第三组数据
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
       
        NSInteger oneCom = [pickerView selectedRowInComponent:0];
        LJFProvinceModle * oneM = self.provinces[oneCom];
        self.textFueld.text = oneM.name;
    
    }else if (component == 1){
        
        //刷新第三组数据
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];

       
        NSInteger oneCom = [pickerView selectedRowInComponent:0];
        NSInteger twoCom = [pickerView selectedRowInComponent:1];

        LJFProvinceModle * oneM = self.provinces[oneCom];
        LJFProvinceModle * twoM = oneM.cities[twoCom];
        
        NSString * name = [NSString stringWithFormat:@"%@ %@",oneM.name,twoM.name];
        self.textFueld.text = name;
        
    }else{
        NSInteger oneCom = [pickerView selectedRowInComponent:0];
        NSInteger twoCom = [pickerView selectedRowInComponent:1];
        
        LJFProvinceModle * oneM = self.provinces[oneCom];
        LJFProvinceModle * twoM = oneM.cities[twoCom];
        LJFProvinceModle * threeM = twoM.cities[row];
        
        NSString * name = [NSString stringWithFormat:@"%@ %@ %@",oneM.name,twoM.name,threeM.name];
        self.textFueld.text = name;
     }
}


-(NSArray *)provinces{
    
    if (_provinces != nil) {
       return _provinces;
    }
    NSArray * array = [[LJFProvinceModle new] loadInfoWithPlist];
    _provinces = array.copy;
    return _provinces;
}

@end

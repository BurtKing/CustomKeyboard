//
//  KeyboardView.m
//  CustomKeyboard
//
//  Created by Burt on 2017/5/22.
//  Copyright © 2017年 com.uqiauto. All rights reserved.
//

#import "KeyboardView.h"
#import "SVProgressHUD.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation KeyboardView

-(instancetype)init
{
    if (self=[super init]) {
        self.frame=CGRectMake(0, HEIGHT-((WIDTH-10*5)/10.00*5+55), WIDTH, (WIDTH-10*5)/10.00*5+55);
        _canPlaySound=YES;
        
//第一行数字
        NSArray * line1=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
        [self layoutBtnWithDataSource:line1 LeftMargin:2.5 topMargin:10];
//第二行字母
        NSArray * line2=@[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"];
        [self layoutBtnWithDataSource:line2 LeftMargin:2.5 topMargin:20+(WIDTH-10*5)/10.00];
//第三行字母
        NSArray * line3=@[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"];
        [self layoutBtnWithDataSource:line3 LeftMargin:(WIDTH-(WIDTH-10*5)/10.00*9-5*8)/2.00 topMargin:30+(WIDTH-10*5)/10.00*2];
//第四行字母
        NSArray * line4=@[@"Z",@"X",@"C",@"V",@"B",@"N",@"M"];
        [self layoutBtnWithDataSource:line4 LeftMargin:(WIDTH-(WIDTH-10*5)/10.00*7-5*6)/2.00 topMargin:40+(WIDTH-10*5)/10.00*3];
        
        UIButton * soundBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        soundBtn.backgroundColor=[UIColor whiteColor];
        soundBtn.layer.cornerRadius=4;
        soundBtn.layer.masksToBounds=YES;
        soundBtn.frame=CGRectMake(2.5, 40+(WIDTH-10*5)/10.00*3, (WIDTH-(WIDTH-10*5)/10.00*7-5*6)/2.00-2.5-5, (WIDTH-10*5)/10.00);
        [soundBtn setImage:[UIImage imageNamed:@"notification"] forState:UIControlStateNormal];
        [soundBtn addTarget:self action:@selector(soundStatus:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:soundBtn];
        
        UIButton * deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.backgroundColor=[UIColor whiteColor];
        deleteBtn.layer.cornerRadius=4;
        deleteBtn.layer.masksToBounds=YES;
        deleteBtn.frame=CGRectMake(WIDTH-((WIDTH-(WIDTH-10*5)/10.00*7-5*6)/2.00-2.5-5)-2.5, 40+(WIDTH-10*5)/10.00*3, ((WIDTH-(WIDTH-10*5)/10.00*7-5*6)/2.00-2.5-5), (WIDTH-10*5)/10.00);
        [deleteBtn setImage:[UIImage imageNamed:@"delete2"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        
//第五行
        _label=[[UILabel alloc]initWithFrame:CGRectMake(2.5, 50+(WIDTH-10*5)/10.00*4, WIDTH-5-60-10, (WIDTH-10*5)/10.00)];
        _label.backgroundColor=[UIColor whiteColor];
        _label.textAlignment=NSTextAlignmentCenter;
        _label.layer.cornerRadius=4;
        _label.layer.masksToBounds=YES;
        _label.text=@"0位";
        [self addSubview:_label];
        
        UIButton * searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.frame=CGRectMake(_label.frame.origin.x+_label.frame.size.width+10, 50+(WIDTH-10*5)/10.00*4, 60, (WIDTH-10*5)/10.00);
        searchBtn.backgroundColor=[UIColor whiteColor];
        searchBtn.backgroundColor=[UIColor blueColor];
        [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        searchBtn.layer.cornerRadius=4;
        searchBtn.layer.masksToBounds=YES;
        [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:searchBtn];
    }
    
    return self;
}


-(void)layoutBtnWithDataSource:(NSArray*)array LeftMargin:(CGFloat)leftMargin topMargin:(CGFloat)topMargin
{
    for (int i=0; i<array.count; i++) {
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(leftMargin+i*((WIDTH-10*5)/10.00+5), topMargin, (WIDTH-10*5)/10.00, (WIDTH-10*5)/10.00);
        btn.backgroundColor=[UIColor whiteColor];
        btn.layer.cornerRadius=4;
        btn.layer.masksToBounds=YES;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClcik:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}


-(void)soundStatus:(UIButton*)btn
{
    _canPlaySound=!_canPlaySound;
    if (_canPlaySound) {
        [SVProgressHUD showSuccessWithStatus:@"声音播放已开启！"];
    }else{
        [SVProgressHUD showErrorWithStatus:@"声音播放已关闭！"];
    }
}


-(void)btnClcik:(UIButton *)btn
{
    if (_delegate&&[_delegate respondsToSelector:@selector(btnClcik:)]) {
        [_delegate btnClcik:btn];
    }
}

-(void)deleteClick:(UIButton*)btn
{
    if (_delegate&&[_delegate respondsToSelector:@selector(deleteClick:)]) {
        [_delegate deleteClick:btn];
    }
}

-(void)searchBtnClick:(UIButton*)btn
{
    if (_delegate&&[_delegate respondsToSelector:@selector(searchBtnClick:)]) {
        [_delegate searchBtnClick:btn];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  KeyboardView.h
//  CustomKeyboard
//
//  Created by Burt on 2017/5/22.
//  Copyright © 2017年 com.uqiauto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol customKeyboardDelegate <NSObject>

-(void)btnClcik:(UIButton *)btn;
-(void)deleteClick:(UIButton*)btn;
-(void)searchBtnClick:(UIButton*)btn;

@end

@interface KeyboardView : UIView

@property(nonatomic,weak)id<customKeyboardDelegate> delegate;
@property(nonatomic,assign)BOOL canPlaySound;
@property(nonatomic,strong)UILabel * label;

@end


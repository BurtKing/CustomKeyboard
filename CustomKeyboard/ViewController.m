//
//  ViewController.m
//  CustomKeyboard
//
//  Created by Burt on 2017/5/22.
//  Copyright © 2017年 com.uqiauto. All rights reserved.
//

#import "ViewController.h"
#import "KeyboardView.h"

#import <AVFoundation/AVFoundation.h>

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITextViewDelegate,customKeyboardDelegate>
{
    UITextView  * tv;
    KeyboardView * keyboard;
}
@property (strong, nonatomic) AVAudioPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    tv=[[UITextView alloc]initWithFrame:CGRectMake(30, 20, 100, 50) textContainer:nil];
    tv.delegate=self;
    tv.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:tv];
    
    
}


-(void)keyboardWillShow:(NSNotification*)not
{
    [tv endEditing:NO];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    keyboard=[[KeyboardView alloc]init];
    keyboard.delegate=self;
    keyboard.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:keyboard];
    
    return YES;
}

-(void)btnClcik:(UIButton *)btn
{
    if (tv.text.length<17) {
        
        if (keyboard.canPlaySound) {
            [self playSoundEffect:[NSString stringWithFormat:@"key_%@",[btn.titleLabel.text lowercaseString]]];
        }
        
        NSString * str=[tv.text stringByAppendingString:btn.titleLabel.text];
        tv.text=str;
        keyboard.label.text=[NSString stringWithFormat:@"%lu位",(unsigned long)tv.text.length];
        
        if (tv.text.length==17) {
            if ([self judgeVIN]) {
                
            }else{
                keyboard.label.text=[NSString stringWithFormat:@"not fit"];
            }
        }

    }else{
        
    }
}

-(void)deleteClick:(UIButton *)btn
{
    if (tv.text.length>0) {
        NSString * str=[tv.text substringToIndex:[tv.text length]-1];
        tv.text=str;
        keyboard.label.text=[NSString stringWithFormat:@"%lu位",(unsigned long)tv.text.length];
    }
}


-(void)searchBtnClick:(UIButton *)btn
{
    
}


- (void)playSoundEffect:(NSString *)name
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
    NSURL *audioUrl = [NSURL fileURLWithPath:audioPath];
    NSError *playerError;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioUrl error:&playerError];
    if (_player == NULL)
    {
        return;
    }
    [_player setNumberOfLoops:0];
    [_player setVolume:10];
    [_player prepareToPlay];
    [_player play];
}

-(BOOL)judgeVIN
{
    
    NSMutableDictionary * weights=[NSMutableDictionary dictionaryWithDictionary:@{@"1":@"8",@"2":@"7",@"3":@"6",@"4":@"5",@"5":@"4",@"6":@"3",@"7":@"2",@"8":@"10",@"9":@"0",@"10":@"9",@"11":@"8",@"12":@"7",@"13":@"6",@"14":@"5",@"15":@"4",@"16":@"3",@"17":@"2"}];
    NSMutableDictionary * values=[NSMutableDictionary dictionaryWithDictionary:@{@"0":@"0",@"1":@"1",@"2":@"2",@"3":@"3",@"4":@"4",@"5":@"5",@"6":@"6",@"7":@"7",@"8":@"8",@"9":@"9",@"A":@"1",@"B":@"2",@"C":@"3",@"D":@"4",@"E":@"5",@"F":@"6",@"G":@"7",@"H":@"8",@"J":@"1",@"K":@"2",@"M":@"4",@"L":@"3",@"N":@"5",@"P":@"7",@"R":@"9",@"S":@"2",@"T":@"3",@"U":@"4",@"V":@"5",@"W":@"6",@"X":@"7",@"Y":@"8",@"Z":@"9"}];
    
    
    if ([tv.text containsString:@"I"]||[tv.text containsString:@"O"]) {
        return NO;
    }else{
        int sum=0;
        for (int i=0; i<tv.text.length; i++) {
            int value=[values[[NSString stringWithFormat:@"%@",[tv.text substringWithRange:NSMakeRange(i, 1)]]] intValue];
            int weight=[weights[[NSString stringWithFormat:@"%d",i+1]] intValue];
            
            sum+=value*weight;
        }
        if (sum % 11 == 10) {
            if ([tv.text characterAtIndex:8] == 'X') {
                return YES;
            } else {
                return NO;
            }
            
        } else {
            if (sum % 11 != [values[[NSString stringWithFormat:@"%@",[tv.text substringWithRange:NSMakeRange(8, 1)]]] intValue]) {
                return NO;
            } else {
                return YES;
            }
        }
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

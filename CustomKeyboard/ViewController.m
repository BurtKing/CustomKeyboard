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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

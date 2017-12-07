//
//  DPPasswordView.m
//  DPPassword
//
//  Created by Heaven on 2017/12/7.
//Copyright © 2017年 heaven. All rights reserved.
//

#import "DPPasswordView.h"
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define PWCount 6
#define TFHeight 45
#define SpotWidth 10 //黑点直径
#define BoardColor [UIColor lightGrayColor]

@interface DPPasswordView ()<UITextFieldDelegate>
@property (nonatomic ,strong)UIView *backView;

@property (nonatomic,strong)UITextField *pwTextField;

/**
 存放黑点数组
 */
@property (nonatomic,strong)NSMutableArray *viewArray;

@end

@implementation DPPasswordView

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (DPPasswordView *)showPaddwordViewBack:(PasswordBlock)password cancle:(CanclePayBlock)cancle{
    DPPasswordView *passwordView = [[DPPasswordView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    passwordView.passWordBlock = password;
    passwordView.caneleBlock = cancle;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:passwordView];
    return passwordView;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:nil];
        
    }
    return self;
}

- (void)initUI{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-150, kScreenWidth , 150)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    UIButton *cancleB = [UIButton buttonWithType:UIButtonTypeSystem];
    cancleB.frame = CGRectMake(15, 15, 20, 20);
    [cancleB addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [cancleB setBackgroundImage:[UIImage imageNamed:@"pay_close"] forState:UIControlStateNormal];
    [self.backView addSubview:cancleB];
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, kScreenWidth-100, 50)];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = @"支付密码";
    [self.backView addSubview:titleL];
    
    //输入框
    self.pwTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 50, kScreenWidth-80, TFHeight)];
    self.pwTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.pwTextField.textColor = [UIColor whiteColor];
    self.pwTextField.tintColor = [UIColor whiteColor];
    self.pwTextField.delegate = self;
    [self.pwTextField becomeFirstResponder];
    [self.backView addSubview:self.pwTextField];
    
    //边框
    UIView *bordView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.pwTextField.frame), CGRectGetMinY(self.pwTextField.frame), CGRectGetWidth(self.pwTextField.frame), TFHeight)];
    bordView.layer.cornerRadius = 5;
    bordView.layer.borderWidth = .5;
    bordView.layer.borderColor = BoardColor.CGColor;
    [self.backView addSubview:bordView];
    
    CGFloat w = bordView.frame.size.width/6;
    for (int i=1; i <6; i ++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(w*i, 0, .5, TFHeight)];
        line.backgroundColor = BoardColor;
        [bordView addSubview:line];
    }
    
    //黑点
    
    self.viewArray = [NSMutableArray array];
    for (int i=0; i<6; i++) {
        UIView *spot = [[UIView alloc]initWithFrame:CGRectMake(w/2-SpotWidth/2+w*i,bordView.frame.size.height/2-SpotWidth/2 , SpotWidth, SpotWidth)];
        spot.backgroundColor = [UIColor blackColor];
        spot.layer.cornerRadius = SpotWidth/2;
        spot.layer.masksToBounds = YES;
        spot.hidden = YES;
        [bordView addSubview:spot];
        [self.viewArray addObject:spot];
    }
    
}
#pragma mark - Delegate
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backView.frame = CGRectMake(0, kScreenHeight-150-height, kScreenWidth , 150+height);
    }];
    
   
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (![string isEqualToString:@""]) {
        if (self.pwTextField.text.length >= 6) {
            return NO;
        }
    }
    
    return YES;
}


- (void)textFieldDidChange:(NSNotification *)aNotification{
    UITextField *textField = aNotification.object;
    for (int i = 0; i < self.viewArray.count; i++) {
        UIView *view = (UIView *) [self.viewArray objectAtIndex:i];
        view.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        UIView *view = (UIView *) [self.viewArray objectAtIndex:i];
        view.hidden = NO;
    }
    
    if (self.pwTextField.text.length >= 6) {
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
            self.passWordBlock(self.pwTextField.text);
        });
        
    }
    
}


#pragma mark - Event Handle

- (void)cancle{
    [self.pwTextField resignFirstResponder];
    [self removeFromSuperview];
}

#pragma mark - Private Method

#pragma mark - Public Method

#pragma mark - Getter 和 Setter

@end

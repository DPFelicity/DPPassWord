# DPPassWord
模仿支付宝密码输入框

一行代码即可调用非常方便，只有一个TextField，不会产生错乱

[DPPasswordView showPaddwordViewBack:^(NSString *passWord) {
        
   self.pw.text = passWord;
        
 } cancle:^{
    
 }];

1、创建一个TextField，在上边放一层View作为边框，

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

2、黑点用View来实现，放入一个数组中

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
3、通知监听输入的变化

[[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:nil];


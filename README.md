# DPPassWord
模仿支付宝密码输入框

一行代码即可调用非常方便，只有一个TextField，不会产生错乱

[DPPasswordView showPaddwordViewBack:^(NSString *passWord) {
        
   self.pw.text = passWord;
        
 } cancle:^{
    
 }];

1、创建一个TextField，在上边放一层View作为边框

2、黑点用View来实现，放入一个数组中

3、通知监听输入的变化



//
//  ViewController.m
//  CaculatorZetPro
//
//  Created by Chun NingShen on 2013/11/12.
//  Copyright (c) 2013年 Think Better. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int add,sub,mul,div;    //加減乘除(開關)
    int secondNumberOnOrOff;  //第二次輸入(開關)
    int pointOnOrOff;  //小數點判斷(開關)
    int immediateTransform; //儲存單位換算(代號)
    double strConversionNum;    //儲存字串轉數字
    
    double allConversionUnifiedValue;  //全部轉換統一值
    
    
    NSString* saveNumber1;  //第一輸入數字
    NSString* saveNumber2;  //第二輸入數字
    NSString* tenmpString;  //答案轉換成字串
    
    NSMutableArray* allArray;   //全部
    NSMutableArray* lengthArrary;   //長度
    NSMutableArray* timeArray;      //時間
    NSMutableArray* weightArrary;   //重量
    NSMutableArray* speedArrary;    //速度
    NSMutableArray* exchangeRateArrary; //匯率
    
    NSNumberFormatter* numberFormatter;
    NSNumber* myNumber1;
    NSNumber* myNumber2;
    NSNumber* myNumberAnswer;

    
}
@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated{
//設定 iOS 7, 3.5"/4" 畫面
    
    CGSize frameSize = self.view.frame.size;//螢幕大小
    
    if (frameSize.height <= 480) {
        self.labelUnitDst.frame = CGRectMake(270, 20, 50, 57);
        self.labelUnitSrc.frame = CGRectMake(270, 77, 50, 57);
        self.labelTransResult.frame = CGRectMake(5, 20, 265, 52);
        self.labelResult.frame = CGRectMake(5, 72, 265, 62);
        self.viewCalculate.frame = CGRectMake(0, 134, 320, 280);
        self.viewTransform.frame = CGRectMake(0, 414, 320, 66);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    allArray=[[NSMutableArray alloc] initWithCapacity:0];   //歸零
    
    lengthArrary=[NSMutableArray arrayWithObjects:@"毫米", @"公分", @"公尺", @"公里", @"英里", @"碼", @"吋", @"海里", nil];
    timeArray=[NSMutableArray arrayWithObjects:@"秒",@"分",@"時",@"天",@"周",@"月",@"年",nil];
    weightArrary=[NSMutableArray arrayWithObjects:@"克", @"兩", @"台斤", @"公斤", @"公噸", nil];
    speedArrary=[NSMutableArray arrayWithObjects:@"公尺/秒", @"公里/秒", @"公里/時", @"音速", @"光速", nil];
    exchangeRateArrary=[NSMutableArray arrayWithObjects:@"台幣", @"美元", @"歐元", @"英鎊", @"人民幣",
                                                            @"港幣", @"日圓", @"韓圓", @"新幣", @"泰幣", nil];
    
    saveNumber1 = @"";
    saveNumber2 = @"";
    secondNumberOnOrOff = 0;    //第二次輸入(關)
    pointOnOrOff = 1;  //小數點判斷(開)
    immediateTransform = 0; //儲存單位換算(代號)(0為不動作)
    strConversionNum = 0;   //字串轉數字變數
    allConversionUnifiedValue = 0; //全部轉換統一值
    
    numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnNum1:(id)sender {
    
    [self Cumulative:1];
}

- (IBAction)btnNum2:(id)sender {
    
    [self Cumulative:2];
}

- (IBAction)btnNum3:(id)sender {
    
    [self Cumulative:3];
}

- (IBAction)btnNum4:(id)sender {
    
    [self Cumulative:4];
}

- (IBAction)btnNum5:(id)sender {
    
    [self Cumulative:5];
}

- (IBAction)btnNum6:(id)sender {
    
    [self Cumulative:6];
}

- (IBAction)btnNum7:(id)sender {
    
    [self Cumulative:7];
}

- (IBAction)btnNum8:(id)sender {
    
    [self Cumulative:8];
}

- (IBAction)btnNum9:(id)sender {
    
    [self Cumulative:9];
}

- (IBAction)btnNum0:(id)sender {
    
    if (secondNumberOnOrOff == 0) {//判斷是否為第二輸入數字
        if (![saveNumber1 isEqualToString:@"0"]) {//判斷是否已輸入0
            [self Cumulative:0];
        }
    }else{
        if (![saveNumber2 isEqualToString:@"0"]) {
            [self Cumulative:0];
        }
    }
    
}

- (IBAction)btnPoint:(id)sender {
//小數點
    NSString *newPoint = [NSString stringWithFormat:@"."];
    
    if (pointOnOrOff == 1) {//判斷小數點是否為開
        if (secondNumberOnOrOff == 0) {//判斷是否為第二輸入數字
            if (![saveNumber1 isEqualToString:@""]) {//判斷是否沒數入數字
                saveNumber1 = [NSString stringWithFormat:@"%@%@", saveNumber1, newPoint];
                _labelResult.text = [NSString stringWithFormat:@"%@", saveNumber1];
                pointOnOrOff = 0;//小數點是否為關
            }
            
        }else{
            if (![saveNumber2 isEqualToString:@""]) {
                saveNumber2 = [NSString stringWithFormat:@"%@%@", saveNumber2, newPoint];
                _labelResult.text = [NSString stringWithFormat:@"%@", saveNumber2];
                pointOnOrOff = 0;
            }
        }
    }
    
}

//累加數字
- (void)Cumulative:(int)afferentNumber
{
    _showPickerView.hidden = YES;   // PickerView(隱藏)
    _labelTransResult.hidden =NO;
    if (immediateTransform != 0) {
        _labelResult.hidden = NO;
        _labelUnitDst.hidden = NO;
        _labelUnitSrc.hidden = NO;
    }
    
    if (secondNumberOnOrOff == 0) {
        saveNumber1 = [NSString stringWithFormat:@"%@%d", saveNumber1,afferentNumber];
//        _labelResult.text = [NSString stringWithFormat:@"%@", saveNumber1];
        
        myNumber1 = [numberFormatter numberFromString:saveNumber1]; //NSString 轉換成 NSNumber
        _labelResult.text = [NSString stringWithFormat:@"%@",[numberFormatter stringFromNumber:myNumber1]];
        //顯示有，的數字

        
        [self UnitConversion:immediateTransform];   //呼叫單位換算
    }else{
        saveNumber2 = [NSString stringWithFormat:@"%@%d", saveNumber2,afferentNumber];
//        _labelResult.text = [NSString stringWithFormat:@"%@", saveNumber2];
        
        myNumber2 = [numberFormatter numberFromString:saveNumber2];
        _labelResult.text = [NSString stringWithFormat:@"%@",[numberFormatter stringFromNumber:myNumber2]];

//        [self TimeTransform:immediateTransform];
    }
 
}

- (void)answer:(id)sender
{
    _showPickerView.hidden = YES;// PickerView(隱藏)
    _labelTransResult.hidden =NO;
    if (immediateTransform != 0) {
        _labelResult.hidden = NO;
        _labelUnitDst.hidden = NO;
        _labelUnitSrc.hidden = NO;
    }
    
    secondNumberOnOrOff =1; //第二輸入數字(開)
    
    if (add == 1 && ![saveNumber2 isEqualToString:@""]) {
        saveNumber1 = [NSString stringWithFormat:@"%@+%@", saveNumber1,saveNumber2];

        NSExpression *expression = [NSExpression expressionWithFormat:saveNumber1];
//        _labelResult.text = [NSString stringWithFormat:@"%@", [expression expressionValueWithObject:nil context:nil]];
        
        //顯示每三個數字加，
        tenmpString=[NSString stringWithFormat:@"%@", [expression expressionValueWithObject:nil context:nil]];
        myNumberAnswer = [numberFormatter numberFromString:tenmpString];
        _labelResult.text = [NSString stringWithFormat:@"%@",[numberFormatter stringFromNumber:myNumberAnswer]];
        
        //改變 strConversionNum
        strConversionNum = [[expression expressionValueWithObject:nil context:nil] doubleValue]; //字串轉數字變數
        [self UnitConversion:immediateTransform];
        
        saveNumber2 = @"";
    }else if (sub == 1 && ![saveNumber2 isEqualToString:@""]){
        saveNumber1 = [NSString stringWithFormat:@"%@-%@", saveNumber1,saveNumber2];
        
        NSExpression *expression = [NSExpression expressionWithFormat:saveNumber1];
//        _labelResult.text = [NSString stringWithFormat:@"%@", [expression expressionValueWithObject:nil context:nil]];
        
        //顯示每三個數字加，
        tenmpString=[NSString stringWithFormat:@"%@", [expression expressionValueWithObject:nil context:nil]];
        myNumberAnswer = [numberFormatter numberFromString:tenmpString];
        _labelResult.text = [NSString stringWithFormat:@"%@",[numberFormatter stringFromNumber:myNumberAnswer]];
        
        //改變 strConversionNum
        strConversionNum = [[expression expressionValueWithObject:nil context:nil] doubleValue]; //字串轉數字變數
        [self UnitConversion:immediateTransform];
        
        saveNumber2 = @"";
    }else if (mul == 1 && ![saveNumber2 isEqualToString:@""]){
        saveNumber1 = [NSString stringWithFormat:@"%@*%@", saveNumber1,saveNumber2];
        
        NSExpression *expression = [NSExpression expressionWithFormat:saveNumber1];
//        _labelResult.text = [NSString stringWithFormat:@"%@", [expression expressionValueWithObject:nil context:nil]];
        
        //顯示每三個數字加，
        tenmpString=[NSString stringWithFormat:@"%@", [expression expressionValueWithObject:nil context:nil]];
        myNumberAnswer = [numberFormatter numberFromString:tenmpString];
        _labelResult.text = [NSString stringWithFormat:@"%@",[numberFormatter stringFromNumber:myNumberAnswer]];
        
        //改變 strConversionNum
        strConversionNum = [[expression expressionValueWithObject:nil context:nil] doubleValue]; //字串轉數字變數
        [self UnitConversion:immediateTransform];
        
        saveNumber2 = @"";
    }else if (div == 1 && ![saveNumber2 isEqualToString:@""]){
        saveNumber1 = [NSString stringWithFormat:@"%@/%@", saveNumber1,saveNumber2];
        
        NSExpression *expression = [NSExpression expressionWithFormat:saveNumber1];
//        _labelResult.text = [NSString stringWithFormat:@"%@", [expression expressionValueWithObject:nil context:nil]];
//        NSLog(@"NSLog:%@", [expression expressionValueWithObject:nil context:nil]);
        
        //顯示每三個數字加，
        tenmpString=[NSString stringWithFormat:@"%@", [expression expressionValueWithObject:nil context:nil]];
        myNumberAnswer = [numberFormatter numberFromString:tenmpString];
        _labelResult.text = [NSString stringWithFormat:@"%@",[numberFormatter stringFromNumber:myNumberAnswer]];
        
        //改變 strConversionNum
        strConversionNum = [[expression expressionValueWithObject:nil context:nil] doubleValue]; //字串轉數字變數
        [self UnitConversion:immediateTransform];
        
        saveNumber2 = @"";
    }
    
    add = 0;
    sub = 0;
    mul = 0;
    div = 0;
    pointOnOrOff = 1;
}

- (IBAction)btnAdd:(id)sender {
    
    [self answer:0];
    
    add = 1;
}

- (IBAction)btnSub:(id)sender {
    
    [self answer:0];
    
    sub = 1;
}

- (IBAction)btnMul:(id)sender {
    
    if (add == 1 && ![saveNumber2 isEqualToString:@""]){
        add = 0;
        saveNumber1 = [NSString stringWithFormat:@"%@+%@", saveNumber1,saveNumber2];
        saveNumber2 = @"";
        [self answer:0];
        mul = 1;
    }else if (sub == 1 && ![saveNumber2 isEqualToString:@""]){
        sub = 0;
        saveNumber1 = [NSString stringWithFormat:@"%@-%@", saveNumber1,saveNumber2];
        saveNumber2 = @"";
        [self answer:0];
        mul = 1;
    }else{
        [self answer:0];
        mul = 1;
    }
    
}

- (IBAction)btnDiv:(id)sender {
    
    if (add == 1 && ![saveNumber2 isEqualToString:@""]){
        add = 0;
        saveNumber1 = [NSString stringWithFormat:@"%@+%@", saveNumber1,saveNumber2];
        saveNumber2 = @"";
        [self answer:0];
        div = 1;
    }else if (sub == 1 && ![saveNumber2 isEqualToString:@""]){
        sub = 0;
        saveNumber1 = [NSString stringWithFormat:@"%@-%@", saveNumber1,saveNumber2];
        saveNumber2 = @"";
        [self answer:0];
        div = 1;
    }else{
        [self answer:0];
        div = 1;
    }
    
}

- (IBAction)btnCancel:(id)sender {
    
    if ([saveNumber2 isEqualToString:@""]) {
            add = 0;
            sub = 0;
            mul = 0;
            div = 0;
            secondNumberOnOrOff = 0;
            pointOnOrOff = 1;
            saveNumber1 = @"0";
            saveNumber2 = @"";
            
            _labelTransResult.text = @"";   //數字轉換後
            _labelResult.text = @"";    //數字轉換前
            _labelUnitDst.text = @"";   //單位轉換後
            _labelUnitSrc.text = @"";   //單位轉換前
            immediateTransform = 0; //記錄即時單位換算(關)
        [sender setFont:[UIFont systemFontOfSize:30]];
        [sender setTitle:@"C" forState:UIControlStateNormal];
        _labelResult.text = [NSString stringWithFormat:@"%@", saveNumber1];

    }else{
        saveNumber2 = @"";
        _labelTransResult.text = @"";
//        _labelResult.text = @"";
        [sender setFont:[UIFont systemFontOfSize:30]];
        [sender setTitle:@"AC" forState:UIControlStateNormal];
        
        //顯示清除之後的數字
        if (tenmpString) {
            //顯示之前計算結果
            myNumberAnswer = [numberFormatter numberFromString:tenmpString];
            _labelResult.text = [NSString stringWithFormat:@"%@",[numberFormatter stringFromNumber:myNumberAnswer]];
        }else{
            //顯示第一次數入的數字
            myNumber1 = [numberFormatter numberFromString:saveNumber1];
            _labelResult.text = [NSString stringWithFormat:@"%@",[numberFormatter stringFromNumber:myNumber1]];
        }
        
        
    }

}

//顯示隱藏 PickerView 和傳入單位換算值
- (void)PickerViewHidden:(int)transformNumber
{
    [_showPickerView reloadAllComponents];  //更新 PickerView
 
    immediateTransform = transformNumber; //記錄即時單位換算
    
//    [self TimeTransform:transformNumber]; //呼叫單位換算
    
    if (_showPickerView.hidden==YES) {
        _showPickerView.hidden = NO;
        _labelTransResult.hidden =YES;
        _labelResult.hidden = YES;
        _labelUnitDst.hidden = YES;
        _labelUnitSrc.hidden = YES;
    }else{
        _showPickerView.hidden = YES;
        _labelTransResult.hidden =NO;
        _labelResult.hidden = NO;
        _labelUnitDst.hidden = NO;
        _labelUnitSrc.hidden = NO;
        
        [self UnitConversion:transformNumber];   //關 PickerView 時，再次執行單位換算
    }
    
}

//判斷單位轉換圖片為 Gray
- (void)ShowImageLabel
{
    if (immediateTransform != 1) {
        [_imageLength setImage:[UIImage imageNamed:@"lengthGray.png"] forState:UIControlStateNormal];
        [_labelLength setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    if (immediateTransform != 2) {
        [_imageTime setImage:[UIImage imageNamed:@"timeGray.png"] forState:UIControlStateNormal];
        [_labelTime setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    if (immediateTransform != 3) {
        [_imageWeight setImage:[UIImage imageNamed:@"scale-bigGray.png"] forState:UIControlStateNormal];
        [_labelWeight setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    if (immediateTransform != 4) {
        [_imageSpeed setImage:[UIImage imageNamed:@"DashboardGray.png"] forState:UIControlStateNormal];
        [_labelSpeed setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    if (immediateTransform != 5) {
        [_imageExchangeRate setImage:[UIImage imageNamed:@"moneyGary.png"] forState:UIControlStateNormal];
        [_labelExchangeRate setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

//長度(1)
- (IBAction)btnLength:(id)sender {
    
    allArray = [[NSMutableArray alloc] initWithArray:lengthArrary copyItems:YES]; //複製

    [self PickerViewHidden:1];
    
    [self ShowImageLabel];
    [_imageLength setImage:[UIImage imageNamed:@"lengthBlue.png"] forState:UIControlStateNormal];
    [_labelLength setTitleColor:[UIColor colorWithRed:58/255.0 green:110/255.0 blue:208/255.0 alpha:1] forState:UIControlStateNormal];
}

//時間(2)
- (IBAction)btnTime:(id)sender {
    
    allArray = [[NSMutableArray alloc] initWithArray:timeArray copyItems:YES]; //複製

    [self PickerViewHidden:2];
    
    [self ShowImageLabel];
    [_imageTime setImage:[UIImage imageNamed:@"timeBlue.png"] forState:UIControlStateNormal];
    [_labelTime setTitleColor:[UIColor colorWithRed:58/255.0 green:110/255.0 blue:208/255.0 alpha:1] forState:UIControlStateNormal];}

//重量(3)
- (IBAction)btnWeight:(id)sender {
    
    allArray = [[NSMutableArray alloc] initWithArray:weightArrary copyItems:YES]; //複製
    
    [self PickerViewHidden:3];
    
    [self ShowImageLabel];
    [_imageWeight setImage:[UIImage imageNamed:@"scale-bigBlue.png"] forState:UIControlStateNormal];
    [_labelWeight setTitleColor:[UIColor colorWithRed:58/255.0 green:110/255.0 blue:208/255.0 alpha:1] forState:UIControlStateNormal];
}

//速度(4)
- (IBAction)btnSpeed:(id)sender {
    
    allArray = [[NSMutableArray alloc] initWithArray:speedArrary copyItems:YES]; //複製
    
    [self PickerViewHidden:4];
    
    [self ShowImageLabel];
    [_imageSpeed setImage:[UIImage imageNamed:@"DashboardBlue.png"] forState:UIControlStateNormal];
    [_labelSpeed setTitleColor:[UIColor colorWithRed:58/255.0 green:110/255.0 blue:208/255.0 alpha:1] forState:UIControlStateNormal];
}

//匯率(5)
- (IBAction)btnExchangeRate:(id)sender {
    
    allArray = [[NSMutableArray alloc] initWithArray:exchangeRateArrary copyItems:YES]; //複製

    [self PickerViewHidden:5];
    
    [self ShowImageLabel];
    [_imageExchangeRate setImage:[UIImage imageNamed:@"moneyBlue.png"] forState:UIControlStateNormal];
    [_labelExchangeRate setTitleColor:[UIColor colorWithRed:58/255.0 green:110/255.0 blue:208/255.0 alpha:1] forState:UIControlStateNormal];
}

//TODO:ShowPickerView
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [allArray objectAtIndex:row];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return  2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [allArray count];
}

//TODO:單位換算
- (void)UnitConversion:(int)changeTransform
{
    allConversionUnifiedValue = 0; //全部轉換統一值歸0
    if (secondNumberOnOrOff == 0) {
        strConversionNum = [saveNumber1 doubleValue]; //字串轉數字變數
    }
    
    
    if (changeTransform == 1) {
        NSLog(@"changeTransform = 長度");
        
        //全部轉換成mm
        if ([_showPickerView selectedRowInComponent:0] == 0) {
            allConversionUnifiedValue = 1;
        }else if ([_showPickerView selectedRowInComponent:0] == 1) {
            allConversionUnifiedValue = 10;
        }else if ([_showPickerView selectedRowInComponent:0] == 2) {
            allConversionUnifiedValue = 1000;
        }else if ([_showPickerView selectedRowInComponent:0] == 3) {
            allConversionUnifiedValue = 1000000;
        }else if ([_showPickerView selectedRowInComponent:0] == 4) {
            allConversionUnifiedValue = 0.000001609344;
        }else if ([_showPickerView selectedRowInComponent:0] == 5) {
            allConversionUnifiedValue = 914.4;
        }else if ([_showPickerView selectedRowInComponent:0] == 6) {
            allConversionUnifiedValue = 25.4;
        }else if ([_showPickerView selectedRowInComponent:0] == 7) {
            allConversionUnifiedValue = 1852000;
        }

        //單位換算
        if ([_showPickerView selectedRowInComponent:1] == 0) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f", strConversionNum *allConversionUnifiedValue *1];
        }else if ([_showPickerView selectedRowInComponent:1] == 1) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f", strConversionNum *allConversionUnifiedValue *0.1];
        }else if ([_showPickerView selectedRowInComponent:1] == 2) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f", strConversionNum *allConversionUnifiedValue *0.001];
        }else if ([_showPickerView selectedRowInComponent:1] == 3) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.000001];
        }else if ([_showPickerView selectedRowInComponent:1] == 4) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.00000062137119224];
        }else if ([_showPickerView selectedRowInComponent:1] == 5) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.0010936133];
        }else if ([_showPickerView selectedRowInComponent:1] == 6) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.0393700787];
        }else if ([_showPickerView selectedRowInComponent:1] == 7) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.00000053995680346];
        }
        
    }else if (changeTransform == 2) {
        NSLog(@"changeTransform = 時間");
        
        //全部轉換成秒
        if ([_showPickerView selectedRowInComponent:0] == 0) {
            allConversionUnifiedValue = 1;
        }else if ([_showPickerView selectedRowInComponent:0] == 1) {
            allConversionUnifiedValue = 60;
        }else if ([_showPickerView selectedRowInComponent:0] == 2) {
            allConversionUnifiedValue = 3600;
        }else if ([_showPickerView selectedRowInComponent:0] == 3) {
            allConversionUnifiedValue = 86400;
        }else if ([_showPickerView selectedRowInComponent:0] == 4) {
            allConversionUnifiedValue = 604800;
        }else if ([_showPickerView selectedRowInComponent:0] == 5) {
            allConversionUnifiedValue = 2629800;
        }else if ([_showPickerView selectedRowInComponent:0] == 6) {
            allConversionUnifiedValue = 31557600;
        }
        
        //單位換算
        if ([_showPickerView selectedRowInComponent:1] == 0) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f", strConversionNum *allConversionUnifiedValue *1];
        }else if ([_showPickerView selectedRowInComponent:1] == 1) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f", strConversionNum *allConversionUnifiedValue *0.0166666667];
        }else if ([_showPickerView selectedRowInComponent:1] == 2) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f", strConversionNum *allConversionUnifiedValue *0.0002777778];
        }else if ([_showPickerView selectedRowInComponent:1] == 3) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f", strConversionNum *allConversionUnifiedValue *0.0000115741];
        }else if ([_showPickerView selectedRowInComponent:1] == 4) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f", strConversionNum *allConversionUnifiedValue *0.0000016534];
        }else if ([_showPickerView selectedRowInComponent:1] == 5) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.00000038025705377];
        }else if ([_showPickerView selectedRowInComponent:1] == 6) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.000000031688087814];
        }
    }else if (changeTransform == 3) {
        NSLog(@"changeTransform = 重量");
//        weightArrary=[NSMutableArray arrayWithObjects:@"克", @"兩", @"台斤", @"公斤", @"公噸", nil];
        
        //全部轉換成克
        if ([_showPickerView selectedRowInComponent:0] == 0) {
            allConversionUnifiedValue = 1;
        }else if ([_showPickerView selectedRowInComponent:0] == 1) {
            allConversionUnifiedValue = 37.786754231;
        }else if ([_showPickerView selectedRowInComponent:0] == 2) {
            allConversionUnifiedValue = 600;
        }else if ([_showPickerView selectedRowInComponent:0] == 3) {
            allConversionUnifiedValue = 1000;
        }else if ([_showPickerView selectedRowInComponent:0] == 4) {
            allConversionUnifiedValue = 1000000;
        }
        
        //單位換算
        if ([_showPickerView selectedRowInComponent:1] == 0) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f", strConversionNum *allConversionUnifiedValue *1];
        }else if ([_showPickerView selectedRowInComponent:1] == 1) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.0264643];
        }else if ([_showPickerView selectedRowInComponent:1] == 2) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.0016666667];
        }else if ([_showPickerView selectedRowInComponent:1] == 3) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.001];
        }else if ([_showPickerView selectedRowInComponent:1] == 4) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.000001];
        }

    }else if (changeTransform == 4) {
        NSLog(@"changeTransform = 速度");
        
        //全部轉換成公尺/秒
        if ([_showPickerView selectedRowInComponent:0] == 0) {
            allConversionUnifiedValue = 1;
        }else if ([_showPickerView selectedRowInComponent:0] == 1) {
            allConversionUnifiedValue = 1000;
        }else if ([_showPickerView selectedRowInComponent:0] == 2) {
            allConversionUnifiedValue = 0.2777777778;
        }else if ([_showPickerView selectedRowInComponent:0] == 3) {
            allConversionUnifiedValue = 343;
        }else if ([_showPickerView selectedRowInComponent:0] == 4) {
            allConversionUnifiedValue = 299792458;
        }
        
        //單位換算
        if ([_showPickerView selectedRowInComponent:1] == 0) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f", strConversionNum *allConversionUnifiedValue *1];
        }else if ([_showPickerView selectedRowInComponent:1] == 1) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f", strConversionNum *allConversionUnifiedValue *0.001];
        }else if ([_showPickerView selectedRowInComponent:1] == 2) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f", strConversionNum *allConversionUnifiedValue *3.6];
        }else if ([_showPickerView selectedRowInComponent:1] == 3) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.0029154519];
        }else if ([_showPickerView selectedRowInComponent:1] == 4) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.000000003335640952];
        }
    }else if (changeTransform == 5) {
        NSLog(@"changeTransform = 匯率");
        
        //全部轉換成美金
        if ([_showPickerView selectedRowInComponent:0] == 0) {
            allConversionUnifiedValue = 0.03394;
        }else if ([_showPickerView selectedRowInComponent:0] == 1) {
            allConversionUnifiedValue = 1;
        }else if ([_showPickerView selectedRowInComponent:0] == 2) {
            allConversionUnifiedValue = 1.34616;
        }else if ([_showPickerView selectedRowInComponent:0] == 3) {
            allConversionUnifiedValue = 1.61942;
        }else if ([_showPickerView selectedRowInComponent:0] == 4) {
            allConversionUnifiedValue = 0.16567;
        }else if ([_showPickerView selectedRowInComponent:0] == 5) {
            allConversionUnifiedValue = 0.12986;
        }else if ([_showPickerView selectedRowInComponent:0] == 6) {
            allConversionUnifiedValue = 0.00993;
        }else if ([_showPickerView selectedRowInComponent:0] == 7) {
            allConversionUnifiedValue = 0.00096;
        }else if ([_showPickerView selectedRowInComponent:0] == 8) {
            allConversionUnifiedValue = 0.80843;
        }else if ([_showPickerView selectedRowInComponent:0] == 9) {
            allConversionUnifiedValue = 0.03214;
        }
//        @"台幣", @"美金", @"歐元", @"英鎊", @"人民幣", @"港幣", @"日圓", @"韓圓", @"新幣", @"泰幣", nil];
        //單位換算
        if ([_showPickerView selectedRowInComponent:1] == 0) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *29.46348];
        }else if ([_showPickerView selectedRowInComponent:1] == 1) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *1];
        }else if ([_showPickerView selectedRowInComponent:1] == 2) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.74285];
        }else if ([_showPickerView selectedRowInComponent:1] == 3) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *0.6175];
        }else if ([_showPickerView selectedRowInComponent:1] == 4) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *6.03628];
        }else if ([_showPickerView selectedRowInComponent:1] == 5) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *7.70066];
        }else if ([_showPickerView selectedRowInComponent:1] == 6) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *100.69427];
        }else if ([_showPickerView selectedRowInComponent:1] == 7) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *1038.98915];
        }else if ([_showPickerView selectedRowInComponent:1] == 8) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *1.23697];
        }else if ([_showPickerView selectedRowInComponent:1] == 9) {
            _labelTransResult.text = [NSString stringWithFormat:@"%.3f",
                                      strConversionNum *allConversionUnifiedValue *31.11177];
        }
    }else{
        // immediateTransform = 0; //記錄即時單位換算(關)
        //不做單位換算
        NSLog(@"不做單位換算");
    }
    
    
    
    if (immediateTransform != 0) {
        _labelUnitDst.text = [allArray objectAtIndex:[_showPickerView selectedRowInComponent:1]];
        _labelUnitSrc.text = [allArray objectAtIndex:[_showPickerView selectedRowInComponent:0]];
//        NSLog(@"selectedRowInComponent:0=%d", [_showPickerView selectedRowInComponent:0]);
//        NSLog(@"selectedRowInComponent:1=%d", [_showPickerView selectedRowInComponent:1]);
    }

    
    

}

@end

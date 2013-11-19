//
//  ViewController.h
//  CaculatorZetPro
//
//  Created by Chun NingShen on 2013/11/12.
//  Copyright (c) 2013年 Think Better. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelTransResult;
@property (strong, nonatomic) IBOutlet UILabel *labelUnitDst;

@property (strong, nonatomic) IBOutlet UILabel *labelResult;
@property (strong, nonatomic) IBOutlet UILabel *labelUnitSrc;

@property (strong, nonatomic) IBOutlet UIPickerView *showPickerView;

- (IBAction)btnNum1:(id)sender;
- (IBAction)btnNum2:(id)sender;
- (IBAction)btnNum3:(id)sender;
- (IBAction)btnNum4:(id)sender;
- (IBAction)btnNum5:(id)sender;
- (IBAction)btnNum6:(id)sender;
- (IBAction)btnNum7:(id)sender;
- (IBAction)btnNum8:(id)sender;
- (IBAction)btnNum9:(id)sender;
- (IBAction)btnNum0:(id)sender;

- (IBAction)btnAdd:(id)sender;
- (IBAction)btnSub:(id)sender;
- (IBAction)btnMul:(id)sender;
- (IBAction)btnDiv:(id)sender;

- (IBAction)btnPoint:(id)sender;
- (IBAction)btnCancel:(id)sender;

- (IBAction)btnLength:(id)sender;
- (IBAction)btnTime:(id)sender;
- (IBAction)btnWeight:(id)sender;
- (IBAction)btnSpeed:(id)sender;
- (IBAction)btnExchangeRate:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *imageLength;
@property (strong, nonatomic) IBOutlet UIButton *imageTime;
@property (strong, nonatomic) IBOutlet UIButton *imageWeight;
@property (strong, nonatomic) IBOutlet UIButton *imageSpeed;
@property (strong, nonatomic) IBOutlet UIButton *imageExchangeRate;

@property (strong, nonatomic) IBOutlet UIButton *labelLength;
@property (strong, nonatomic) IBOutlet UIButton *labelTime;
@property (strong, nonatomic) IBOutlet UIButton *labelWeight;
@property (strong, nonatomic) IBOutlet UIButton *labelSpeed;
@property (strong, nonatomic) IBOutlet UIButton *labelExchangeRate;

@property (strong, nonatomic) IBOutlet UIView *viewTransform;
@property (strong, nonatomic) IBOutlet UIView *viewCalculate;
@end

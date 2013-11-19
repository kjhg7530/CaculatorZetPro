//
//  AboutViewController.m
//  CaculatorZetPro
//
//  Created by HANA on 2013/11/15.
//  Copyright (c) 2013年 Think Better. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//FaceBook分享
- (IBAction)btnFaceBook:(id)sender {
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"向您推薦簡單又好用的計算機單位換算App(CaculatorZet Pro)請大家告訴大家" ];
        NSURL *url=[NSURL URLWithString:@"http://tw.yahoo.com"];
        [controller addURL:url];
                
        [controller addImage:[UIImage imageNamed:@"shareImage.jpg"]];
        [self presentViewController:controller animated:YES completion:Nil];
    }
//    NSLog(@"FaceBook");
}

//Twitter分享
- (IBAction)BtnTwitter:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"向您推薦簡單又好用的計算機單位換算App(CaculatorZet Pro)\n請大家告訴大家"];
        NSURL *url=[NSURL URLWithString:@"http://tw.yahoo.com"];
        [tweetSheet addURL:url];
        [tweetSheet addImage:[UIImage imageNamed:@"shareImage.jpg"]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
//    NSLog(@"Twitter");
}

//返回
- (IBAction)btnBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)btnOpenWeb:(id)sender {
    
    NSURL *url=[NSURL URLWithString:@"http://caculatorzetpro.weebly.com"];
    [[UIApplication sharedApplication] openURL:url];    //開啟網頁
}
@end

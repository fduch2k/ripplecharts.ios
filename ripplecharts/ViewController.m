//
//  ViewController.m
//  ripplecharts
//
//  Created by Alexander Hramov on 14.10.14.
//  Copyright (c) 2014 Alexander Hramov. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+Spin.h"
#import "RPButton.h"

@interface ViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIImageView *spinView;
@property (weak, nonatomic) IBOutlet UIView *spinContainer;
@property (strong, nonatomic) NSDictionary *themes;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet RPButton *retryButton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupThemes];
    [self setupWebView];

    [self switchToTheme:[[NSUserDefaults standardUserDefaults] objectForKey:@"themeName"]];
}

- (void)setupWebView {
    NSString *urlAddress = @"http://www.ripplecharts.com";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    self.webView.delegate = self;
    [self.webView loadRequest:requestObj];
}

#pragma mark - Theme management

- (void)setupThemes {
    self.themes = @{@"dark":
                        @{@"color": [UIColor whiteColor],
                          @"backColor": [UIColor blackColor],
                          @"image": [UIImage imageNamed:@"logoLightLarge"],
                          @"statusStyle": @(UIStatusBarStyleLightContent)},
                    @"light":
                        @{@"color": [UIColor darkGrayColor],
                          @"backColor": [UIColor whiteColor],
                          @"image": [UIImage imageNamed:@"logoLarge"],
                          @"statusStyle": @(UIStatusBarStyleDefault)}};
}

- (void)switchToTheme:(NSString *)theme {
    NSDictionary *themeStyle = [self.themes objectForKey:[theme lowercaseString]];
    if (themeStyle) {
        self.view.backgroundColor = themeStyle[@"backColor"];
        self.webView.backgroundColor = themeStyle[@"backColor"];
        self.spinContainer.backgroundColor = themeStyle[@"backColor"];
        self.logoImageView.image = themeStyle[@"image"];
        [[UIApplication sharedApplication] setStatusBarStyle:[themeStyle[@"statusStyle"] intValue]];

        [[NSUserDefaults standardUserDefaults] setObject:theme forKey:@"themeName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)retryButtonAction:(id)sender {
    if ([self.webView.request.URL.absoluteString isEqualToString:@"http://ripplecharts.com"]) {
        [self.webView reload];
    }
    else {
        [self setupWebView];
    }
    self.retryButton.hidden = YES;
    self.errorLabel.text = @"";
}

#pragma mark - UIWebViewDelegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinView startSpin];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIView animateWithDuration:0.3f animations:^{
        self.spinContainer.alpha = 0;
    } completion:^(BOOL finished) {
        [self.spinView stopSpin];
        self.spinContainer.hidden = YES;
    }];

    [webView stringByEvaluatingJavaScriptFromString:@"(function(){var links=document.querySelectorAll('div.theme>a');for(var i=0;i<links.length;i++){links[i].addEventListener('click',function(e){window.location.href='theme://'+e.target.innerHTML});}})();"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.spinView stopSpin];
    self.retryButton.hidden = NO;
    self.errorLabel.text = error.localizedDescription;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([[[request URL] scheme] isEqualToString:@"theme"]) {
        [self switchToTheme:request.URL.host];
        return NO;
    }
    return YES;
}

@end

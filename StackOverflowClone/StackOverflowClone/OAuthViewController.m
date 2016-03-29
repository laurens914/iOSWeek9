//
//  OAuthViewController.m
//  StackOverflowClone
//
//  Created by Lauren Spatz on 3/28/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

#import "OAuthViewController.h"
@import WebKit;


NSString const *kClientID = @"6796";
NSString const *kBaseURL = @"https://stackexchange.com/oauth/dialog?";
NSString const *kRedirectURL = @"https://stackexchange.com/oauth/login_success";

@interface OAuthViewController () <WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation OAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupWebView];
}

-(void)setupWebView
{
    self.webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    
    
    NSString *stackURLString = [NSString stringWithFormat:@"%@client_id=%@&redirect_uri=%@",kBaseURL, kClientID, kRedirectURL];
    NSURL *stackURL = [NSURL URLWithString:stackURLString];
    
    self.webView.navigationDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:stackURL]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURLRequest *request = navigationAction.request;
    NSURL *requestURL = request.URL;
    
    if ([requestURL.description containsString:@"access_token"])
    {
        NSLog(@"YAY!!!");
        [self getAndStoreAccessTokenFromURL:requestURL];
        if (self.completion)
        {
            self.completion();
        }
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}


-(void)getAndStoreAccessTokenFromURL:(NSURL *)url
{
    NSCharacterSet *separatingCharacters = [NSCharacterSet characterSetWithCharactersInString:@"#&?"];
    NSArray *urlComponents = [[url description]componentsSeparatedByCharactersInSet:separatingCharacters];
    
    for (NSString *component in urlComponents) {
        NSArray *componentArray = [component componentsSeparatedByString:@"="];
        if (componentArray.count >= 2)
        {
            NSString *key = componentArray[0];
            NSString *value = componentArray[1];
            if (key && value) {
                NSLog(@"Key: %@, Value: %@", key, value);
                [self saveToKeychain:value forKey:key];
            }
        }
    }
}

//-(void)saveToUserDefaults:(NSString *)value forKey:(NSString *)key
//{
//    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//    
//}

-(void)saveToKeychain:(NSString *)value forKey:(NSString *)key
{
    NSMutableDictionary *keychain = [[NSMutableDictionary alloc]init];
    [keychain setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:key];
    SecItemAdd((CFDictionaryRef)keychain, NULL);
}

@end

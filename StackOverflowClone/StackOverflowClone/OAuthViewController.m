//
//  OAuthViewController.m
//  StackOverflowClone
//
//  Created by Lauren Spatz on 3/28/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

#import "OAuthViewController.h"
@import WebKit;

NSString const *kAccessToken = @"kAccessToken";
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
            NSString *key = [componentArray firstObject];
            
            if ([key isEqualToString:@"access_token"]){
            NSString *token = [componentArray lastObject];
            [self saveToKeychain:token];
            }
        }
    }
}
-(id)getOAuthTokenFromKeychain{
    id token = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQueryForString:@"kAccessToken"];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    CFDataRef keyData = nil;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData)==noErr){
        token = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
    }
    if (keyData) CFRelease(keyData);
    return token;
    
}

-(NSMutableDictionary *)getKeychainQueryForString:(NSString *)query
{
    return [@{(__bridge id) kSecClass: (__bridge id)kSecClassGenericPassword,
              (__bridge id)kSecAttrService :query,
              (__bridge id) kSecAttrAccount :query,
              (__bridge id)kSecAttrAccessible : (__bridge id) kSecAttrAccessibleAfterFirstUnlock} mutableCopy];
}

-(void)saveToKeychain:(NSString *)token
{
    NSMutableDictionary *keychain = [self getKeychainQueryForString:token];
    [keychain setObject:[NSKeyedArchiver archivedDataWithRootObject:token] forKey:(__bridge id)kSecValueData];
    SecItemAdd((__bridge CFDictionaryRef)keychain, nil);
}

@end

//
//  ViewController.m
//  LCNetworkingDemo
//
//  Created by menglingchao on 2019/9/8.
//  Copyright © 2019 menglingchao. All rights reserved.
//

#import "ViewController.h"
#import "LCSessionManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self doGet];
    [self doPost];
}
- (void)doGet{
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"word"] = @"背包";
    params[@"version"] = @"2";
    params[@"from"] = @"0";
    
    LCSessionManager *sessionManager = [[LCSessionManager alloc]init];
    NSURLSessionDataTask *dataTask = [sessionManager dataTaskWithRequestBlock:^(NSMutableURLRequest *request) {
        NSString *serverUrlString = @"http://sug.music.baidu.com/info/suggestion?word=bag&version=2&from=0";
        request.URL = [NSURL URLWithString:serverUrlString];
        request.HTTPMethod = @"GET";
    } completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            
        }
    }];
    [dataTask resume];
}

- (void)doPost {
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"type"] = @"consultant";
//    NSData *HTTPBody = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    LCSessionManager *sessionManager = [[LCSessionManager alloc]init];
    NSURLSessionDataTask *dataTask = [sessionManager dataTaskWithRequestBlock:^(NSMutableURLRequest *request) {
        NSString *serverUrlString = @"http://api.xinliji.me/com/loadBanner_v2";
        request.URL = [NSURL URLWithString:serverUrlString];
        request.HTTPMethod = @"POST";
        //把字典中的参数进行拼接
        NSString *body = @"type=consultant";
        NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
        
        //设置请求体
        request.HTTPBody = bodyData;
        //设置本次请求的数据请求格式
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        // 设置本次请求请求体的长度(因为服务器会根据你这个设定的长度去解析你的请求体中的参数内容)
        [request setValue:[NSString stringWithFormat:@"%ld", bodyData.length] forHTTPHeaderField:@"Content-Length"];
        request.HTTPBody = bodyData;
    } completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            
        }
    }];
    [dataTask resume];
}

@end

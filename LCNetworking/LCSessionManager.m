//
//  LCSessionManager.m
//  Lottery
//
//  Created by menglingchao on 2019/9/8.
//  Copyright © 2019 MengLingchao. All rights reserved.
//

#import "LCSessionManager.h"

@interface LCSessionManager ()<NSURLSessionDelegate>

@property (nonatomic,strong) NSURLSession *session;

@end

@implementation LCSessionManager

#pragma mark - Getter
- (NSURLSession *)session {
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}
#pragma mark -
- (NSURLSessionDataTask *)dataTaskWithRequestBlock:(void (^)(NSMutableURLRequest *))requestBlock completionHandler:(void (^)(NSURLResponse *, id, NSError *))completionHandler {
    if (!requestBlock) {
        return nil;
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    requestBlock(request);
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        id responseObject = nil;
        if (!error && data) {
            if ([response.MIMEType isEqualToString:@"application/json"]) {
                responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            } else if ([response.MIMEType isEqualToString:@"image/png"]) {
                
            } else if ([response.MIMEType isEqualToString:@"image/jpeg"]) {
                UIImage *image = [UIImage imageWithData:data];
                responseObject = image;
            } else {
                responseObject = data;
            }
            
        }
        if (completionHandler) {
            completionHandler(response,responseObject,error);
        }
    }];
    return dataTask;
}
- (NSURLSessionUploadTask *)uploadTaskWithRequestBlock:(void (^)(NSMutableURLRequest *))requestBlock fromFile:(NSURL *)fileURL completionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))completionHandler {
    if (!requestBlock) {
        return nil;
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    requestBlock(request);
    NSURLSessionUploadTask *uploadTask = [self.session uploadTaskWithRequest:request fromFile:fileURL completionHandler:completionHandler];
    return uploadTask;
}
- (NSURLSessionUploadTask *)uploadTaskWithRequestBlock:(void (^)(NSMutableURLRequest *))requestBlock fromData:(NSData *)bodyData completionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))completionHandler {
    if (!requestBlock) {
        return nil;
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    requestBlock(request);
    NSURLSessionUploadTask *uploadTask = [self.session uploadTaskWithRequest:request fromData:bodyData completionHandler:completionHandler];
    return uploadTask;
}

- (NSURLSessionDownloadTask *)downloadTaskWithRequestBlock:(void (^)(NSMutableURLRequest *))requestBlock completionHandler:(void (^)(NSURL *, NSURLResponse *, NSError *))completionHandler {
    if (!requestBlock) {
        return nil;
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    requestBlock(request);
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithRequest:request completionHandler:completionHandler];
    return downloadTask;
}
- (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData completionHandler:(void (^)(NSURL * location, NSURLResponse * response, NSError * error))completionHandler {
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithResumeData:resumeData completionHandler:completionHandler];
    return downloadTask;
}
//#pragma mark - NSURLSessionDelegate
//- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
//}
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(nonnull void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
//        if ([self.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
//            credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//            if (credential) {
//                disposition = NSURLSessionAuthChallengeUseCredential;
//            } else {
//                disposition = NSURLSessionAuthChallengePerformDefaultHandling;
//            }
//        } else {
//            disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
//        }
    } else {
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}
//- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
//}
//#pragma mark - NSURLSessionTaskDelegate
//
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
//didCompleteWithError:(nullable NSError *)error {
//
//}
//#pragma mark - NSURLSessionDataDelegate
//#pragma mark - NSURLSessionDownloadDelegate
//- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
//didFinishDownloadingToURL:(NSURL *)location {
//
//}
//- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
//      didWriteData:(int64_t)bytesWritten
// totalBytesWritten:(int64_t)totalBytesWritten
//totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
//
//}
//- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
// didResumeAtOffset:(int64_t)fileOffset
//expectedTotalBytes:(int64_t)expectedTotalBytes {
//
//}
//#pragma mark - NSURLSessionStreamDelegate

@end

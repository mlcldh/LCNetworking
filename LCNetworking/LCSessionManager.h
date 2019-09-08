//
//  LCSessionManager.h
//  Lottery
//
//  Created by menglingchao on 2019/9/8.
//  Copyright © 2019 MengLingchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/***/
@interface LCSessionManager : NSObject

/***/
@property (readonly, nonatomic, strong) NSURLSession *session;

/***/
- (NSURLSessionDataTask *)dataTaskWithRequestBlock:(void (^)(NSMutableURLRequest *request))requestBlock
                            completionHandler:(void (^)(NSURLResponse *response, id responseObject,  NSError * error))completionHandler;
/**上传
 @param fileURL 某个本地路径
 */
- (NSURLSessionUploadTask *)uploadTaskWithRequestBlock:(void (^)(NSMutableURLRequest *request))requestBlock fromFile:(NSURL *)fileURL completionHandler:(void (^)(NSData * data, NSURLResponse * response, NSError * error))completionHandler;
/**上传
 @param bodyData 上传的data
 */
- (NSURLSessionUploadTask *)uploadTaskWithRequestBlock:(void (^)(NSMutableURLRequest *request))requestBlock fromData:(nullable NSData *)bodyData completionHandler:(void (^)(NSData * data, NSURLResponse * response, NSError * error))completionHandler;

/**下载*/
- (NSURLSessionDownloadTask *)downloadTaskWithRequestBlock:(void (^)(NSMutableURLRequest *request))requestBlock completionHandler:(void (^)(NSURL * location, NSURLResponse * response, NSError * error))completionHandler;
/**断点续传下载
 @param resumeData 上次暂停后的数据
 */
- (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData completionHandler:(void (^)(NSURL * location, NSURLResponse * response, NSError * error))completionHandler;

@end

NS_ASSUME_NONNULL_END

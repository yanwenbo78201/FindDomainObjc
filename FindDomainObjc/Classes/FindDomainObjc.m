//
//  FindDomainObjc.m
//  FindDomainObjc_Example
//
//  Created by Computer  on 08/01/26.
//  Copyright © 2026 Computer. All rights reserved.
//

#import "FindDomainObjc.h"
@interface FindDomainObjc()
@property (nonatomic, copy) void(^successBlock)(NSString *finalDomain);
@property (nonatomic, copy) void(^failureBlock)(void);
@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic, strong) FindDomainConfig *config;

@end

@implementation FindDomainObjc
+ (instancetype)shared {
    static FindDomainObjc *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                        selector:@selector(handleReachabilityStatusChange:)
                                                            name:kReachabilityChangedNotification
                                                          object:nil];
        self.reachability = [Reachability reachabilityForInternetConnection];
        [self.reachability startNotifier];
    }
    return self;
}

- (void)configureWithConfig:(FindDomainConfig *)config{
    self.config = config;
}
- (void)handleReachabilityStatusChange:(NSNotification *)notification{
    Reachability *reachability = (Reachability *)[notification object];
    [self handleNetworkStatusWithReachability:reachability currentUrl:@""];
    
}

- (void)checkConnectivityWithCurrentUrl:(NSString *)currentUrl success:(void(^)(NSString *))success failure:(void(^)(void))failure{
    self.failureBlock = failure;
    self.successBlock = success;
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [self handleNetworkStatusWithReachability:reachability currentUrl:currentUrl];
   
}

- (void)handleNetworkStatusWithReachability:(Reachability *)reachability currentUrl:(NSString *)currentUrl{
    if ([reachability currentReachabilityStatus] != NotReachable) {
        [self.reachability stopNotifier];

        if (currentUrl.length == 0) {
            [self findAvailableDomainWithSuccess:^(NSString *domain) {
                if (self.successBlock) {
                    self.successBlock(domain);
                }
            } failure:^{
                if (self.failureBlock) {
                    self.failureBlock();
                }
                
            }];
            
        }else{
            self.successBlock(currentUrl);
        }
        
    }
}
- (void)findAvailableDomainWithSuccess:(void(^)(NSString *domain))success failure:(void(^)(void))failure{
    NSArray *checkUrls = self.config.checkUrls;
    dispatch_group_t group = dispatch_group_create();
    __block NSString *finalDomain = @"";
    for (int urlIndex = 0; urlIndex < checkUrls.count; urlIndex++) {
        NSString *urlStr = checkUrls[urlIndex];
        dispatch_group_enter(group);
        [self performRequestWithURL:urlStr success:^(NSString * _Nonnull responseStr) {
            NSRange startRange = [responseStr rangeOfString:self.config.domainPrefix];
            if (startRange.location != NSNotFound) {
                NSRange startRangeUpperBound = NSMakeRange(NSMaxRange(startRange), responseStr.length - NSMaxRange(startRange));
                NSRange endRange = [responseStr rangeOfString:self.config.domainSuffix options:0 range:startRangeUpperBound];
                if (endRange.location != NSNotFound && startRange.location < NSMaxRange(endRange)) {
                    NSRange extractRange = NSMakeRange(NSMaxRange(startRange), endRange.location - NSMaxRange(startRange));
                    NSString *extractedStr = [responseStr substringWithRange:extractRange];
                    if ([extractedStr containsString:self.config.domainSeparator]) {
                        NSString *replacedStr = [extractedStr stringByReplacingOccurrencesOfString:self.config.domainSeparator withString:@"."];
                        finalDomain = replacedStr;
                        success(finalDomain);
                        dispatch_group_leave(group);
                    } else {
                        dispatch_group_leave(group);
                    }
                } else {
                    dispatch_group_leave(group);
                    return;
                }
            }else{
                dispatch_group_leave(group);
            }
           
        } failure:^{
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (finalDomain.length == 0) {
            failure();
        }
    });
}

- (void)performRequestWithURL:(NSString *)url success:(void(^)(NSString *responseStr))success failure:(void(^)(void))failure{
    long long clientTime = (long long)([[NSDate date] timeIntervalSince1970] * 1000);
    NSURL *requestUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?t=%lld",url,clientTime]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setTimeoutInterval:120.0];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error || !data) {
                failure();
                return;
            }
            
            // 尝试解析JSON数据
            NSError *jsonError;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            NSString *contentString = @"";
            if (jsonError) {
                // 如果不是JSON格式，直接转换为字符串
                contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            } else {
                // 如果是JSON格式，转换为字符串显示
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
                if (jsonData) {
                    contentString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                }
            }
            
            if (contentString && contentString.length > 0) {
                
                success(contentString);
                
            }else{
                failure();
            }
        });
    }];
    
    [task resume];
}



@end

//
//  FindDomainObjc.h
//  FindDomainObjc_Example
//
//  Created by Computer  on 08/01/26.
//  Copyright © 2026 Computer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Reachability/Reachability.h>
#import "FindDomainConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface FindDomainObjc : NSObject
+ (instancetype)shared;
- (void)configureWithConfig:(FindDomainConfig *)config;
- (void)checkConnectivityWithCurrentUrl:(NSString *)currentUrl success:(void(^)(NSString *domain))success failure:(void(^)(void))failure;
- (void)findAvailableDomainWithSuccess:(void(^)(NSString *domain))success failure:(void(^)(void))failure;

@end

NS_ASSUME_NONNULL_END

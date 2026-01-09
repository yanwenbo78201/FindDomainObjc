//
//  FindDomainConfig.h
//  FindDomainObjc_Example
//
//  Created by Computer  on 08/01/26.
//  Copyright © 2026 Computer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FindDomainConfig : NSObject
@property (nonatomic, strong) NSArray <NSString *> *checkUrls;
@property (nonatomic, strong) NSString *domainPrefix;
@property (nonatomic, strong) NSString *domainSuffix;
@property (nonatomic, strong) NSString *domainSeparator;

@end

NS_ASSUME_NONNULL_END

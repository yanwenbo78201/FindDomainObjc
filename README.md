# FindDomainObjc

[![CI Status](https://img.shields.io/travis/Computer/FindDomainObjc.svg?style=flat)](https://travis-ci.org/Computer/FindDomainObjc)
[![Version](https://img.shields.io/cocoapods/v/FindDomainObjc.svg?style=flat)](https://cocoapods.org/pods/FindDomainObjc)
[![License](https://img.shields.io/cocoapods/l/FindDomainObjc.svg?style=flat)](https://cocoapods.org/pods/FindDomainObjc)
[![Platform](https://img.shields.io/cocoapods/p/FindDomainObjc.svg?style=flat)](https://cocoapods.org/pods/FindDomainObjc)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 10.0+
- Swift 4.0+ (如果使用 Swift 项目)

## Installation

FindDomainObjc is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FindDomainObjc'
```

## Usage

### Objective-C

```objc
#import <FindDomainObjc/FindDomainObjc.h>

// 创建配置
FindDomainConfig *config = [[FindDomainConfig alloc] init];
config.checkUrls = @[@"https://example.com/check1", @"https://example.com/check2"];
config.domainPrefix = @"PREFIX";
config.domainSuffix = @"SUFFIX";
config.domainSeparator = @"SEPARATOR";

// 配置查找器
[[FindDomainObjc shared] configureWithConfig:config];

// 查找可用域名
[[FindDomainObjc shared] findAvailableDomainWithSuccess:^(NSString *domain) {
    NSLog(@"找到可用域名: %@", domain);
} failure:^{
    NSLog(@"查找失败");
}];
```

### Swift

#### 方式一：使用 Result 类型（推荐）

```swift
import FindDomainObjc

// 创建配置
let config = FindDomainConfig(
    checkUrls: [
        "https://example.com/check1",
        "https://example.com/check2"
    ],
    domainPrefix: "PREFIX",
    domainSuffix: "SUFFIX",
    domainSeparator: "SEPARATOR"
)

// 配置查找器
FindDomainObjc.shared().configure(with: config)

// 查找可用域名
FindDomainObjc.shared().findAvailableDomain { result in
    switch result {
    case .success(let domain):
        print("找到可用域名: \(domain)")
    case .failure(let error):
        print("查找失败: \(error.localizedDescription)")
    }
}
```

#### 方式二：使用 async/await (iOS 13+)

```swift
import FindDomainObjc

// 创建配置
let config = FindDomainConfig(
    checkUrls: [
        "https://example.com/check1",
        "https://example.com/check2"
    ],
    domainPrefix: "PREFIX",
    domainSuffix: "SUFFIX",
    domainSeparator: "SEPARATOR"
)

// 配置查找器
FindDomainObjc.shared().configure(with: config)

// 使用 async/await
Task {
    do {
        let domain = try await FindDomainObjc.shared().findAvailableDomain()
        print("找到可用域名: \(domain)")
    } catch {
        print("查找失败: \(error.localizedDescription)")
    }
}
```

#### 方式三：直接使用 Objective-C API（兼容方式）

```swift
import FindDomainObjc

// 创建配置
let config = FindDomainConfig()
config.checkUrls = ["https://example.com/check1", "https://example.com/check2"]
config.domainPrefix = "PREFIX"
config.domainSuffix = "SUFFIX"
config.domainSeparator = "SEPARATOR"

// 配置查找器
FindDomainObjc.shared().configure(with: config)

// 使用 Objective-C 风格的回调
FindDomainObjc.shared().findAvailableDomain(
    success: { (domain: String) in
        print("找到可用域名: \(domain)")
    },
    failure: {
        print("查找失败")
    }
)
```

## Author

Computer, yanwenbo@Computer.com

## License

FindDomainObjc is available under the MIT license. See the LICENSE file for more info.

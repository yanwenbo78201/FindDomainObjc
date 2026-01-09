//
//  SwiftUsageExample.swift
//  FindDomainObjc
//
//  Created by Computer  on 08/01/26.
//  Copyright © 2026 Computer. All rights reserved.
//
//  此文件仅作为使用示例，不会被编译到库中

import Foundation
import FindDomainObjc

// MARK: - Swift 使用示例

class SwiftUsageExample {
    
    // MARK: - 基础用法（使用 Result 类型）
    
    func basicUsage() {
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
        
        // 查找可用域名（使用 Result 类型）
        FindDomainObjc.shared().findAvailableDomain { result in
            switch result {
            case .success(let domain):
                print("找到可用域名: \(domain)")
            case .failure(let error):
                print("查找失败: \(error.localizedDescription)")
            }
        }
        
        // 检查连接并查找域名
        FindDomainObjc.shared().checkConnectivity(currentUrl: nil) { result in
            switch result {
            case .success(let domain):
                print("找到可用域名: \(domain)")
            case .failure(let error):
                print("查找失败: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - 使用 async/await (iOS 13+)
    
    @available(iOS 13.0, *)
    func asyncAwaitUsage() async {
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
        
        do {
            // 使用 async/await 查找可用域名
            let domain = try await FindDomainObjc.shared().findAvailableDomain()
            print("找到可用域名: \(domain)")
            
            // 检查连接并查找域名
            let domain2 = try await FindDomainObjc.shared().checkConnectivity(currentUrl: nil)
            print("找到可用域名: \(domain2)")
        } catch {
            print("查找失败: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 直接使用 Objective-C API（兼容方式）
    
    func objectiveCCompatibleUsage() {
        // 创建配置
        let config = FindDomainConfig()
        config.checkUrls = [
            "https://example.com/check1",
            "https://example.com/check2"
        ]
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
    }
}

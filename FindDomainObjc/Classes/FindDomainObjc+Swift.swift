//
//  FindDomainObjc+Swift.swift
//  FindDomainObjc
//
//  Created by Computer  on 08/01/26.
//  Copyright © 2026 Computer. All rights reserved.
//

import Foundation

// MARK: - Swift-friendly API Extensions

extension FindDomainObjc {
    
    /// 检查网络连接并查找可用域名
    /// - Parameters:
    ///   - currentUrl: 当前使用的URL（可选）
    ///   - completion: 完成回调，返回 Result<String, Error>
    public func checkConnectivity(
        currentUrl: String? = nil,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        let url = currentUrl ?? ""
        self.checkConnectivity(withCurrentUrl: url, success: { (domain: String) in
            completion(.success(domain))
        }, failure: {
            completion(.failure(NSError(domain: "FindDomainObjc", code: -1, userInfo: [NSLocalizedDescriptionKey: "无法找到可用域名"])))
        })
    }
    
    /// 查找可用域名
    /// - Parameter completion: 完成回调，返回 Result<String, Error>
    public func findAvailableDomain(completion: @escaping (Result<String, Error>) -> Void) {
        self.findAvailableDomain(success: { (domain: String) in
            completion(.success(domain))
        }, failure: {
            completion(.failure(NSError(domain: "FindDomainObjc", code: -1, userInfo: [NSLocalizedDescriptionKey: "无法找到可用域名"])))
        })
    }
}

// MARK: - Async/Await Support (iOS 13+)

@available(iOS 13.0, *)
extension FindDomainObjc {
    
    /// 异步检查网络连接并查找可用域名
    /// - Parameter currentUrl: 当前使用的URL（可选）
    /// - Returns: 可用的域名字符串
    /// - Throws: 如果无法找到可用域名则抛出错误
    public func checkConnectivity(currentUrl: String? = nil) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            checkConnectivity(currentUrl: currentUrl) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// 异步查找可用域名
    /// - Returns: 可用的域名字符串
    /// - Throws: 如果无法找到可用域名则抛出错误
    public func findAvailableDomain() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            findAvailableDomain { result in
                continuation.resume(with: result)
            }
        }
    }
}

// MARK: - FindDomainConfig Swift Extensions

extension FindDomainConfig {
    
    /// 便捷初始化方法
    /// - Parameters:
    ///   - checkUrls: 用于检查的URL列表
    ///   - domainPrefix: 域名前缀标记
    ///   - domainSuffix: 域名后缀标记
    ///   - domainSeparator: 域名分隔符（将被替换为点号）
    @objc public convenience init(
        checkUrls: [String],
        domainPrefix: String,
        domainSuffix: String,
        domainSeparator: String
    ) {
        self.init()
        self.checkUrls = checkUrls
        self.domainPrefix = domainPrefix
        self.domainSuffix = domainSuffix
        self.domainSeparator = domainSeparator
    }
}

//
//  TargetType.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/24.
//

import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

/// 定义 API 请求所需的所有信息的协议
protocol TargetType {
  /// 基础 URL，例如 "https://60s.7se.cn"
  var baseURL: URL { get }

  /// 每个 API 的具体路径，例如 "/users/123"
  var path: String { get }

  /// HTTP 请求方法 (GET, POST, etc.)
  var method: HTTPMethod { get }

  /// 请求的任务类型，决定了参数如何被编码
  var task: RequestTask { get }

  /// 请求头信息
  var headers: [String: String]? { get }
}

/// 定义请求参数的编码方式
enum RequestTask {
  /// 无参数的请求
  case requestPlain

  /// URL 查询参数 (e.g., ?key=value)，用于 GET 请求
  case requestParameters(parameters: [String: Any], encoding: URLEncoding)

  /// 请求体参数 (e.g., JSON body)，用于 POST, PUT 请求
  case requestJSONEncodable(any Encodable)

  /// 同时有 URL 参数和请求体
  case requestComposite(urlParameters: [String: Any], body: any Encodable)
}

enum URLEncoding {
  /// 参数拼接到 URL 中
  case queryString
}


struct BaseResponse<T: Decodable>: Decodable {
  let code: Int
  let message: String
  let data: T?
}

struct APIError: Error, LocalizedError {
    let code: Int
    let message: String

    var errorDescription: String? {
        return "[\(code)] \(message)"
    }
}

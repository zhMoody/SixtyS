//
//  API.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/24.
//

import Foundation

enum API {
  case getUser(id: Int)
  case updateUser(id: Int, name: String, email: String)
  case getPosts(userId: Int)
  case createPost(title: String, body: String)
  case getSixtySOfReadWord
}

extension API: TargetType {

  // 1. 设置基础 URL
  var baseURL: URL {
    // 将 baseURL 放在一个单独的地方管理，比如一个配置文件或常量文件
    return URL(string: "https://60s.7se.cn")!
  }

  // 2. 根据不同的 case 返回不同的路径
  var path: String {
    switch self {
    case .getUser(let id), .updateUser(let id, _, _):
      return "/users/\(id)"
    case .getPosts:
      return "/posts"
    case .createPost:
      return "/posts"
    case .getSixtySOfReadWord:
      return "/v2/60s"
    }
  }

  // 3. 根据不同的 case 自动确定 HTTP 方法
  var method: HTTPMethod {
    switch self {
    case .getUser,
      .getPosts,
      .getSixtySOfReadWord:
      return .get
    case .updateUser:
      return .put
    case .createPost:
      return .post
    }
  }

  // 4. 根据不同的 case 自动打包参数
  var task: Task {
    switch self {
    case .getUser, .getSixtySOfReadWord:
      return .requestPlain

    case .getPosts(let userId):
      // .getPosts(userId:) 有一个 URL 查询参数 'userId'
      let params = ["userId": userId]
      return .requestParameters(parameters: params, encoding: .queryString)

    case .updateUser(_, let name, let email):
      // .updateUser(...) 将数据编码为 JSON 请求体
      let user = UpdateUserRequest(name: name, email: email)
      return .requestJSONEncodable(user)

    case .createPost(let title, let body):
      // .createPost(...) 同上
      let post = CreatePostRequest(title: title, body: body)
      return .requestJSONEncodable(post)
    }
  }

  // 5. 设置通用的请求头
  var headers: [String: String]? {
    // 这里可以添加全局的 Header，比如 Authorization
    return ["Content-Type": "application/json; charset=UTF-8"]
  }
}

// MARK: - 定义请求体的数据模型 (Codable)
// 将请求体定义为 Codable 结构体是最佳实践

struct UpdateUserRequest: Encodable {
  let name: String
  let email: String
}

struct CreatePostRequest: Encodable {
  let title: String
  let body: String
}

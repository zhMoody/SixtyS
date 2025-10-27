//
//  NetworkManager.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/24.
//

import Foundation

final class NetworkService {
  static let shared = NetworkService()
  private init() {}
  
  func request<T: Decodable>(_ target: any TargetType, responseType: T.Type) async throws -> T {
    let url = target.baseURL.appendingPathComponent(target.path)
    var request = URLRequest(url: url)
    request.httpMethod = target.method.rawValue
    request.timeoutInterval = 15
    target.headers?.forEach { key, value in
      request.addValue(value, forHTTPHeaderField: key)
    }

    switch target.task {
    case .requestPlain:
      break

    case .requestParameters(let parameters, let encoding):
      if encoding == .queryString {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if components?.queryItems == nil {
            components?.queryItems = []
        }
        components?.queryItems?.append(contentsOf: parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") })
        if let newURL = components?.url {
          request.url = newURL
        }
      }

    case .requestJSONEncodable(let body):
      request.httpBody = try JSONEncoder().encode(body)
      if request.value(forHTTPHeaderField: "Content-Type") == nil {
          request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
      }

    case .requestComposite(let urlParameters, let body):
      var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
      if components?.queryItems == nil {
          components?.queryItems = []
      }
      components?.queryItems?.append(contentsOf: urlParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") })
      if let newURL = components?.url {
        request.url = newURL
      }
      request.httpBody = try JSONEncoder().encode(body)
      if request.value(forHTTPHeaderField: "Content-Type") == nil {
          request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
      }
    }
    print("🚀 [Request]: \(request.httpMethod ?? "") - \(request.url?.absoluteString ?? "")")
    if let httpBody = request.httpBody, let bodyString = String(data: httpBody, encoding: .utf8) {
        print("📦 [Body]: \(bodyString)")
    }

    let (data, response) = try await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse,
      (200 ... 299).contains(httpResponse.statusCode)
    else {
      let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
      print("❌ [Network Error]: Invalid HTTP status code: \(statusCode)")
      throw URLError(.badServerResponse)
    }
    
    do {
      let baseResponse = try JSONDecoder().decode(BaseResponse<T>.self, from: data)

      guard baseResponse.code == 200 else {
        print("❌ [API Error]: Code \(baseResponse.code) - \(baseResponse.message)")
        throw APIError(code: baseResponse.code, message: baseResponse.message)
      }
      
      if let responseData = baseResponse.data {
        return responseData
      } else {
        if T.self is ExpressibleByNilLiteral.Type {
          return Optional<T>.none!
        } else {
            throw APIError(code: -1, message: "数据返回为空，但期望的类型不是可选类型。")
        }
      }
    } catch let decodingError as DecodingError {
      print("❌ [Decoding Error]: \(decodingError)")
      if let jsonString = String(data: data, encoding: .utf8) {
          print("📄 [Failed JSON]: \(jsonString)")
      }
      throw decodingError
    } catch {
      throw error
    }
  }
  
  
   func fetchData<T: Decodable>(api: API) async -> LoadingState<T> {
      do {
          let data = try await request(api, responseType: T.self)
          return .success(data)
      } catch let error as APIError {
          return .failure(error)
      } catch let error as URLError {
          let apiError = APIError(code: error.code.rawValue, message: "网络连接似乎有问题，请检查您的网络设置。")
          return .failure(apiError)
      } catch {
          return .failure(error)
      }
  }
}


/// 辅助协议，用于判断 T 是否为 Optional
private protocol ExpressibleByNilLiteral {
    init(nilLiteral: ())
}
extension Optional: ExpressibleByNilLiteral {}

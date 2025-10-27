//
//  LoadingState.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/27.
//

import Foundation

enum LoadingState<Value> {
  
  /// 正在等待前置条件，比如权限许可
  case awaitingPermission
  
  ///正在加载
  case loading
  
  /// 加载成功 并附带请求到的数据
  case success(Value)
  
  /// 加载失败 附带失败消息
  case failure(Error)
  
  var isLoading: Bool {
    switch self {
    case .awaitingPermission, .loading:
      return true
    case .success, .failure:
      return false
    }
  }
}

//
//  NewsViewModel.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/27.
//

import SwiftUI
import Combine

@MainActor
class NewsViewModel: ObservableObject {
  static let shared = NewsViewModel()
  
  @Published var dailyNews: LoadingState<DailyNewsData> = .awaitingPermission
  @Published var douyinHot: LoadingState<[DouyinData]> = .awaitingPermission
  @Published var xiaohongshuHot: LoadingState<[XiaohongshuData]> = .awaitingPermission
  @Published var bilibiliHot: LoadingState<[BiliBiliData]> = .awaitingPermission
  
  private var hasLoadedDailyNews = false
  private var hasLoadedDouyinHot = false
  private var hasLoadedXiaohongshuHot = false
  private var hasLoadedBiliBiliHot = false

  private let networkService = NetworkService.shared
  private init() {}
  
  // MARK: - 公开的 Fetch 方法
  func fetchDailyNews() async {
    guard !hasLoadedDailyNews else { return }
    dailyNews = .loading
    
    let result: LoadingState<DailyNewsData> = await networkService.fetchData(api: API.dailyNews60s)
    dailyNews = result
    
    if case .success = result {
      hasLoadedDailyNews = true
    }
  }
  
  func fetchDouyinHot() async {
    guard !hasLoadedDouyinHot else { return }
    douyinHot = .loading
    
    let result: LoadingState<[DouyinData]> = await networkService.fetchData(api: API.douyinHotSearch)
    douyinHot = result
    
    if case .success = result {
      hasLoadedDouyinHot = true
    }
  }
  
  func fetchXiaohongshuHot() async {
    guard !hasLoadedXiaohongshuHot else { return }
    xiaohongshuHot = .loading
    
    let result: LoadingState<[XiaohongshuData]> = await networkService.fetchData(api: API.xiaohongshuHot)
    xiaohongshuHot = result
    
    if case .success = result {
      hasLoadedXiaohongshuHot = true
    }
  }
  
  func fetchBiliBiliHot() async {
    guard !hasLoadedBiliBiliHot else { return }
    bilibiliHot = .loading
    
    let result: LoadingState<[BiliBiliData]> = await networkService.fetchData(api: API.bilibiliHotSearch)
    bilibiliHot = result
    
    if case .success = result {
      hasLoadedBiliBiliHot = true
    }
  }
  
}

//
//  RecreationViewModel.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/27.
//

import SwiftUI
import Combine

@MainActor
class RecreationViewModel: ObservableObject {
  static let shared = RecreationViewModel()
  
  @Published var epicFreeGames: LoadingState<[EpicFreeGame]> = .awaitingPermission
  
  private var hasLoadedEpicGame = false

  private let networkService = NetworkService.shared
  private init() {
    Task {
      await fetchEpicFreeGames()
    }
  }
  
  func fetchEpicFreeGames() async {
    guard !hasLoadedEpicGame else { return }
    epicFreeGames = .loading
    
    let result: LoadingState<[EpicFreeGame]> = await networkService.fetchData(api: API.epicGamesFree)
    epicFreeGames = result
    
    if case .success = result {
      hasLoadedEpicGame = true
    }
  }
  
}

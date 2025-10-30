//
//  Recreation.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/27.
//

import SwiftUI

struct Recreation: View {
  @StateObject private var viewModel = RecreationViewModel.shared
  @State private var showDetail: EpicFreeGame?
  
  var body: some View {
    NavigationView {
      ZStack {
        LoadingStateView(
          loadingState: viewModel.epicFreeGames,
          onRefresh: {
            await viewModel.fetchEpicFreeGames()
          }
        ) { data in
          List {
            ForEach(data) { item in
              EpicGameRow(game: item)
                .onTapGesture {
                  showDetail = item
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
          }
          .listStyle(.plain)
          .scrollContentBackground(.hidden)
        }
        .navigationTitle("Epic 本周免费")
        .navigationBarTitleDisplayMode(.large)
      }
    }
    .sheet(item: $showDetail) { item in
      EpicFreeGameView(game: item)
    }
    .task {
      await viewModel.fetchEpicFreeGames()
    }
  }
}

#Preview {
  Recreation()
}

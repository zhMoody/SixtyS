//
//  ZhihuHot.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/31.
//

import SwiftUI

struct ZhihuHot: View {
  @StateObject private var viewModel = NewsViewModel.shared
  @State private var selectedItem: ZhihuData?
  
  var body: some View {
    LoadingStateView(
      loadingState: viewModel.zhihuHot,
      onRefresh: { await viewModel.fetchZhihuHot() }
    ) { data in
      List {
        ForEach(data) { item in
          ZhihuHotRow(item: item)
            .onTapGesture {
              selectedItem = item
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
      }
      .listStyle(.plain)
      .background(Color(.systemGroupedBackground))
      .refreshable {
        await viewModel.fetchZhihuHot()
      }
    }
    .sheet(item: $selectedItem) { item in
      ZhihuDetailSheet(item: item)
    }
    .task {
      await viewModel.fetchZhihuHot()
    }
  }
}

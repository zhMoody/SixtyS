//
//  BaiduTiebaHot.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/31.
//

import SwiftUI

struct BaiduTiebaHot: View {
  @StateObject private var viewModel = NewsViewModel.shared
  @Environment(\.openURL) private var openURL
  
  private func openApp(for item: BaiduTiebaData) {
    if let appURL = item.appLink, UIApplication.shared.canOpenURL(appURL) {
      openURL(appURL)
    } else {
      openURL(item.url)
    }
  }
  
  var body: some View {
    LoadingStateView(
      loadingState: viewModel.baiduTiebaHot,
      onRefresh: { await viewModel.fetchBaiduTiebaHot() }
    ) { data in
      List {
        ForEach(data) { item in
          BaiduTiebaRow(item: item)
            .onTapGesture {
              openApp(for: item)
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .padding(.horizontal)
            .padding(.vertical, 6)
        }
      }
      .listStyle(.plain)
      .background(Color(.systemGroupedBackground))
      .refreshable {
        await viewModel.fetchBaiduTiebaHot()
      }
    }
    .task {
      await viewModel.fetchBaiduTiebaHot()
    }
  }
}

#Preview {
  BaiduTiebaHot()
}

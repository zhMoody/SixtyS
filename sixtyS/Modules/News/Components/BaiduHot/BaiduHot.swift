//
//  BaiduHot.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/31.
//

import SwiftUI

struct BaiduHot: View {
  @StateObject private var viewModel = NewsViewModel.shared
  @Environment(\.openURL) private var openURL
  
  private func openApp(for item: BaiduHotData) {
    if let appURL = item.appLink, UIApplication.shared.canOpenURL(appURL) {
      openURL(appURL)
    } else {
      openURL(item.url)
    }
  }
  
  var body: some View {
    LoadingStateView(
      loadingState: viewModel.baiduHot,
      onRefresh: { await viewModel.fetchBaiduHot() }
    ) { data in
      List {
        ForEach(data) { item in
          BaiduHotRow(item: item)
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
        await viewModel.fetchBaiduHot()
      }
    }
    .task {
      await viewModel.fetchBaiduHot()
    }
  }
}

#Preview {
  // 你需要在这里提供一个 BaiduHotData 的实例用于预览
  BaiduHot()
}

//
//  XiaohongshuHot.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/27.
//
import SwiftUI

struct BiliBiliHot: View {
  @StateObject private var viewModel = NewsViewModel.shared
  @Environment(\.openURL) private var openURL
  
  private func openBiliBili(for data: BiliBiliData) {
    if let appURL = data.appLink, UIApplication.shared.canOpenURL(appURL) {
      openURL(appURL)
    } else {
      openURL(data.link)
    }
  }
  
  var body: some View {
    LoadingStateView(
      loadingState: viewModel.bilibiliHot,
      onRefresh: {await viewModel.fetchBiliBiliHot()}
    ) { data in
      List {
        ForEach(Array(data.enumerated()), id: \.element.id) { index, item in
          BilibiliHotRow(rank: index + 1, item: item)
            .onTapGesture {
              openBiliBili(for: item)
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .padding(.horizontal)
            .padding(.vertical, 6)
        }
      }
      .listStyle(.plain)
      .refreshable {
        await viewModel.fetchBiliBiliHot()
      }
    }
    .task {
      await viewModel.fetchBiliBiliHot()
    }
  }
}

#Preview {
  BiliBiliHot()
}

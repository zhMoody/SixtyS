//
//  XiaohongshuHot.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/27.
//
import SwiftUI

struct XiaohongshuHot: View {
  
  
  @StateObject private var viewModel = NewsViewModel.shared
  @Environment(\.openURL) private var openURL
  
  private func openXiaohongshu(for data: XiaohongshuData) {
    if let appURL = data.appLink, UIApplication.shared.canOpenURL(appURL) {
      openURL(appURL)
    } else {
      openURL(data.link)
    }
  }
  
  var body: some View {
    LoadingStateView(
      loadingState: viewModel.xiaohongshuHot,
      onRefresh: {await viewModel.fetchXiaohongshuHot()}
    ) { data in
      List {
        ForEach(data) { item in
          XiaohongshuHotRow(item: item)
            .onTapGesture {
              openXiaohongshu(for: item)
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .padding(.horizontal)
            .padding(.vertical, 4)
          
        }
      }
      .listStyle(.plain)
      .refreshable {
        await viewModel.fetchXiaohongshuHot()
      }
    }
    .task {
      await viewModel.fetchXiaohongshuHot()
    }
  }
}

#Preview {
  XiaohongshuHot()
}

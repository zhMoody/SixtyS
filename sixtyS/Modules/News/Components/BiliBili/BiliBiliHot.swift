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
  
  private func openBiliBili(data: BiliBiliData) {
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
        ForEach(data) { item in
          HStack {
              Text("\(item.title)")
                .font(.body)
          }
          .onTapGesture {
            openBiliBili(data: item)
          }
        }
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

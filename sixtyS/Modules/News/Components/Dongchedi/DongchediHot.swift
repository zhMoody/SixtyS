//
//  DongchediHot.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/31.
//

import SwiftUI

struct DongchediHot: View {
  @StateObject private var viewModel = NewsViewModel.shared
  @Environment(\.openURL) private var openURL
  
  private func openApp(for item: DongchediData) {
    if let appURL = item.appLink, UIApplication.shared.canOpenURL(appURL) {
      openURL(appURL)
    } else {
      openURL(item.url)
    }
  }
  
  var body: some View {
    LoadingStateView(
      loadingState: viewModel.dongchediHot,
      onRefresh: { await viewModel.fetchDongchediHot() }
    ) { data in
      List {
        ForEach(data) { item in
          DongchediHotRow(item: item)
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
        await viewModel.fetchDongchediHot()
      }
    }
    .task {
      await viewModel.fetchDongchediHot()
    }
  }
}

#Preview {
  DongchediHot()
}

//
//  DouyinHot.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/27.
//
import SwiftUI

struct DouyinHot: View {
  @StateObject private var viewModel = NewsViewModel.shared
  @State private var showDetail: DouyinData?
  var body: some View {
    LoadingStateView(
      loadingState: viewModel.douyinHot,
      onRefresh: { await viewModel.fetchDouyinHot() }
    ) { data in
      List {
        ForEach(Array(data.enumerated()), id: \.element.id) {index, item in
          DouyinHotRow(rank: index + 1, item: item)
            .onTapGesture {
              showDetail = item
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .padding(.vertical, 4)
            .padding(.trailing)
        }
      }
      .listStyle(.plain)
      .refreshable {
        await viewModel.fetchDouyinHot()
      }
    }
    .sheet(item: $showDetail, onDismiss: {}) { douyinData in
      DouyinHotDetail(douyindata: douyinData)
    }
    .task {
      await viewModel.fetchDouyinHot()
    }
  }
}

#Preview {
  DouyinHot()
}

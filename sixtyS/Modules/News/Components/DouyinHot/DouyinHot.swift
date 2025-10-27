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
      // 2. 在这里的尾随闭包中，只用关心成功状态的 UI
      // 这个闭包会接收到成功状态下的数据 (data)
      List {
        ForEach(data) { item in
          HStack {
            AsyncImage(url: item.cover) { image in
              image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 48, height: 48)
                .clipShape(.rect(cornerRadius: 8))
                .clipped()
            } placeholder: {
              ProgressView()
            }
            VStack(alignment: .leading,spacing: 10) {
              Text("\(item.title)")
                .font(.body)
              HStack {
                Text("\(item.active_time)")
                  .font(.caption2)
                Spacer()
                Label("\(item.hot_value)", systemImage: "flame.fill")
                  .font(.caption2)
                  .foregroundStyle(.red)
              }
            }
          }
          .onTapGesture {
            showDetail = item
          }
        }
      }
      .listStyle(.plain) // 推荐设置一个样式
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

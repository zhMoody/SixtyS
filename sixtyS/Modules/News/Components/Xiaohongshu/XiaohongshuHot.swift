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
  
  private func openXiaohongshu(data: XiaohongshuData) {
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
          HStack {
//            AsyncImage(url: URL(string: item.work_type_icon)) { image in
//              image.resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 48, height: 48)
//                .clipShape(.rect(cornerRadius: 8))
//                .clipped()
//            } placeholder: {
//              ProgressView()
//            }
            VStack(alignment: .leading,spacing: 10) {
              Text("\(item.title)")
                .font(.body)
                Label("\(item.score)", systemImage: "flame.fill")
                  .font(.caption2)
                  .foregroundStyle(.red)
            }
          }
          .onTapGesture {
            openXiaohongshu(data: item)
          }
        }
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

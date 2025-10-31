//
//  Sixty.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/27.
//

import SwiftUI

struct SixtyHot: View {
  @StateObject private var viewModel = NewsViewModel.shared
  
  var body: some View {
    NavigationView {
      LoadingStateView(
        loadingState: viewModel.dailyNews,
        onRefresh: { await viewModel.fetchDailyNews() }
      ) { news in
        ScrollView {
          VStack(spacing: 24) {
            
            // 1. 顶部 Hero 图片
            AsyncImage(url: news.image) { image in
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
            } placeholder: {
              ZStack {
                Rectangle().fill(.gray.opacity(0.2))
                ProgressView()
              }
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(maxWidth: .infinity)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(radius: 10)
            .overlay(
              headerOverlay(for: news.date)
            )
            .padding(.horizontal)
            
            newsSection(for: news.news)
            
            tipSection(for: news.tip)
          }
          .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .refreshable {
          await viewModel.fetchDailyNews()
        }
      }
      .navigationBarTitleDisplayMode(.inline)
    }
    .task {
      await viewModel.fetchDailyNews()
    }
  }
  
  
  // 图片上的标题遮罩
  private func headerOverlay(for date: String) -> some View {
    ZStack(alignment: .bottomLeading) {
      LinearGradient(
        gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
        startPoint: .center,
        endPoint: .bottom
      )
      
      Text(date)
        .font(.title.bold())
        .foregroundStyle(.white)
        .shadow(radius: 5)
        .padding()
    }
    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
  }
  
  // 新闻列表部分
  private func newsSection(for newsItems: [String]) -> some View {
    VStack(alignment: .leading, spacing: 16) {
      ForEach(Array(newsItems.enumerated()), id: \.offset) { index, newsItem in
        HStack(alignment: .top, spacing: 12) {
          Text("\(index + 1).")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.secondary)
          
          Text(newsItem)
            .font(.body)
        }
      }
    }
    .padding()
    .background(.background)
    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    .padding(.horizontal)
  }
  
  // 语录部分
  private func tipSection(for tip: String) -> some View {
    VStack(alignment: .leading, spacing: 10) {
      Label("今日语录", systemImage: "quote.bubble.fill")
        .font(.headline)
        .foregroundStyle(.secondary)
      
      Text(tip)
        .font(.body)
        .italic()
        .lineSpacing(5)
    }
    .padding()
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(.background)
    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    .padding(.horizontal)
  }
}


#Preview {
  SixtyHot()
}

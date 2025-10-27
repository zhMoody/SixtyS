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
    Group {
      LoadingStateView(loadingState: viewModel.dailyNews, onRefresh: {
        await viewModel.fetchDailyNews()
      }) { news in
        List {
          Section(header: Text(news.date)) {
            AsyncImage(url: news.image) { image in
              image.resizable().aspectRatio(contentMode: .fit)
                .clipShape(.rect(cornerRadius: 15))
            } placeholder: {
              ProgressView()
            }
            
            ForEach(news.news, id: \.self) { newsItem in
              Text(newsItem)
            }
          }
          
          Section(header: Text("今日语录")) {
            Text(news.tip)
              .italic()
          }
        }
      }
    }
    .task {
      await viewModel.fetchDailyNews()
    }
  }
}

#Preview {
  SixtyHot()
}

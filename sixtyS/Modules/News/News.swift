//
//  News.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/27.
//

import SwiftUI

struct NewsView: View {
  @State private var selectedIndex = 0
  
  var body: some View {
    VStack(spacing: 0) {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 20) {
          ForEach(Array(HotSearchCategory.allCases.enumerated()), id: \.offset) { index, title in
            VStack {
              Text(title.rawValue)
                .font(.headline)
                .foregroundColor(selectedIndex == index ? .blue : .gray)
              Rectangle()
                .fill(selectedIndex == index ? .blue : .clear)
                .frame(height: 2)
                .animation(.easeOut(duration: 0.2), value: selectedIndex)
            }
            .onTapGesture {
              selectedIndex = index
            }
          }
        }
      }
      .padding(.horizontal)
      .padding(.top, 60)
      .padding(.bottom, 10)
        
        Divider()
        
        TabView(selection: $selectedIndex) {
          ForEach(Array(HotSearchCategory.allCases.enumerated()), id: \.offset) { index, title in
            switch title {
            case .sixtyHot:
              SixtyHot()
                .tag(index)
            case .douyinHot:
              DouyinHot()
                .tag(index)
            case .xiaohongshuHot:
              XiaohongshuHot()
                .tag(index)
             case .bilibiliHot,
                .weiboHot,
                .baiduHot,
                .baidutiebaHot,
                .zhihuHot,
                .dongcediHot,
                .hackernewsHot:
              Text("hello world")
                .tag(index)
            }
          }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
      }
    .ignoresSafeArea()
  }
}


#Preview {
  NewsView()
}

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
      ScrollViewReader { proxy in
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
              }
              .onTapGesture {
                selectedIndex = index
              }
              .id(index)
            }
          }
        }
        .onChange(of: selectedIndex) { oldValue, newValue in
          withAnimation(.spring()) {
            proxy.scrollTo(newValue, anchor: .center)
          }
        }
      }
      .padding(.horizontal)
      .padding(.top, 60)
      .padding(.bottom, 10)
      
      Divider()
      
      TabView(selection: $selectedIndex) {
        ForEach(Array(HotSearchCategory.allCases.enumerated()), id: \.offset) { index, title in
          HotSearchPageView(category: title)
            .tag(index)
        }
      }
      .tabViewStyle(.page(indexDisplayMode: .never))
      .animation(.interactiveSpring(), value: selectedIndex)
    }
    .ignoresSafeArea()
  }
}

// (推荐) 创建一个辅助视图来承载 switch 逻辑，提高 TabView 性能和可读性
struct HotSearchPageView: View {
  let category: HotSearchCategory
  
  var body: some View {
    switch category {
    case .sixtyHot:
      SixtyHot()
    case .douyinHot:
      DouyinHot()
    case .xiaohongshuHot:
      XiaohongshuHot()
    case .bilibiliHot:
      BiliBiliHot()
    case .baiduHot:
      BaiduHot()
    case .baidutiebaHot:
      BaiduTiebaHot()
    case .zhihuHot:
      ZhihuHot()
    case .dongcediHot:
      DongchediHot()
    }
  }
}


#Preview {
  NewsView()
}

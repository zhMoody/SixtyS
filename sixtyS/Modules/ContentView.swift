//
//  ContentView.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/24.
//

import SwiftUI

struct ContentView: View {
 
  var body: some View {

      TabView {
        NewsView()
          .tabItem {
            Label("热搜",systemImage: "flame.circle.fill")
          }
        Recreation()
          .tabItem {
            Label("娱乐",systemImage: "tornado.circle.fill")
          }
        HotSearch()
          .tabItem {
            Label("其它",systemImage: "apple.writing.tools")
          }
      }
  }
}

#Preview {
  ContentView()
}

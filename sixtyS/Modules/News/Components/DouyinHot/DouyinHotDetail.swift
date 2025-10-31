//
//  DouyinHotDetail.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/27.
//


import SwiftUI

struct DouyinHotDetail: View {
  var douyindata: DouyinData
  
  @Environment(\.dismiss) private var dismiss
  @Environment(\.openURL) private var openURL
  
  private var formattedHotValue: String {
    let value = Double(douyindata.hot_value)
    if value >= 100_000_000 {
      return String(format: "%.2f 亿", value / 100_000_000)
    } else if value >= 10_000 {
      return String(format: "%.2f 万", value / 10_000)
    } else {
      return "\(douyindata.hot_value)"
    }
  }
  
  private func openDouyin() {
    if let appURL = douyindata.appLink, UIApplication.shared.canOpenURL(appURL) {
      openURL(appURL)
    } else {
      openURL(douyindata.link)
    }
  }
  
  var body: some View {
    // 1. GeometryReader作为根视图，获取屏幕尺寸
    GeometryReader { geo in
      ZStack(alignment: .topTrailing) {
        
        VStack(spacing: 0) {
          
          AsyncImage(url: douyindata.cover) { phase in
            switch phase {
            case .empty:
              ZStack {
                Rectangle().fill(Color.gray.opacity(0.2))
                ProgressView()
              }
            case .success(let image):
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
            case .failure:
              ZStack {
                Rectangle().fill(Color.gray.opacity(0.2))
                Image(systemName: "photo.fill").font(.largeTitle).foregroundColor(.gray)
              }
            @unknown default:
              EmptyView()
            }
          }
          .frame(width: geo.size.width,height: geo.size.height * 0.55)
          .clipped()
          
          // MARK: - 内容区域
          VStack(alignment: .leading, spacing: 10) {
            Text(douyindata.title)
              .font(.title2)
              .fontWeight(.bold)
              .padding(.top)
            
            HStack(spacing: 20) {
              Label {
                Text(formattedHotValue)
              } icon: {
                Image(systemName: "flame.fill")
              }
              .font(.subheadline)
              .foregroundColor(.red)
              .padding(.vertical, 8)
              .padding(.horizontal, 12)
              .background(Color.red.opacity(0.1))
              .clipShape(Capsule())
              
              Label {
                Text(douyindata.active_time)
              } icon: {
                Image(systemName: "clock.fill")
              }
              .font(.subheadline)
              .foregroundColor(.secondary)
            }
            .padding(.bottom, 80)
          }
          .padding(.horizontal)
          .frame(maxWidth: .infinity, alignment: .leading)
          Spacer()
          
          // MARK: - 底部按钮
          Button(action: {
            openDouyin()
          }) {
            Label("前往抖音查看", systemImage: "arrow.up.right.square.fill")
              .fontWeight(.bold)
              .font(.headline)
              .foregroundColor(.white)
              .padding()
              .frame(maxWidth: .infinity)
              .background(Color.blue.gradient)
              .cornerRadius(15)
              .shadow(color: .blue.opacity(0.4), radius: 8, y: 5)
          }
          .padding(.horizontal)
          .padding(.bottom, 30)
        }
        .background(Color(.systemBackground))
        .frame(height: geo.size.height)
        
        // MARK: - 关闭按钮
        Button(action: { dismiss() }) {
          Image(systemName: "xmark.circle.fill")
            .font(.largeTitle)
            .symbolRenderingMode(.palette)
            .foregroundStyle(.white, .black.opacity(0.5))
            .shadow(radius: 5)
        }
        .padding()
      }
    }
    .ignoresSafeArea() // 整个视图忽略安全区域，由内部 padding 控制边距
  }
}

#Preview {
  DouyinHotDetail(douyindata: DouyinData(
    title: "六耳大禹王维官宣",
    hot_value: 121211221,
    cover: URL(string: "https://p9-sign.douyinpic.com/tos-cn-p-0015/o0PB55GwLfZBmxMgh7QuACFBTfKQQaHeARY0cI~noop.jpeg?lk3s=bfd515bb&x-expires=1758722400&x-signature=HXnSS1a0FraAWgpKTA6rVfd4se0%3D&from=3218412987")!,
    link: URL(string: "https://www.douyin.com")!,
    event_time: "",
    event_time_at: 0,
    active_time: "2025-10-27 17:17:15",
    active_time_at: 0
  ))
}

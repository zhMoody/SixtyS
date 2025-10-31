//
//  XiaohongshuHotRow.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/31.
//

import SwiftUI

struct XiaohongshuHotRow: View {
  let item: XiaohongshuData
  
  var body: some View {
    HStack(spacing: 16) {
      // 1. 排名
      Text("\(item.rank)")
        .font(.system(size: 20, weight: .bold))
        .italic()
        .foregroundStyle(rankColor(for: item.rank))
        .frame(width: 35, alignment: .center)
      
      // 2. 主要内容
      VStack(alignment: .leading, spacing: 6) {
        // 标题和类型图标
        HStack {
          Text(item.title)
            .font(.body)
            .fontWeight(.medium)
            .lineLimit(1)
          
          Spacer()
          
          // 异步加载类型图标
          if let iconURLString = item.work_type_icon, let iconURL = URL(string: iconURLString) {
            AsyncImage(url: iconURL) { image in
              image.resizable()
            } placeholder: {
              ProgressView()
            }
            .frame(width: 16, height: 16)
          }
        }
        
        // 热度和标签
        HStack(spacing: 12) {
          Label(item.score, systemImage: "flame.fill")
            .foregroundStyle(.red)
          
          if item.word_type != "无" {
            Text(item.word_type)
              .padding(.horizontal, 6)
              .background(Color.red.opacity(0.1))
              .clipShape(Capsule())
          }
        }
        .font(.caption)
        .foregroundStyle(.secondary)
      }
    }
    .padding(.vertical, 10)
  }
  
  // 辅助函数：根据排名返回不同颜色
  private func rankColor(for rank: Int) -> Color {
    switch rank {
    case 1: return .red
    case 2: return .orange
    case 3: return .yellow
    default: return .secondary
    }
  }
}

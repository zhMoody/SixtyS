//
//  BaiduHotRow.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/31.
//

import SwiftUI

struct BaiduHotRow: View {
  let item: BaiduHotData
  
  var body: some View {
    HStack(alignment: .top, spacing: 12) {
      Text("\(item.rank)")
        .font(.system(size: 20, weight: .bold))
        .italic()
        .foregroundStyle(rankColor(for: item.rank))
        .frame(width: 35, alignment: .center)
      
      VStack(alignment: .leading, spacing: 6) {
        HStack {
          Text(item.title)
            .font(.headline)
            .fontWeight(.semibold)
          
          if let iconURL = item.typeIcon {
            AsyncImage(url: iconURL) { $0.resizable() } placeholder: { ProgressView() }
              .frame(width: 16, height: 16)
          }
        }
        
        Text(item.desc)
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .lineLimit(2)
        
        // 热度
        Label(item.score, systemImage: "chart.bar.xaxis")
          .font(.caption)
          .foregroundStyle(.secondary)
          .padding(.top, 4)
      }
      
      Spacer(minLength: 8)
      
      // 3. 封面图
      AsyncImage(url: item.cover) { image in
        image.resizable().aspectRatio(contentMode: .fill)
      } placeholder: {
        RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray5))
      }
      .frame(width: 100, height: 75)
      .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    .padding()
    .background(Color(.systemBackground))
    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
  }
  
  private func rankColor(for rank: Int) -> Color {
    switch rank {
    case 1: return .red
    case 2: return .orange
    case 3: return .yellow
    default: return .secondary
    }
  }
}

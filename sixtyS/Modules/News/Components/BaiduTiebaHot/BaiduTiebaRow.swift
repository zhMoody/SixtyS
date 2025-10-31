//
//  BaiduTiebaRow.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/31.
//

import SwiftUI

struct BaiduTiebaRow: View {
  let item: BaiduTiebaData
  
  var body: some View {
    HStack(spacing: 12) {
      Text("\(item.rank)")
        .font(.system(size: 20, weight: .bold))
        .italic()
        .foregroundStyle(rankColor(for: item.rank))
        .frame(width: 35, alignment: .center)
      
      // 2. 内容区 (标题、描述、热度)
      VStack(alignment: .leading, spacing: 6) {
        Text(item.title)
          .font(.headline)
          .fontWeight(.bold)
          .lineLimit(1)
        
        Text(item.desc)
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .lineLimit(2)
        
        Label(item.scoreDesc, systemImage: "bubble.left.and.bubble.right.fill")
          .font(.caption)
          .foregroundStyle(Color(red: 0.1, green: 0.45, blue: 0.95))
          .padding(.top, 2)
      }
      
      Spacer(minLength: 8)
      
      AsyncImage(url: item.avatar) { image in
        image.resizable().aspectRatio(contentMode: .fill)
      } placeholder: {
        Circle().fill(Color(.systemGray5))
      }
      .frame(width: 50, height: 50)
      .clipShape(Circle())
      .overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 1))
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

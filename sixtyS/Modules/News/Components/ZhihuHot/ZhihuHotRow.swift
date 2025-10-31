//
//  ZhihuHotRow.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/31.
//

import SwiftUI

struct ZhihuHotRow: View {
  let item: ZhihuData
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(item.title)
        .font(.headline)
        .fontWeight(.bold)
        .lineLimit(2)
      
      HStack(alignment: .top, spacing: 12) {
        Text(item.detail ?? "-")
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .lineLimit(3)
        
        Spacer(minLength: 8)
        
        AsyncImage(url: item.cover) { image in
          image.resizable().aspectRatio(contentMode: .fill)
        } placeholder: {
          RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray5))
        }
        .frame(width: 90, height: 70)
        .clipShape(RoundedRectangle(cornerRadius: 8))
      }
      
      Text(item.hotValueDesc)
        .font(.caption)
        .fontWeight(.medium)
        .foregroundStyle(.red)
    }
    .padding()
    .background(Color(.systemBackground))
    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
  }
}

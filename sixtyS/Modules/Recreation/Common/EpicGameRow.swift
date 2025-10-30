//
//  EpicGameRow.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/30.
//

import SwiftUI

struct EpicGameRow: View {
  let game: EpicFreeGame
  
  var body: some View {
    HStack(spacing: 16) {
      AsyncImage(url: game.cover) { image in
        image.resizable()
      } placeholder: {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
          .fill(.gray.opacity(0.3))
      }
      .aspectRatio(16/9, contentMode: .fill)
      .frame(width: 120)
      .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
      
      VStack(alignment: .leading, spacing: 8) {
        Text(game.title)
          .font(.headline)
          .fontWeight(.bold)
          .lineLimit(2)
        
        Text(game.seller)
          .font(.subheadline)
          .foregroundStyle(.secondary)
        
        Spacer()
        
        Label(game.freeStartAndEndString, systemImage: "clock.fill")
          .font(.caption2)
          .foregroundStyle(.secondary)
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Spacer()
        HStack {
          Text(game.isFreeNow ? "限时免费" : "即将推出")
            .font(.caption.bold())
            .foregroundStyle(.black)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(game.isFreeNow ? Color.green : Color.blue)
            .clipShape(Capsule())
          
          Text(game.originalPriceDesc)
            .strikethrough(true, color: .gray)
            .font(.caption)
            .foregroundStyle(.secondary)
        }
      }
    }
    .padding()
    .background(.black.opacity(0.2))
    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
  }
}

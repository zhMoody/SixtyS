//
//  DouyinHotRow.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/31.
//

import SwiftUI

struct DouyinHotRow: View {
    let rank: Int
    let item: DouyinData
    
    private let titleMinHeight: CGFloat = 44

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // 1. 排名
            Text("\(rank)")
                .font(.system(size: 20, weight: .bold))
                .italic()
                .foregroundStyle(rankColor(for: rank))
                .frame(width: 35, alignment: .center)

            VStack(alignment: .leading, spacing: 5) {
                // 标题
                Text(item.title)
                    .font(.system(size: 17, weight: .medium))
                    .lineLimit(2)
                    .frame(minHeight: titleMinHeight, alignment: .top)

                HStack(spacing: 8) {
                    HStack(spacing: 2) {
                        Image(systemName: "flame.fill")
                        .font(.caption2)
                        Text("\(item.formattedHotValueNumber) 万")
                        .font(.caption2)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(item.formattedDate)
                        .font(.caption2)
                        Text(item.formattedTime)
                        .font(.caption2)
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            
            Spacer()

            AsyncImage(url: item.cover) { image in
                image.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                RoundedRectangle(cornerRadius: 6).fill(Color(.systemGray5))
            }
            .frame(width: 100, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .padding(.vertical, 8)
    }
    
    private func rankColor(for rank: Int) -> Color {
        switch rank {
        case 1: return .red
        case 2: return .orange
        case 3: return Color(red: 0.9, green: 0.7, blue: 0) // 更深的黄色
        default: return .secondary
        }
    }
}

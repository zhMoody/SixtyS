//
//  BilibiliHotRow.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/31.
//

import SwiftUI

struct BilibiliHotRow: View {
    let rank: Int
    let item: BiliBiliData
    
    var body: some View {
        HStack(spacing: 16) {
            Text("\(rank)")
            .font(.system(size: 20, weight: .bold))
            .italic()
            .foregroundStyle(rankColor(for: rank))
            .frame(width: 35, alignment: .center)

            Text(item.title)
                .font(.headline)
            
            Spacer()
            
            Image(systemName: "play.tv.fill")
                .foregroundStyle(Color(red: 0.98, green: 0.44, blue: 0.63))
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
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

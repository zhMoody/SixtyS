//
//  DongchediHotRow.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/31.
//

import SwiftUI

struct DongchediHotRow: View {
    let item: DongchediData
    
    private let themeColor = Color(red: 0.1, green: 0.45, blue: 0.9)

    var body: some View {
        HStack(spacing: 16) {
            Text("\(item.rank)")
            .font(.system(size: 20, weight: .bold))
            .italic()
            .foregroundStyle(rankColor(for: item.rank))
            .frame(width: 35, alignment: .center)

            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.headline)
                    .lineLimit(2)
                
                // 使用“仪表盘”图标，非常符合汽车主题
                Label(item.scoreDesc, systemImage: "gauge.high")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(themeColor)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
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

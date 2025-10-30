//
//  EpicFreeGameView.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/30.
//

import SwiftUI

struct EpicFreeGameView: View {
    let game: EpicFreeGame

    var body: some View {
      GeometryReader { geo in
        ZStack {
            AsyncImage(url: game.cover) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 10, opaque: true)
            } placeholder: {
                Color.black
            }
            .overlay(.black.opacity(0.6))
            .ignoresSafeArea()
            .frame(width: geo.size.width, height: geo.size.height)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                  
                  AsyncImage(url: game.cover) { image in
                    image
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                  } placeholder: {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                      .fill(.gray.opacity(0.3))
                  }
                  .aspectRatio(16/9, contentMode: .fit)
                  .frame(maxWidth: .infinity)
                  .clipped()
                  .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                  .shadow(color: .black.opacity(0.4), radius: 10, y: 5)
                  .padding(.horizontal)
                  
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(game.title)
                            .font(.largeTitle.bold())
                        Text(game.seller)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)

                    HStack {
                      Text(game.isFreeNow ? "限时免费" : "即将推出")
                            .font(.caption.bold())
                            .foregroundStyle(.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(game.isFreeNow ? Color.green : Color.blue)
                            .clipShape(Capsule())
                        
                        Text(game.originalPriceDesc)
                            .strikethrough(true, color: .gray)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)
                    
                    // 4. 主要操作按钮 (Call to Action)
                    Link(destination: game.link) {
                        Label("在 EPIC 商店获取", systemImage: "cart.fill.badge.plus")
                            .font(.headline.weight(.bold))
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.1, green: 0.45, blue: 0.95))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .padding(.horizontal)
                    
                    Label(game.freeUntilString, systemImage: "clock.fill")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("游戏简介")
                            .font(.title2.bold())
                        Text(game.description)
                            .font(.body)
                            .lineSpacing(5)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(.black.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .padding(.horizontal)

                }
                .padding(.vertical)
            }
        }
        .foregroundStyle(.white)
      }
    }
}

// MARK: - 预览代码
#Preview {
    let sampleJSON = """
    {
        "id": "185405ac2556457883827885b44e0e69",
        "title": "Project Winter",
        "cover": "https://cdn1.epicgames.com/spt-assets/8b114e51c13344978e0b8693dea6bb74/project-winter-phsnu.png",
        "original_price": 31,
        "original_price_desc": "¥31.00",
        "description": "In Project Winter, survival is just the beginning. Work with your friends to escape the icy wilderness, but don’t get too comfortable. Traitors lurk among you, ready to lie, sabotage, and turn even the closest of friends against each other. Who will you trust of friends against each other. Who will you trust of friends against each other. Who will you trust of friends against each other. Who will you trust of friends against each other. Who will you trust?",
        "seller": "Other Ocean Interactive",
        "is_free_now": true,
        "free_start": "2025/09/18 23:00:00",
        "free_end": "2025/09/25 23:00:00",
        "link": "https://store.epicgames.com/store/zh-CN/p/project-winter-3b9e84"
    }
    """
    let game = try! JSONDecoder().decode(EpicFreeGame.self, from: sampleJSON.data(using: .utf8)!)
    
    return EpicFreeGameView(game: game)
}

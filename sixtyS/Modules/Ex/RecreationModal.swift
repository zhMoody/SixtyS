//
//  Recreation.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/30.
//

import Foundation

struct EpicGamesResponse: Codable {
  let data: [EpicFreeGame]
}

// 用于表示单个免费游戏
struct EpicFreeGame: Codable, Identifiable {
  let id: String
  let title: String
  let cover: URL
  let originalPrice: Double
  let originalPriceDesc: String
  let description: String
  let seller: String
  let isFreeNow: Bool
  let freeStart: String
  let freeEnd: String
  let link: URL
  
  private enum CodingKeys: String, CodingKey {
    case id, title, cover, description, seller, link
    case originalPrice = "original_price"
    case originalPriceDesc = "original_price_desc"
    case isFreeNow = "is_free_now"
    case freeStart = "free_start"
    case freeEnd = "free_end"
  }
  
  var freeEndDate: Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    formatter.locale = Locale(identifier: "zh_CN")
    return formatter.date(from: freeEnd)
  }
  
  var freeStartDate: Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    formatter.locale = Locale(identifier: "zh_CN")
    return formatter.date(from: freeStart)
  }
  
  var freeUntilString: String {
    guard let date = freeEndDate else { return "限时免费" }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    formatter.locale = Locale(identifier: "zh_CN")
    return "免费至 \(formatter.string(from: date))"
  }
  
  var freeStartAndEndString: String {
    guard let endDate = freeEndDate,let startDate = freeStartDate
    else { return "限时免费" }
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    formatter.locale = Locale(identifier: "zh_CN")
    return "\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))"
  }
}

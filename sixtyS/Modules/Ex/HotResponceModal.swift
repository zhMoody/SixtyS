//
//  Modal.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/24.
//

import Foundation

struct DailyNewsData: Codable, Identifiable {
  var id: String { date }
  
  let date: String
  let news: [String]
  let image: URL
  let tip: String
  let cover: URL
  let link: String
}

struct DouyinData: Codable, Identifiable {
  var id: String { title }
  
  let title: String
  let hot_value: Int
  let cover: URL
  let link: URL
  let event_time: String
  let event_time_at: Int
  let active_time: String
  let active_time_at: Int
  
  var appLink: URL? {
    let urlString = link.absoluteString
    guard urlString.contains("douyin.com/search/") else {
      return nil
    }
    let keyword = link.lastPathComponent
    let deepLinkString = "snssdk1128://search/result?keyword=\(keyword)"
    return URL(string: deepLinkString)
  }
}

struct XiaohongshuData: Codable, Identifiable {
  var id: Int { rank }
  let rank: Int
  let title: String
  let score: String
  let word_type: String
  let work_type_icon: String?
  let link: URL
  
  var appLink: URL? {
      guard let components = URLComponents(url: link, resolvingAgainstBaseURL: false) else {
          return nil
      }
      if let keywordItem = components.queryItems?.first(where: { $0.name == "keyword" }),
         let keyword = keywordItem.value {
          let deepLinkString = "xiaohongshu://search?keyword=\(keyword)"
          return URL(string: deepLinkString)
      }
      return nil
  }

}

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
  let cover: URL?
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
  
  var formattedHotValueNumber: String {
    let value = Double(hot_value)
    if value >= 10_000 {
      return String(format: "%.1f", value / 10_000)
    } else {
      return "\(hot_value)"
    }
  }
  
  // 2. 将 "2025-10-31 10:44:26" 拆分为日期和时间
  var formattedDate: String {
    let components = active_time.split(separator: " ")
    return components.first.map(String.init) ?? ""
  }
  
  var formattedTime: String {
    let components = active_time.split(separator: " ")
    return components.count > 1 ? String(components[1]) : ""
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
    guard let components = URLComponents(url: link, resolvingAgainstBaseURL: false),
          let keywordItem = components.queryItems?.first(where: { $0.name == "keyword" }),
          let keyword = keywordItem.value else {
      return nil
    }
    let deepLinkString = "xiaohongshu://search?keyword=\(keyword)"
    return URL(string: deepLinkString)
  }
  
}

struct BiliBiliData: Codable, Identifiable {
  var id: String { title }
  let title: String
  let link: URL
  
  var appLink: URL? {
    guard let components = URLComponents(url: link, resolvingAgainstBaseURL: false),
          let keywordItem = components.queryItems?.first(where: { $0.name == "keyword" }),
          let keyword = keywordItem.value else {
      return nil
    }
    
    // 构建 Bilibili App 的搜索 URL Scheme
    return URL(string: "bilibili://search?keyword=\(keyword)")
  }
}

struct BaiduHotData: Codable, Identifiable {
  var id: Int { rank }
  
  let rank: Int
  let title: String
  let desc: String
  let score: String
  let cover: URL?
  let typeIcon: URL?
  let url: URL
  
  private enum CodingKeys: String, CodingKey {
    case rank, title, desc, score, cover, url
    case typeIcon = "type_icon"
  }
  
  var appLink: URL? {
    guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
          let keywordItem = components.queryItems?.first(where: { $0.name == "wd" }), // 百度使用 'wd' 作为关键词参数
          let keyword = keywordItem.value else {
      return nil
    }
    
    return URL(string: "baiduboxapp://v1/easybrowse/search?word=\(keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
  }
}

struct BaiduTiebaData: Codable, Identifiable {
    var id: Int { rank }
    
    let rank: Int
    let title: String
    let desc: String
    let scoreDesc: String
    let avatar: URL?
    let url: URL
    
    private enum CodingKeys: String, CodingKey {
        case rank, title, desc, avatar, url
        case scoreDesc = "score_desc"
    }
    
    var appLink: URL? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let topicIDItem = components.queryItems?.first(where: { $0.name == "topic_id" }),
              let topicID = topicIDItem.value else {
            return nil
        }
        
        return URL(string: "baidu-tieba-na://open/hottopic?topic_id=\(topicID)")
    }
}

struct ZhihuData: Codable, Identifiable, Hashable {
    var id: String { link.absoluteString }
    
    let title: String
    let detail: String?
    let cover: URL?
    let hotValueDesc: String
    let answerCount: Int
    let followerCount: Int
    let link: URL

    private enum CodingKeys: String, CodingKey {
        case title, detail, cover, link
        case hotValueDesc = "hot_value_desc"
        case answerCount = "answer_cnt"
        case followerCount = "follower_cnt"
    }
    
    var appLink: URL? {
        let questionID = link.lastPathComponent
        guard !questionID.isEmpty else { return nil }
        return URL(string: "zhihu://question/\(questionID)")
    }
}

struct DongchediData: Codable, Identifiable {
  var id: Int { rank }
  
  let rank: Int
  let title: String
  let url: URL
  let scoreDesc: String
  
  private enum CodingKeys: String, CodingKey {
    case rank, title, url
    case scoreDesc = "score_desc"
  }
  
  var appLink: URL? {
    guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
          let keywordItem = components.queryItems?.first(where: { $0.name == "keyword" }),
          let keyword = keywordItem.value,
          let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
      return nil
    }
    
    return URL(string: "dongchedi://search/result?keyword=\(encodedKeyword)")
  }
}

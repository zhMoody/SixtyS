//
//  API.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/24.
//

import Foundation

enum API {
  /// 60 秒看世界
  // MARK: - 新闻
  /// 每天 60 秒读懂世界
  case dailyNews60s
  
  // MARK: - 热搜
  /// 抖音热搜
  case douyinHotSearch
  /// 小红书热点
  case xiaohongshuHot
  /// 哔哩哔哩热搜
  case bilibiliHotSearch
  /// 微博热搜
  case weiboHotSearch
  /// 百度实时热搜
  case baiduHotSearch
  /// 百度贴吧话题榜
  case baiduTiebaTopics
  /// 头条热搜榜
  case toutiaoHotSearch
  /// 知乎话题榜
  case zhihuTopics
  /// 懂车帝热搜
  case dongchediHot
  /// Hacker News 热帖
  case hackerNews(type: String)
  
  // MARK: - 娱乐
  /// Epic Games 游戏
  case epicGamesFree
  /// 百度电视剧榜
  case baiduTvSeriesList
  /// 网易云榜单列表
  case neteaseMusicChartList
  /// 网易云榜单详情 (注意: 这个可能需要榜单ID作为参数)
  case neteaseMusicChartDetail(id: String)
  /// 猫眼全球票房总榜
  case maoyanGlobalBoxOffice
  /// 猫眼电影实时票房
  case maoyanRealtimeBoxOffice
  /// 猫眼电视收视排行
  case maoyanTvRatings
  /// 猫眼网剧实时热度
  case maoyanWebSeriesHot
  
  // MARK: - 其它资讯
  /// 必应每日壁纸
  case bingDailyWallpaper
  /// 当日货币汇率
  case currencyExchangeRate
  /// 历史上的今天
  case historyToday
}

extension API: TargetType {
  
  // 设置基础 URL
  var baseURL: URL {
    // 将 baseURL 放在一个单独的地方管理，比如一个配置文件或常量文件
    return URL(string: "https://60s.7se.cn")!
  }
  
  // 2. 根据不同的 case 返回不同的路径
  var path: String {
    switch self {
      // MARK: - 热搜
    case .dailyNews60s: return "/v2/60s"
    case .douyinHotSearch: return "/v2/douyin"
    case .xiaohongshuHot: return "/v2/rednote"
    case .bilibiliHotSearch: return "/v2/bili"
    case .weiboHotSearch: return "/v2/weibo"
    case .baiduHotSearch: return "/v2/baidu/hot"
    case .baiduTiebaTopics: return "/v2/baidu/tieba"
    case .toutiaoHotSearch: return "/v2/toutiao"
    case .zhihuTopics: return "/v2/zhihu"
    case .dongchediHot: return "/v2/dongchedi"
    case .hackerNews(let type): return "/v2/hacker-news/\(type)"
      // MARK: - 娱乐
    case .epicGamesFree: return "/v2/epic"
    case .baiduTvSeriesList: return "/v2/baidu/teleplay"
    case .neteaseMusicChartList: return "/v2/ncm-rank/list"
    case .neteaseMusicChartDetail(let id): return "/v2/ncm-rank/\(id)"
    case .maoyanGlobalBoxOffice: return "/v2/maoyan/all/movie"
    case .maoyanRealtimeBoxOffice: return "/v2/maoyan/realtime/movie"
    case .maoyanTvRatings: return "/v2/maoyan/realtime/tv"
    case .maoyanWebSeriesHot: return "/v2/maoyan/realtime/web"
    case .bingDailyWallpaper: return "/v2/bing"
      // MARK: - 其它资讯
    case .currencyExchangeRate: return "/v2/exchange-rate"
    case .historyToday: return "/v2/today-in-history"
    }
  }
  
  // 根据不同的 case 自动确定 HTTP 方法
  var method: HTTPMethod {
    switch self {
    default: .get
    }
  }
  
  // 根据不同的 case 自动打包参数
  var task: RequestTask {
    switch self {
      //
      //    case .getPosts(let userId):
      //      // .getPosts(userId:) 有一个 URL 查询参数 'userId'
      //      let params = ["userId": userId]
      //      return .requestParameters(parameters: params, encoding: .queryString)
      //
      //    case .updateUser(_, let name, let email):
      //      // .updateUser(...) 将数据编码为 JSON 请求体
      //      let user = UpdateUserRequest(name: name, email: email)
      //      return .requestJSONEncodable(user)
      //
      //    case .createPost(let title, let body):
      //      // .createPost(...) 同上
      //      let post = CreatePostRequest(title: title, body: body)
      //      return .requestJSONEncodable(post)
      
    default:
      return .requestPlain
    }
  }
  
  //  设置通用的请求头
  var headers: [String: String]? {
    // 这里可以添加全局的 Header，比如 Authorization
    return ["Content-Type": "application/json; charset=UTF-8"]
  }
}

//// MARK: - 定义请求体的数据模型 (Codable)
//// 将请求体定义为 Codable 结构体是最佳实践
//
//struct UpdateUserRequest: Encodable {
//  let name: String
//  let email: String
//}
//
//struct CreatePostRequest: Encodable {
//  let title: String
//  let body: String
//}

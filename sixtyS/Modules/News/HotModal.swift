//
//  Modal.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/27.
//
import Foundation

enum HotSearchCategory: String, CaseIterable, Identifiable {
  var id: String { rawValue }
  case sixtyHot = "60S"
  case douyinHot = "抖音"
  case xiaohongshuHot = "小红书"
  case bilibiliHot = "BiliBili"
  case weiboHot = "微博"
  case baiduHot = "百度实时"
  case baidutiebaHot = "百度贴吧"
  case zhihuHot = "知乎"
  case dongcediHot = "懂车帝"
  case hackernewsHot = "Hacker News"
}

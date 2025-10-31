//
//  ZhihuDetailSheet.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/31.
//

import SwiftUI

struct ZhihuDetailSheet: View {
  let item: ZhihuData
  
  @Environment(\.dismiss) private var dismiss
  @Environment(\.openURL) private var openURL
  
  private func openApp() {
    if let appURL = item.appLink, UIApplication.shared.canOpenURL(appURL) {
      openURL(appURL)
    } else {
      openURL(item.link)
    }
    dismiss()
  }
  
  var body: some View {
    GeometryReader { geo in
    ZStack {
      AsyncImage(url: item.cover) { $0.resizable().aspectRatio(contentMode: .fill).blur(radius: 15) }
      placeholder: { Color(.systemGray6) }
        .frame(width: geo.size.width)
        .overlay(.black.opacity(0.2))
        .ignoresSafeArea()
      
      VStack {
        HStack {
          Spacer()
          Button(action: { dismiss() }) {
            Image(systemName: "xmark.circle.fill")
              .font(.largeTitle)
              .symbolRenderingMode(.palette)
              .foregroundStyle(.white, Color.black.opacity(0.4))
          }
        }
        .padding()
        
        ScrollView {
          VStack(alignment: .leading, spacing: 20) {
            AsyncImage(url: item.cover) {
              $0.resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(.rect(cornerRadius: 15))
            }
            placeholder: { Color(.systemGray6) }
              .overlay(.black.opacity(0.2))
              .clipShape(.rect(cornerRadius: 15))
            
            Text(item.title)
              .font(.title.bold())
            
            HStack {
              Label("\(item.answerCount) 回答", systemImage: "bubble.left.and.bubble.right.fill")
              Spacer()
              Label("\(item.followerCount) 关注", systemImage: "person.2.fill")
              Spacer()
              Label(item.hotValueDesc, systemImage: "flame.fill")
                .foregroundStyle(.red)
            }
            .font(.subheadline.weight(.semibold))
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(item.detail ?? "无详情")
              .font(.body)
              .lineSpacing(6)
          }
          .padding()
        }
        
        Button(action: openApp) {
          Label("前往知乎查看 \(item.answerCount) 个回答", systemImage: "arrow.up.right.square.fill")
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(red: 0, green: 0.4, blue: 0.85))
            .clipShape(Capsule())
        }
        .padding()
      }
      .foregroundStyle(.white)
    }
    .ignoresSafeArea()
    .frame(width: geo.size.width, height: geo.size.height)
    }
  }
}

#Preview {
  ZhihuDetailSheet(item: ZhihuData(
    title: "美参议院通过终止特朗普全面关税政策决议，这意味着什么？美国全面关税政策最终会取消吗？",
    detail: "当地时间10月30日，央视记者获悉，美国参议院以51票赞同、47票反对的结果通过决议，终止美国总统特朗普在全球范围内实施的全面关税政策。 据悉，美国参议院宣布，已批准终止总统为实施全球关税而宣布的国家紧急状态的联合决议。本周早些时候，参议院已通过两项决议，旨在取消对加拿大和巴西征收的关税。 据悉，这些决议接下来还须经众议院表决。但此前众议院共和党人已多次阻止推翻关税的立法行动，这些决议预计很难在众议院获得投票表决。即便众议院最终通过，国会仍需三分之二绝对多数才能推翻总统否决。美参议院通过终止特朗普全面关税政策决议",
    cover: URL(string: "https://pic1.zhimg.com/50/v2-eb7f2d387159c95c16cefc1af8abe0aa_b.jpg"),
    hotValueDesc:  "646 万热度",
    answerCount: 133,
    followerCount: 547,
    link: URL(string:  "https://www.zhihu.com/question/1967494414290084753")!
  )
  )
}

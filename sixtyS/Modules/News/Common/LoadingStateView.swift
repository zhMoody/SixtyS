//
//  LoadingStateView.swift
//  sixtyS
//
//  Created by 张浩 on 2025/10/27.
//

import SwiftUI

struct LoadingStateView<T, Content: View>: View {
    
    let loadingState: LoadingState<T>
    let onRefresh: () async -> Void
    @ViewBuilder let content: (T) -> Content
    
    var body: some View {
        switch loadingState {
        case .awaitingPermission, .loading:
            loadingView
            
        case .success(let data):
            content(data)
            
        case .failure(let error):
            failureView(for: error)
        }
    }
    
    private var loadingView: some View {
        ProgressView("正在加载")
    }
    
    private func failureView(for error: Error) -> some View {
        VStack(spacing: 20) {
            if error is URLError {
                Image(systemName: "icloud.slash.fill")
            } else {
                Image(systemName: "wifi.exclamationmark")
            }
            
            Text(error.localizedDescription)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button {
                Task {
                    await onRefresh()
                }
            } label: {
                Label("刷新", systemImage: "arrow.clockwise.circle.fill")
                .font(.body)
            }
            .buttonStyle(.bordered)
            .tint(.gray)
        }
        .font(.largeTitle)
    }
}

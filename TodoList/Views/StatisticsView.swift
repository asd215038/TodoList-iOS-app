//
//  StatisticsView.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/27.
//

import SwiftUI

struct StatisticsView: View {
    @ObservedObject var viewModel: TodoViewModel
    
    // 獲取分類統計評語
    private var categoryComment: String {
        let categoryCounts = TodoItem.Category.allCases.map { category in
            (category, viewModel.items.filter { $0.category == category }.count)
        }
        
        if let maxCategory = categoryCounts.max(by: { $0.1 < $1.1 }) {
            switch maxCategory.0 {
            case .work:
                return "你這個工作狂！！"
            case .personal:
                return "私生活也太豐富了吧！"
            case .shopping:
                return "錢錢都花光光了啦！"
            case .other:
                return "這麼多其他事要做？"
            }
        }
        return ""
    }
    
    // 獲取難度統計評語
    private var priorityComment: String {
        let priorityCounts = TodoItem.Priority.allCases.map { priority in
            (priority, viewModel.items.filter { $0.priority == priority }.count)
        }
        
        if let maxPriority = priorityCounts.max(by: { $0.1 < $1.1 }) {
            switch maxPriority.0 {
            case .high:
                return "你也太拚了吧！"
            case .medium:
                return "還不錯嘛～"
            case .low:
                return "你很遜誒！！"
            }
        }
        return ""
    }
    
    var body: some View {
        List {
            // 基本統計
            Section(header: Text("任務統計")) {
                HStack {
                    Text("總任務數")
                    Spacer()
                    Text("\(viewModel.items.count)")
                }
                HStack {
                    Text("已完成")
                    Spacer()
                    Text("\(viewModel.items.filter { $0.isCompleted }.count)")
                }
                HStack {
                    Text("暫緩中")
                    Spacer()
                    Text("\(viewModel.items.filter { $0.status == .paused }.count)")
                }
            }
            
            // 分類統計
            Section(header: HStack {
                Text("分類統計")
                if !categoryComment.isEmpty {
                    Text(categoryComment)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .italic()
                }
            }) {
                ForEach(TodoItem.Category.allCases, id: \.self) { category in
                    HStack {
                        Image(systemName: category.icon)
                            .foregroundColor(getCategoryColor(category))
                        Text(category.rawValue)
                        Spacer()
                        let count = viewModel.items.filter { $0.category == category }.count
                        Text("\(count)")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            // 難度統計
            Section(header: HStack {
                Text("難度統計")
                if !priorityComment.isEmpty {
                    Text(priorityComment)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .italic()
                }
            }) {
                ForEach(TodoItem.Priority.allCases, id: \.self) { priority in
                    HStack {
                        Circle()
                            .fill(priority.color)
                            .frame(width: 12, height: 12)
                        Text(priority.rawValue)
                        Spacer()
                        let count = viewModel.items.filter { $0.priority == priority }.count
                        Text("\(count)")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            // 詳細比例
            Section(header: Text("任務比例")) {
                let totalCount = Double(viewModel.items.count)
                
                if totalCount > 0 {
                    // 完成比例
                    let completedPercentage = (Double(viewModel.items.filter { $0.isCompleted }.count) / totalCount) * 100
                    HStack {
                        Text("完成比例")
                        Spacer()
                        Text(String(format: "%.1f%%", completedPercentage))
                    }
                    
                    // 暫緩比例
                    let pausedPercentage = (Double(viewModel.items.filter { $0.status == .paused }.count) / totalCount) * 100
                    HStack {
                        Text("暫緩比例")
                        Spacer()
                        Text(String(format: "%.1f%%", pausedPercentage))
                    }
                }
            }
        }
    }
    
    private func getCategoryColor(_ category: TodoItem.Category) -> Color {
        switch category {
        case .work:
            return .blue
        case .personal:
            return .green
        case .shopping:
            return .orange
        case .other:
            return .gray
        }
    }
}

//
//  StatisticsView.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/27.
//

import SwiftUI
struct StatisticsView: View {
    @ObservedObject var viewModel: TodoViewModel
    
    var body: some View {
        List {
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
            }
        }
    }
}

//
//  PendingTasksView.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/27.
//

import SwiftUI

struct PendingTasksView: View {
    @ObservedObject var viewModel: TodoViewModel
    
    var pausedItems: [TodoItem] {
        viewModel.items.filter { $0.status == .paused }
    }
    
    var body: some View {
        VStack {
            Text("暫緩任務")
                .font(.headline)
                .padding()
            
            if pausedItems.isEmpty {
                Text("目前沒有暫緩的任務")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(pausedItems) { item in
                        TodoItemRow(item: item, viewModel: viewModel)
                    }
                }
            }
        }
    }
}

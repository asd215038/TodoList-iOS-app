//
//  CompletedTasksView.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/27.
//

import SwiftUI

struct CompletedTasksView: View {
    @ObservedObject var viewModel: TodoViewModel
    
    var completedItems: [TodoItem] {
        viewModel.items.filter { $0.isCompleted }
    }
    
    var body: some View {
        VStack {
            Text("已完成任務")
                .font(.headline)
                .padding()
            
            if completedItems.isEmpty {
                Text("目前沒有已完成的任務")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(completedItems) { item in
                        TodoItemRow(item: item, viewModel: viewModel)
                    }
                }
            }
        }
    }
}

//
//  TodoItemRow.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/10.
//
import SwiftUI

struct TodoItemRow: View {
    let item: TodoItem
    @ObservedObject var viewModel: TodoViewModel
    
    var body: some View {
        NavigationLink(destination: TaskDetailView(item: item, viewModel: viewModel)) {
            HStack {
                // 完成狀態圖標
                Button(action: {
                    viewModel.toggleCompletion(for: item)
                }) {
                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(item.status == .paused ? .gray : (item.isCompleted ? .green : .gray))
                }
                .disabled(item.status == .paused) // 當任務暫緩時禁用完成按鈕
                
                // 主要內容
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(item.title)
                            .strikethrough(item.isCompleted)
                            .foregroundColor(item.status == .paused ? .gray : (item.isCompleted ? .gray : .primary))
                        
                        Circle()
                            .fill(item.priority.color)
                            .frame(width: 8, height: 8)
                        
                        if item.status == .paused {
                            Text("已暫緩")
                                .font(.caption)
                                .foregroundColor(.orange)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.orange.opacity(0.2))
                                .cornerRadius(4)
                        }
                    }
                    
                    if !item.subTasks.isEmpty {
                        let completedCount = item.subTasks.filter { $0.isCompleted }.count
                        Text("\(completedCount)/\(item.subTasks.count) 子任務")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    if let dueDate = item.dueDate {
                        Text(dueDate, style: .date)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Image(systemName: item.category.icon)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 4)
            .opacity(item.status == .paused ? 0.6 : 1.0)
        }
        .listRowBackground(item.isCompleted ? Color.gray.opacity(0.1) : Color(.systemBackground))
    }
}
#Preview {
    TodoItemRow(
        item: TodoItem(
            title: "測試任務",
            priority: .medium,
            category: .work,
            dueDate: Date(),
            isCompleted: false,
            subTasks: []
        ),
        viewModel: TodoViewModel()
    )
}

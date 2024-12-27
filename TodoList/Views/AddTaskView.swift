//
//  AddTaskView.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/10.
//
import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TodoViewModel
    
    @State private var title = ""
    @State private var script = ""
    @State private var priority: TodoItem.Priority = .medium
    @State private var category: TodoItem.Category = .other
    @State private var dueDate = Date()
    @State private var includeDueDate = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("任務資訊")) {
                    TextField("任務名稱", text: $title)
                    VStack(alignment: .leading) {
                            Text("任務描述")  // 標題
                            TextEditor(text: $script)
                                .frame(height: 100)  // 設定固定高度
                                .padding(4)  // 加一點內邊距
                                .background(Color(uiColor: .systemGray6))  // 加入背景色
                                .cornerRadius(8)  // 圓角效果
                        }

                    Picker("優先級", selection: $priority) {
                        ForEach(TodoItem.Priority.allCases, id: \.self) { priority in
                            HStack {
                                Circle()
                                    .fill(priority.color)
                                    .frame(width: 12, height: 12)
                                Text(priority.rawValue)
                            }
                        }
                    }
                    
                    Picker("分類", selection: $category) {
                        ForEach(TodoItem.Category.allCases, id: \.self) { category in
                            Label(category.rawValue, systemImage: category.icon)
                        }
                    }
                }
                
                Section(header: Text("時間")) {
                    Toggle("設定到期日", isOn: $includeDueDate)
                    if includeDueDate {
                        DatePicker("到期日",
                                 selection: $dueDate,
                                 displayedComponents: [.date])
                    }
                }
            }
            .navigationTitle("新增任務")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("新增") {
                        let newItem = TodoItem(
                            title: title,
                            priority: priority,
                            category: category,
                            dueDate: includeDueDate ? dueDate : nil,
                            isCompleted: false,
                            subTasks: []  // 加入這行，初始化為空陣列
                        )
                        viewModel.addItem(newItem)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddTaskView(viewModel: TodoViewModel())
}

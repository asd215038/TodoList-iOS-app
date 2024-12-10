//
//  AddTaskView.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/10.
//
import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: TodoViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var category = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("任務資訊")) {
                    TextField("標題", text: $title)
                    TextField("描述", text: $description)
                    TextField("類別", text: $category)
                    DatePicker("到期時間",
                             selection: $dueDate,
                             displayedComponents: [.date, .hourAndMinute])
                }
            }
            .navigationTitle("新增任務")
            .navigationBarItems(
                leading: Button("取消") {
                    dismiss()
                },
                trailing: Button("儲存") {
                    let newItem = TodoItem(
                        title: title,
                        description: description,
                        dueDate: dueDate,
                        isCompleted: false,
                        category: category,
                        status: .pending
                    )
                    viewModel.addItem(newItem)
                    dismiss()
                }
                .disabled(title.isEmpty)
            )
        }
    }
}

#Preview {
    AddTaskView(viewModel: TodoViewModel())
}

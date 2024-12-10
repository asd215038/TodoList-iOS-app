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
        VStack(alignment: .leading, spacing: 8) {
            Text(item.title)
                .font(.headline)
            
            Text(item.description)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                Text(viewModel.getRemainingTime(for: item))
                    .font(.caption)
                    .padding(4)
                    .background(getRemainingTimeColor(for: item))
                    .cornerRadius(4)
                
                Spacer()
                
                Text(item.status.rawValue)
                    .font(.caption)
                    .padding(4)
                    .background(getStatusColor(for: item))
                    .cornerRadius(4)
            }
        }
        .padding(.vertical, 8)
    }
    
    private func getRemainingTimeColor(for item: TodoItem) -> Color {
        let components = Calendar.current.dateComponents([.hour],
            from: Date(),
            to: item.dueDate)
        
        if let hours = components.hour {
            if hours < 24 {
                return Color.red.opacity(0.2)
            } else if hours < 72 {
                return Color.orange.opacity(0.2)
            }
        }
        return Color.green.opacity(0.2)
    }
    
    private func getStatusColor(for item: TodoItem) -> Color {
        switch item.status {
            case .pending:
                return Color.blue.opacity(0.2)
            case .inProgress:
                return Color.orange.opacity(0.2)
            case .completed:
                return Color.green.opacity(0.2)
        }
    }
}

#Preview {
    TodoItemRow(
        item: TodoItem(
            title: "測試任務",
            description: "這是一個測試任務的描述",
            dueDate: Date().addingTimeInterval(3600 * 24),
            isCompleted: false,
            category: "測試",
            status: .pending
        ),
        viewModel: TodoViewModel()
    )
}

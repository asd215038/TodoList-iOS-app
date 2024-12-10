//
//  TodoViewModel.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/10.
//


import Foundation
import SwiftUI

class TodoViewModel: ObservableObject {
    @Published var items: [TodoItem] = []
    
    func addItem(_ item: TodoItem) {
        items.append(item)
    }
    
    func removeItem(at index: IndexSet) {
        items.remove(atOffsets: index)
    }
    
    func updateItem(_ item: TodoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
        }
    }
    
    func getRemainingTime(for item: TodoItem) -> String {
        let remainingTime = Calendar.current.dateComponents([.day, .hour, .minute], 
            from: Date(), to: item.dueDate)
        
        if let days = remainingTime.day, let hours = remainingTime.hour {
            return "\(days)天 \(hours)小時"
        }
        return "已過期"
    }
}
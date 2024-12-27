//
//  TodoViewModel.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/10.
//

import SwiftUI

class TodoViewModel: ObservableObject {
    @Published var items: [TodoItem] = []
    
    // 獲取主畫面顯示的任務（活動中的任務）
    var activeItems: [TodoItem] {
        items.filter { !$0.isCompleted && $0.status != .paused }
    }
    
    // 獲取已完成的任務
    var completedItems: [TodoItem] {
        items.filter { $0.isCompleted }
    }
    
    // 獲取暫緩的任務
    var pausedItems: [TodoItem] {
        items.filter { $0.status == .paused }
    }
    
    // 現有的方法保持不變
    func addItem(_ item: TodoItem) {
        items.append(item)
    }
    
    func removeItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func toggleCompletion(for item: TodoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            guard items[index].status != .paused else { return }
            items[index].isCompleted.toggle()
        }
    }
    
    func togglePause(for item: TodoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            guard !items[index].isCompleted else { return }
            items[index].status = items[index].status == .paused ? .active : .paused
        }
    }
}

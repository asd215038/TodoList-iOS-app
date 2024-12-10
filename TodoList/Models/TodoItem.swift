//
//  TodoItem.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/10.
//


import Foundation

struct TodoItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var dueDate: Date
    var isCompleted: Bool
    var category: String
    var status: TaskStatus
    
    enum TaskStatus: String, Codable {
        case pending = "待處理"
        case inProgress = "進行中"
        case completed = "已完成"
    }
}
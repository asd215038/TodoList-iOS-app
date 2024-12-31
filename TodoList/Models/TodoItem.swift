//
//  TodoItem.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/10.
//

import SwiftUI
import Foundation
import UniformTypeIdentifiers

struct TodoItem: Identifiable, Transferable, Codable {
    var id: UUID
        var title: String
        var script: String
        var priority: Priority
        var category: Category
        var dueDate: Date?
        var isCompleted: Bool
        var subTasks: [SubTask]
        var status: TaskStatus = .active
    
        enum TaskStatus: String, Codable {
            case active = "進行中"
            case paused = "已暫緩"
            case completed = "已完成"
        }
        
        init(id: UUID = UUID(), title: String, script: String = "", priority: Priority, category: Category, dueDate: Date?, isCompleted: Bool, subTasks: [SubTask]) {
            self.id = id
            self.title = title
            self.script = script
            self.priority = priority
            self.category = category
            self.dueDate = dueDate
            self.isCompleted = isCompleted
            self.subTasks = subTasks
        }
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(for: TodoItem.self, contentType: .json)
    }
    
    // 定義自定義的 contentType
    enum ContentType: String {
        case todoItem = "com.yourapp.todoitem"
    }
    
    // 列舉定義優先級
    enum Priority: Int, CaseIterable, Codable {
        case high = 0
        case medium = 1
        case low = 2
        
        var color: Color {
            switch self {
            case .high: return .red
            case .medium: return .yellow
            case .low: return .green
            }
        }
        
        var rawValue: String {
            switch self {
            case .high: return "高"
            case .medium: return "中"
            case .low: return "低"
            }
        }
    }
    
    // 任務分類
    enum Category: String, CaseIterable, Codable {
        case work = "工作"
        case personal = "個人"
        case shopping = "購物"
        case other = "其他"
        
        var icon: String {
            switch self {
            case .work: return "briefcase"
            case .personal: return "person"
            case .shopping: return "cart"
            case .other: return "square.grid.2x2"
            }
        }
    }
}

// 子任務結構
struct SubTask: Identifiable, Codable {
    var id: UUID  // 改為 var
    var title: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

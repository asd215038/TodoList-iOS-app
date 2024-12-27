//
//  StorageBox.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/27.
//
import SwiftUI

struct StorageBox: View {
    let title: String
    let icon: String
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 24))
            Text(title)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
        .dropDestination(for: TodoItem.self) { items, location in
            // 處理拖放邏輯
            return true
        }
    }
}

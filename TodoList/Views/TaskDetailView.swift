//
//  TaskDetailView.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/27.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let item: TodoItem
    @ObservedObject var viewModel: TodoViewModel
    @State private var showingDeleteAlert = false  // 添加這個狀態來控制確認對話框
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("任務資訊")) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("標題：\(item.title)")
                            
                            HStack {
                                Text("優先級：")
                                Circle()
                                    .fill(item.priority.color)
                                    .frame(width: 12, height: 12)
                                Text(item.priority.rawValue)
                            }
                            
                            HStack {
                                Text("分類：")
                                Image(systemName: item.category.icon)
                                Text(item.category.rawValue)
                            }
                        }
                    }
                    
                    Section(header: Text("時間資訊")) {
                        if let dueDate = item.dueDate {
                            Text("到期日：")
                            Text(dueDate, style: .date)
                        }
                    }
                    
                    if !item.subTasks.isEmpty {
                        Section(header: Text("子任務")) {
                            ForEach(item.subTasks) { subtask in
                                HStack {
                                    Image(systemName: subtask.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(subtask.isCompleted ? .green : .gray)
                                    Text(subtask.title)
                                        .strikethrough(subtask.isCompleted)
                                }
                            }
                        }
                    }
                }
                
                // 底部按鈕
                HStack(spacing: 20) {
                    Button(action: {
                            viewModel.toggleCompletion(for: item)
                            dismiss()
                        }) {
                            VStack {
                                Image(systemName: item.isCompleted ? "arrow.uturn.backward.circle.fill" : "checkmark.circle.fill")
                                Text(item.isCompleted ? "取消完成" : "完成")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .tint(item.isCompleted ? .blue : .green)  // 已完成時使用藍色，未完成時使用綠色
                        .disabled(item.status == .paused)
                        
                        Button(action: {
                            viewModel.togglePause(for: item)
                            dismiss()
                        }) {
                            VStack {
                                Image(systemName: item.status == .paused ? "play.circle.fill" : "pause.circle.fill")
                                Text(item.status == .paused ? "取消暫緩" : "暫緩")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .tint(.orange)
                        .disabled(item.isCompleted)
                        
                        Button(action: {
                            showingDeleteAlert = true  // 顯示確認對話框而不是直接刪除
                        }) {
                            VStack {
                                Image(systemName: "trash.circle.fill")
                                Text("刪除")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .tint(.red)
                    }
                    .padding()
                    .buttonStyle(.bordered)
                }
                .navigationTitle("任務詳情")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("關閉") {
                            dismiss()
                        }
                    }
                }
                // 添加確認對話框
                .alert("確認刪除", isPresented: $showingDeleteAlert) {
                    Button("取消", role: .cancel) { }
                    Button("刪除", role: .destructive) {
                        if let index = viewModel.items.firstIndex(where: { $0.id == item.id }) {
                            viewModel.removeItem(at: IndexSet(integer: index))
                        }
                        dismiss()
                    }
                } message: {
                    Text("確定要刪除這個任務嗎？此操作無法復原。")
                }
            }
        }
    }

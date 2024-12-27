//
//  ContentView.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/10.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TodoViewModel()
    @State private var showingAddTask = false
    @State private var expandedBox: BoxType? = nil
    
    enum BoxType {
        case completed
        case pending
        case statistics
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // 原有的List部分
                    List {
                        ForEach(viewModel.activeItems) { item in
                            TodoItemRow(item: item, viewModel: viewModel)
                                .draggable(item)
                        }
                        .onDelete(perform: viewModel.removeItem)
                    }
                    
                    // 底部三個保管箱
                    HStack(spacing: 12) {
                        StorageBox(
                            title: "已完成",
                            icon: "checkmark.circle.fill",
                            isExpanded: .init(
                                get: { expandedBox == .completed },
                                set: { _ in expandedBox = .completed }
                            )
                        )
                        
                        StorageBox(
                            title: "暫緩",
                            icon: "pause.circle.fill",
                            isExpanded: .init(
                                get: { expandedBox == .pending },
                                set: { _ in expandedBox = .pending }
                            )
                        )
                        
                        StorageBox(
                            title: "統計",
                            icon: "chart.bar.fill",
                            isExpanded: .init(
                                get: { expandedBox == .statistics },
                                set: { _ in expandedBox = .statistics }
                            )
                        )
                    }
                    .padding()
                }
                
                // 彈出視窗
                if let expandedBox = expandedBox {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                self.expandedBox = nil
                            }
                        }
                    
                    VStack {
                        // 根據選擇的保管箱顯示不同內容
                        switch expandedBox {
                        case .completed:
                            CompletedTasksView(viewModel: viewModel)
                        case .pending:
                            PendingTasksView(viewModel: viewModel)
                        case .statistics:
                            StatisticsView(viewModel: viewModel)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 400)
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .padding()
                    .transition(.move(edge: .bottom))
                }
            }
            .navigationTitle("Die辦清單")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask.toggle() }) {
                        Text("新增")
                            .foregroundColor(.black)  // 設定文字顏色為黑色
                            .padding(.horizontal, 12)  // 設定左右內邊距
                            .padding(.vertical, 6)     // 設定上下內邊距
                            .background(Color.gray.opacity(0.3))  // 設定背景色為灰色，透明度0.3
                            .cornerRadius(8)  // 設定圓角
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}

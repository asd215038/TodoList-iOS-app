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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    TodoItemRow(item: item, viewModel: viewModel)
                }
                .onDelete(perform: viewModel.removeItem)
            }
            .navigationTitle("Die辦清單")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask.toggle() }) {
                        Image(systemName: "plus")
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

//
//  StorageBox.swift
//  TodoList
//
//  Created by 訪客使用者 on 2024/12/27.
//
import SwiftUI

struct StorageBox: View {
    let title: String
    let count: Int       // 新增計數參數
    let icon: String
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                VStack {
                    Image(systemName: icon)
                        .font(.system(size: 24))
                    HStack {
                        Text(title)
                        Text("(\(count))")   // 顯示計數
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
        }
    }
}

//
//  AddMemoView.swift
//  db
//
//  Created by 関琢磨 on 2023/01/13.
//

//  AddMemoView.swift

import SwiftUI

struct AddMemoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var urls: String = ""

    var body: some View {
        VStack {
            TextField("タイトル", text: $title)
                .multilineTextAlignment(.center)
                .font(.title).padding(10)
                .background(Color.white.opacity(0.01))
                .cornerRadius(20)
                .shadow(color: .gray, radius: 10)
                .autocapitalization(.none)
            TextEditor(text: $content)
                .scrollContentBackground(Visibility.hidden)
                .font(.body)
                .autocapitalization(.none)
                .background(memoBackgroundView())
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(memoBackgroundView())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {addMemo()}) {
                    Text("保存")
                }
            }
        }
    }
    // 保存ボタン押下時の処理
    private func addMemo() {
        let memo = Memo(context: viewContext)
        if title == "" {
            title = "タイトルなし"
        }
        memo.title = title
        memo.content = content
        memo.createdAt = Date()
        memo.updatedAt = Date()
    // 生成したインスタンスをCoreDataに保存する
        try? viewContext.save()
    
        presentation.wrappedValue.dismiss()
    }
}

struct AddMemoView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoView()
    }
}

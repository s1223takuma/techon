//
//  EditMemoView.swift
//  db
//
//  Created by 関琢磨 on 2023/01/13.
//

//  EditMemoView.swift

//  EditMemoView.swift

import SwiftUI
import CoreData

struct EditMemoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title: String
    @State private var content: String
    private var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
        self.title = memo.title ?? ""
        self.content = memo.content ?? ""
    }
    
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
                .background(memoBackgroundView())
                .autocapitalization(.none)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {saveMemo()}) {
                    Text("更新")
                }
            }
        }
    }
    
    private func saveMemo() {
        memo.title = title
        memo.content = content
        memo.updatedAt = Date()
        
        do {
            try viewContext.save()
        } catch {
            // handle error
        }
    }
}

struct EditMemoView_Previews: PreviewProvider {
    static var previews: some View {
        EditMemoView(memo: Memo())
    }
}

//
//  PasshomeView.swift
//  db
//
//  Created by 関琢磨 on 2023/01/14.
//

import SwiftUI


struct PasshomeView: View {
        @Environment(\.dismiss) private var dismiss
        @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            entity: Pass.entity(),
            sortDescriptors: [NSSortDescriptor(key: "updatedAt", ascending: false)],
            animation: .default
        ) var fetchedPassList: FetchedResults<Pass>
    @State var dateText = ""
    @State var nowDate = Date()
    private let dateFormatter = DateFormatter()
    init() {
        dateFormatter.dateFormat = "YYYY/MM/dd(E) \nHH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ja_jp")
    }
        
        var body: some View {
            NavigationView {
                VStack{
                    List {
                        ForEach(fetchedPassList) { pass in
                            NavigationLink(destination: EditPassView(pass: pass)){
                                HStack{
                                    VStack {
                                        Text(pass.sitename ?? "")
                                            .bold()
                                            .font(.system(size: 15, weight: .medium, design:
                                                    .default))
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity,alignment: .leading)
                                            .lineLimit(1)
                                    }
                                }
                            }
                            
                        }.onDelete(perform: deleteMemo)
                            .padding(.all, 10)
                            .frame(maxWidth: .infinity, minHeight: 120)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(10)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }.listStyle(.plain)
                        .navigationBarTitleDisplayMode(.automatic)
                    NavigationLink(destination: addpassView()) {
                        Text("＋                              ")
                            .font(.title)
                            .padding()
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
                    }
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                                Text(dateText.isEmpty ? "\(dateFormatter.string(from: nowDate))" : dateText)
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                            self.nowDate = Date()
                                            dateText = "\(dateFormatter.string(from: nowDate))"
                                        }
                                    }
                            }
                    }
                    .toolbarBackground(Color(white: 0, opacity: 0), for: .navigationBar)
                }.background(passBackgroundView())
                
                
            }.navigationTitle("パスワード")
                .navigationBarBackButtonHidden(true)
        }
        private func deleteMemo(offsets: IndexSet) {
                offsets.forEach { index in
                    viewContext.delete(fetchedPassList[index])
                }
            // 保存を忘れない
                try? viewContext.save()
            }
    
    }


struct PasshomeView_Previews: PreviewProvider {
    static var previews: some View {
        PasshomeView()
    }
}

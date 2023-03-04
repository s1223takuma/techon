

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Memo.entity(),
        sortDescriptors: [NSSortDescriptor(key: "updatedAt", ascending: false)],
        animation: .default
    ) var fetchedMemoList: FetchedResults<Memo>
    @State var nowDate = Date()
    @State var dateText = ""
    private let dateFormatter = DateFormatter()
    init() {
        dateFormatter.dateFormat = "YYYY/MM/dd(E) \nHH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ja_jp")
    }
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(fetchedMemoList) { memo in
                        NavigationLink(destination: EditMemoView(memo: memo)){
                            VStack {
                                Text(memo.title ?? "")
                                    .bold()
                                    .font(.title)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .lineLimit(1)
                                HStack {
                                    Text (memo.stringUpdatedAt)
                                        .font(.caption)
                                        .lineLimit(1)
                                    Spacer()
                                }
                                }
                           
                            }
                    }.onDelete(perform: deleteMemo)
                        .padding(.all, 10)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .cornerRadius(10)
                        .listRowBackground(Color.clear)
                        .listRowSeparatorTint(.black)
                    
                    
                    
                }
                .listStyle(.plain)
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack{
                            
                        }
                    }
                }
                .toolbarBackground(.clear, for: .navigationBar)
                NavigationLink(destination: AddMemoView()) {
                    Text("＋                              ")
                        .font(.title)
                        .padding()
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
                }.listRowBackground(Color.clear)
                    .padding()
                
                .toolbar {
                    Text(dateText.isEmpty ? "\(dateFormatter.string(from: nowDate))" : dateText)
                        .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                self.nowDate = Date()
                                dateText = "\(dateFormatter.string(from: nowDate))"
                            }
                        }
                }.listRowBackground(Color.clear)
                .toolbarBackground(.clear, for: .navigationBar)

            }.background(memoBackgroundView())
            
            
        }.navigationTitle("メモ")
            .navigationBarBackButtonHidden(true)
    }
    
    private func deleteMemo(offsets: IndexSet) {
            offsets.forEach { index in
                viewContext.delete(fetchedMemoList[index])
            }
        // 保存を忘れない
            try? viewContext.save()
        }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

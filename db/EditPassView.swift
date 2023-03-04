

import SwiftUI
import CoreData
import KeychainAccess

struct EditPassView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var sitename: String
    @State private var password: String
    @State private var userid: String
    @State private var url: String
    private var pass: Pass
    
    init(pass: Pass) {
        self.pass = pass
        self.sitename = pass.sitename ?? ""
        self.password = pass.password ?? ""
        self.userid = pass.userid ?? ""
        self.url = pass.url ?? ""
    }
    let keychain = Keychain(service: "myapp")
    
    
    var body: some View {
        VStack {
            HStack{
                Text(sitename)
                    .font(.title)
                    .padding(20)
            }
            Spacer()
            HStack{
                Text("URL")
                    .bold()
                    .padding()
                TextField("",text: $url)
                    .keyboardType(.URL)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                            .stroke(Color.black, lineWidth: 1.0)
                            .padding(-8.0)
                    )
                    .padding(20)
                    .autocapitalization(.none)
                if let url = URL(string:pass.url ?? "") {
                                    Link("サイトに飛ぶ", destination:url)
                                        .padding()
                                }
            }
            Spacer()
            HStack{
                VStack{
                    Text("サイトで")
                        .bold()
                    Text("使用するID")
                        .bold()
                }
                .padding()
                TextField("",text: $userid)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                            .stroke(Color.black, lineWidth: 1.0)
                            .padding(-8.0)
                    )
                    .padding(16.0)
                    .autocapitalization(.none)
                Button(action:{
                                    UIPasteboard.general.string = pass.userid ?? ""
                                }){
                                    Text("コピー")
                                }.padding()
            }
            Spacer()
            HStack{
                Text("パスワード")
                    .bold()
                    .padding()
                TextField("",text: $password)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                            .stroke(Color.black, lineWidth: 1.0)
                            .padding(-8.0)
                    )
                    .padding(16.0)
                    .autocapitalization(.none)
                Button(action:{
                    password = keychain[sitename] ?? ""
                }){
                    VStack{
                        Image(systemName: "eye")
                        Text("表示")
                    }
                }
                Button(action:{
                                    UIPasteboard.general.string = password
                                }){
                                    Text("コピー")
                                }.padding()
            }
            Spacer()
            
        }.background(passBackgroundView())

        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {saveMemo()}) {
                    Text("更新")
                }
            }
        }.background(passBackgroundView())
    }
    
    private func saveMemo() {
        pass.sitename = sitename
        pass.userid = userid
        pass.url = url
        do {
            try viewContext.save()
        } catch {
            // handle error
        }
        keychain[sitename] = password
    }
}

struct EditPassView_Previews: PreviewProvider {
    static var previews: some View {
        EditPassView(pass: Pass())
    }
}



import SwiftUI
import KeychainAccess

struct addpassView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var sitename: String = ""
    @State private var password: String = ""
    @State private var url: String = ""
    @State private var siteid: String = ""

    var body: some View {
        VStack {
            HStack{
                Text("タイトル")
                    .padding()
                    .bold()
                TextField("", text: $sitename)
                    .font(.title)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                            .stroke(Color.black, lineWidth: 1.0)
                            .padding(-8.0)
                    )
                    .padding(20)
                    .autocapitalization(.none)
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
            }
            Spacer()
            HStack{
                VStack{
                    Text("サイトで使用するIDや")
                        .bold()
                    Text("メールアドレス")
                        .bold()
                }
                TextField("",text: $siteid)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                            .stroke(Color.black, lineWidth: 1.0)
                            .padding(-8.0)
                    )
                    .padding(16.0)
                    .autocapitalization(.none)
            }
            Spacer()
            HStack{
                Text("パスワード")
                    .bold()
                    .padding()
                SecureField("",text: $password)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                            .stroke(Color.black, lineWidth: 1.0)
                            .padding(-8.0)
                    )
                    .padding(16.0)
                    .autocapitalization(.none)
            }
            
        }.background(passBackgroundView())

        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {addPass()}) {
                    Text("保存")
                }
            }
        }.background(passBackgroundView())
    }
    // 保存ボタン押下時の処理
    private func addPass() {
        let pass = Pass(context: viewContext)
        if (sitename == ""){
            sitename = "名前無し"
        }
        pass.sitename = sitename
        pass.url = url
        pass.userid = siteid
        pass.createdAt = Date()
        pass.updatedAt = Date()
    // 生成したインスタンスをCoreDataに保存する
        try? viewContext.save()
        
        let keychain = Keychain(service: "myapp")
        keychain[sitename] = password
    
        presentation.wrappedValue.dismiss()
    }
}

struct addpassView_Previews: PreviewProvider {
    static var previews: some View {
        addpassView()
    }
}




import SwiftUI

import LocalAuthentication

struct ContentView: View {
    @State private var isAuthenticated = false
    init() {
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage.imageWithColor(.black, size: CGSize(width: 2.0, height: 2.0))
    }
    var body: some View {
        Group {
            if isAuthenticated {
                //認証が成功した場合に表示するView
                TabView {
                    HomeView() //1枚目の子ビュー
                        .tabItem {
                            Image(systemName: "doc.text")
                            Text("メモ")//タブバーの①
                        }
                     //2枚目の子ビュー
                    PasshomeView()
                        .tabItem {
                            Image(systemName: "key")
                            Text("パスワード")//タブバーの②
                        }
                }
                .accentColor(.blue)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            } else {
                // 認証が失敗またはまだ行われていない場合に表示するView
                VStack{
                    Button(action: authenticate) {
                        Text("再認証")
                    }
                    Text("※認証に失敗した時パスワード入力はできません")
                }
            }
        }
        .onAppear {
            // Viewが表示されたときに認証を要求
            authenticate()
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // Face IDまたはTouch IDを使用するためのポリシーを設定
        let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
        if context.canEvaluatePolicy(policy, error: &error) {
            // ポリシーが有効な場合は認証を実行
            context.evaluatePolicy(policy, localizedReason: "認証してください") { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // 認証が成功した場合はisAuthenticatedをtrueに設定
                        self.isAuthenticated = true
                    } else {
                        // 認証が失敗した場合はエラーメッセージを表示
                        print(authenticationError?.localizedDescription ?? "認証に失敗しました")
                    }
                }
            }
        } else {
            // ポリシーが無効な場合はエラーメッセージを表示
            print(error?.localizedDescription ?? "Face ID / Touch IDが使用できません")
        }
    }
}
extension UIImage {
    class func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width, height: size.height))
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

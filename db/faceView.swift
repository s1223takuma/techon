//
//  faceView.swift
//  db
//
//  Created by 関琢磨 on 2023/01/24.
//

import SwiftUI
import LocalAuthentication

struct faceView: View {
    @State private var isUnlocked = false

    var body: some View {
        VStack {
            if isUnlocked {
                // show the content of your app
            } else {
                Button("Unlock") {
                    self.authenticate()
                }
            }
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // show an error message
                    }
                }
            }
        } else {
            // show an error message
        }
    }
}

struct faceView_Previews: PreviewProvider {
    static var previews: some View {
        faceView()
    }
}

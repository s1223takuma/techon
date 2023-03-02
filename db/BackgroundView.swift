//
//  BackgroundView.swift
//  db
//
//  Created by 関琢磨 on 2023/02/13.
//

import SwiftUI

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        passBackgroundView()
        memoBackgroundView()
        scndBackgroundView()
    }
}

struct passBackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        }
    }
}



struct memoBackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, Color(red: 2, green: 0.58, blue: 0.23,opacity: 0.5)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct scndBackgroundView: View {
    var body: some View {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 0, endRadius: 500)
                    .edgesIgnoringSafeArea(.all)
            }
    }
}


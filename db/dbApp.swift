//
//  dbApp.swift
//  db
//
//  Created by 関琢磨 on 2023/01/13.
//

import SwiftUI

@main
struct dbApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

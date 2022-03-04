//
//  MyLibApp.swift
//  MyLib
//
//  Created by Matej Malesevic on 04.03.22.
//

import SwiftUI

@main
struct MyLibApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

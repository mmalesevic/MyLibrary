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

    let apiRequest = ApiRequest(urlSession: URLSession.shared)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(VolumeViewModel(apiRequest: apiRequest))
        }
    }
}

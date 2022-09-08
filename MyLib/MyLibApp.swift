//
//  MyLibApp.swift
//  MyLib
//
//  Created by Matej Malesevic on 04.03.22.
//

import SwiftUI

@main
struct MyLibApp: App {

    let apiRequest = ApiRequest(urlSession: URLSession.shared, responseInterceptor: APIResponseInterceptor())
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(VolumeViewModel(apiRequest: apiRequest))
        }
    }
}

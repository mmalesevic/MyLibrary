//
//  ContentView.swift
//  MyLib
//
//  Created by Matej Malesevic on 04.03.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        TabView() {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "doc.text.magnifyingglass")
                }
            LibraryOverview()
                .tabItem{
                    Label("Library", systemImage: "books.vertical")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

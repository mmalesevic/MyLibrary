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
                        .foregroundColor(.Secondary)
                }
            LibraryOverview()
                .tabItem{
                    Label("Library", systemImage: "books.vertical")
                        .foregroundColor(.Secondary)
                }
        }
        .onAppear {

            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = UIColor(.Secondary)
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(.Inactive)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(.Inactive)]
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(.Primary)
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(.Primary)]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
        }
    }
}

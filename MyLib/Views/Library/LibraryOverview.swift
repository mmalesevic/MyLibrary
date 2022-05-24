//
//  LibraryOverview.swift
//  MyLib
//
//  Created by Matej Malesevic on 20.05.22.
//

import SwiftUI
import CoreData

struct LibraryOverview: View {
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    @State var isSearching: Bool = false
    @State var bookList: [VolumeApiModel] = [VolumeApiModel]()
    
    var body: some View {
        VStack {
            SearchBar(isSearching: $isSearching, searchResults: $bookList)
                .overlay(alignment: .top, content: {
                    Color.Secondary
                        .background(.regularMaterial)
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 0)
                })
            List(books) {book in
                VStack{
                    Text(book.title ?? "unknown title")
                    Text(book.subtitle ?? "no subtitle")
                }
            }
        }
    }
}

struct LibraryOverview_Previews: PreviewProvider {
    static var previews: some View {
        LibraryOverview()
    }
}

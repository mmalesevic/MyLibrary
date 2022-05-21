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
    
    var body: some View {
        VStack {
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

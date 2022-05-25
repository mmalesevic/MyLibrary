//
//  LibraryOverview.swift
//  MyLib
//
//  Created by Matej Malesevic on 20.05.22.
//

import SwiftUI

struct LibraryOverview: View {
    @State private var searchTerm: String = ""
    
    var body: some View {
        VStack {
            TextField("", text: $searchTerm)
                .padding()
                .foregroundColor(.Primary)
                .background(Color.Secondary)
                .tint(.Primary)
                .onAppear() {
#if targetEnvironment(simulator)
                    searchTerm = "Book"
#endif
                }
            QueryList(filterKey: "title", filterValue: searchTerm) { (book: Book) in
                VStack{
                    Text(book.title ?? "unknown title")
                    Text(book.subtitle ?? "no subtitle")
                }
                .background(.yellow)
            }
            Spacer()
            
        }
    }
}

struct LibraryOverview_Previews: PreviewProvider {
    static var previews: some View {
        LibraryOverview()
    }
}

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
                .padding(.horizontal, 15)
                .padding()
                .foregroundColor(.Primary)
                .tint(.Primary)
                .background(Color.Secondary)
                .cornerRadius(35, corners: [.bottomLeft, .bottomRight])
                .overlay(Rectangle().frame(height: 1).padding(.top, 25).padding(.horizontal, 26))
                .foregroundColor(.white)
                .overlay(alignment: .top, content: {
                    Color.Secondary
                        .background(.regularMaterial)
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 0)
                })
                .onAppear() {
#if targetEnvironment(simulator)
                    searchTerm = "Herkunft"
#endif
                }
            QueryList(filterKey: "title", filterValue: searchTerm) { (book: Book) in
                HStack(alignment: .top) {
                    VolumeImageView(url: URL(string: book.thumbnailUrl ?? ""))
                    VStack(alignment: .leading) {
                        Text(book.title ?? "unknown title")
                        Text(book.subtitle ?? "no subtitle")
                    }.padding(.top)
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

//
//  SearchResultView.swift
//  MyLib
//
//  Created by Matej Malesevic on 25.05.22.
//

import SwiftUI

struct SearchResultView: View {
    var searchResult: VolumeApiModel
    
    var body: some View {
        VStack (alignment:.leading) {
            HStack(alignment: .top) {
                
                ZStack{
                    Rectangle()
                        .foregroundColor(.Secondary)
                        .cornerRadius(25, corners: [.topLeft, .bottomRight])
                    if let url = searchResult.volumeInfo?.imageLinks?.thumbnail {
                        AsyncImage(url: url)
                    } else {
                        Image(systemName: "photo.fill")
                            .foregroundColor(.Primary)
                            .font(.title)
                    }
                    
                }.frame(width: 80)
                    .aspectRatio(4/3, contentMode: .fit)
                    .padding()
                
                
                VStack (alignment:.leading) {
                    Text(searchResult.volumeInfo?.title ?? "-")
                        .font(.title)
                        .foregroundColor(.Secondary)
                    if let subtitle = searchResult.volumeInfo?.subtitle {
                        Text(subtitle)
                            .font(.subheadline  )
                    }
                    //                    if let year = searchResult.volumeInfo?.publishedDate, let authors = searchResult.volumeInfo?.authors?.joined(separator: ", ") {
                    //                        Text("\(DateFormatter.yearFormatter.string(from: year)) - \(authors)")
                    //                            .font(.body)
                    //                    }
                }.padding([.top], 10)
            }.padding(.trailing)
            
            VStack(alignment: .leading) {
                if let publisher = searchResult.volumeInfo?.publisher {
                    Text("Publisher: \(publisher)")
                        .font(.body)
                }
                if let pagecount = searchResult.volumeInfo?.pageCount {
                    Text("Pages: \(pagecount)")
                        .font(.body)
                }
                if let isbnEntry = searchResult.volumeInfo?.industryIdentifiers?.first(where: {$0.type == "ISBN_13"})?.identifier {
                    Text("ISBN: \(isbnEntry)")
                        .font(.body)
                }
                if let language = searchResult.volumeInfo?.language {
                    Text("Language Code: \(language)")
                        .font(.body)
                }
                if let snippet = searchResult.searchInfo?.textSnippet {
                    Text("\(snippet)")
                        .font(.body)
                        .padding(.vertical)
                }
            }.padding()
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        let searchResult = VolumeApiModel(selfLink: "", volumeInfo: VolumeInfoApiModel(title: "Mastering Bitcoin", subtitle: "Unlocking Digital Cryptocurrencies", authors: ["Andreas M. Antonopoulos"], publisher: "O'Reilly Media", publishedDate: "2022", industryIdentifiers: [IndustryIdentifiersApiModel(type: "ISBN_13", identifier: "978-1-4919-5438-6")], pageCount: 302, language: "de"), kind: "book#softcover", id: UUID().description, etag: nil, searchInfo: SearchInfo(textSnippet: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."))
        SearchResultView(searchResult: searchResult)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}

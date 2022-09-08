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
                
                VolumeImageView(url: searchResult.volumeInfo?.thumbnailUrl)
                
                VStack (alignment:.leading) {
                    Text(searchResult.volumeInfo?.title ?? "-")
                        .font(.title)
                        .foregroundColor(.Secondary)
                    if let subtitle = searchResult.volumeInfo?.subtitle {
                        Text(subtitle)
                            .font(.subheadline  )
                    }
                    if let publishedDate = searchResult.volumeInfo?.publishedDate, let authors = searchResult.volumeInfo?.authors?.joined(separator: ", ") {
                        Text("\(publishedDate) - \(authors)")
                            .font(.body)
                            .padding(.vertical)
                    }
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
                if let isbnEntry = searchResult.volumeInfo?.isbn13 {
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
    
    static func previewBook(name: String) -> VolumeApiModel {
        do {
            let result: VolumeApiModel.APIResult = try JSONDecoder().loadObjectFromFile(fileName: name)
            
            guard let resultItem = result.items?.first else {
                throw ApiError.noResult
            }
            
            return resultItem
            
        } catch {
            return VolumeApiModel(selfLink: "", volumeInfo: VolumeInfoApiModel(title: "Mastering Bitcoin", subtitle: "Unlocking Digital Cryptocurrencies", authors: ["Andreas M. Antonopoulos"], publisher: "O'Reilly Media", publishedDate: "2022", industryIdentifiers: [IndustryIdentifiersApiModel(type: "ISBN_13", identifier: "978-1-4919-5438-6")], pageCount: 302, language: "de"), kind: "book#softcover", id: UUID().description, etag: nil, searchInfo: SearchInfo(textSnippet: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."))
        }
    }
    
    static var previews: some View {
        
        Group{
            SearchResultView(searchResult: previewBook(name: "JRR_Tolkien_The_Hobbit"))
            SearchResultView(searchResult: previewBook(name: ""))
        }
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}

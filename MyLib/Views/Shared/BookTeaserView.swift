//
//  BookTeaserView.swift
//  MyLib
//
//  Created by Matej Malesevic on 02.05.22.
//

import SwiftUI

struct BookTeaserView: View {
    var volume: Volume
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("Title")
                    .foregroundColor(.Secondary.opacity(50))
                    
                Text(volume.volumeInfo?.title ?? "title unknown")
                Spacer()
            }
            HStack(alignment: .top) {
                Text("Authors")
                    .foregroundColor(.Secondary.opacity(50))
                    
                Text(volume.volumeInfo?.authors?.joined(separator: "; ") ?? "authors unknown")
                Spacer()
            }
            HStack(alignment: .top) {
                Text("Publisher")
                    .foregroundColor(.Secondary.opacity(50))
                    
                Text(volume.volumeInfo?.publisher ?? "publisher unknown")
                Spacer()
            }
            Divider()
        }.padding()
    }
}

//struct BookTeaserView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookTeaserView(Vol)
//    }
//}

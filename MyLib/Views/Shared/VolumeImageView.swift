//
//  VolumeImageView.swift
//  MyLib
//
//  Created by Matej Malesevic on 12.06.22.
//

import SwiftUI

struct VolumeImageView: View {
    var url: URL?
    
    var body: some View {
        if let url = url {
            AsyncImage(url: url)
                .frame(width: 100, height: 150)
                .aspectRatio(2/3, contentMode: .fill)
                .cornerRadius(35, corners: [.topLeft, .bottomRight])
                .padding()
        } else {
            ZStack{
                Rectangle()
                    .foregroundColor(.Secondary)
                    .cornerRadius(25, corners: [.topLeft, .bottomRight])
                Image(systemName: "book.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .foregroundColor(.Primary)
                    
                
            }.frame(width: 100, height: 150)
                .aspectRatio(2/3, contentMode: .fill)
                .padding()
        }
    }
}

struct VolumeImageView_Previews: PreviewProvider {
    static var previews: some View {
        VolumeImageView(url: URL(string: ""))
            .previewLayout(.sizeThatFits)
    }
}

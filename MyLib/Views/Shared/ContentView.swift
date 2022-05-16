//
//  ContentView.swift
//  MyLib
//
//  Created by Matej Malesevic on 04.03.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var volumeVM: VolumeViewModel
    
    
    
    var body: some View {
        VStack{
            Section{
                if volumeVM.volumes.count > 0 {
                    ScrollView{
                    ForEach(volumeVM.volumes) { volume in
                        BookTeaserView(volume: volume)
                    }}
                } else {
                    if volumeVM.isSearching {
                        Spacer()
                        ActivityIndicator()
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(Color.Secondary)
                        Spacer()
                    } else {
                        Spacer()
                        Text("no results")
                            .foregroundColor(.Warning)
                        Spacer()
                    }
                }
            }
            HStack{
                SearchBar()
            }
            .background(Color.Secondary)
            .cornerRadius(25)
            
        }.background(Color.Primary)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let api = ApiRequest(urlSession: URLSession(configuration: URLSessionConfiguration.default), responseInterceptor: APIResponseInterceptor())
        
        return ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(VolumeViewModel(apiRequest: api))
    }
}

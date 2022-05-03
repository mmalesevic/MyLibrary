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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var lookupError: Error? = nil
    @State private var displayError: Bool = false
    @State private var searchTerm: String = ""
    
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
                TextField("ISBN Search", text: $searchTerm)
                    .padding()
                    .foregroundColor(Color.Primary)
                    .tint(Color.Primary)
                Button {
                    Task {
                        await search(for: searchTerm)
                    }
                } label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .foregroundColor(.Primary)
                        .font(.title)
                        .padding()
                }
                .alert(lookupError.debugDescription, isPresented: $displayError) {
                    Text("ok")
                }
            }
            .background(Color.Secondary)
            .cornerRadius(25)
            
        }.background(Color.Primary)
    }
    
    func search(for term: String) async {
        do {
            try await volumeVM.lookupISBN(term)
            print(volumeVM.volumes)
        }
        catch ApiError.noResult{
            
        }
        catch let error {
            volumeVM.isSearching = false
            self.displayError = true
            self.lookupError = error
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

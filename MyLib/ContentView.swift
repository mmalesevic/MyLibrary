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
            Text("State: \(volumeVM.isSearching ? "searching": " - ")")
            Spacer()
            HStack{
                Spacer()
                TextField("ISBN Search", text: $searchTerm)
                    .padding()
                Button {
                    Task {
                        await search(for: searchTerm)
                    }
                } label: {
                    Text("Search")
                }
                .alert(lookupError.debugDescription, isPresented: $displayError) {
                    Text("ok")
                }
                .padding()
                Spacer()
            }.padding()
            
            ForEach(volumeVM.volumes) { volume in
                Text(volume.volumeInfo?.title ?? "-")
            }

            Spacer()
        }
    }
    
    func search(for term: String) async {
        do {
            try await volumeVM.lookupISBN(term)
            print(volumeVM.volumes)
        }
        catch let error {
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

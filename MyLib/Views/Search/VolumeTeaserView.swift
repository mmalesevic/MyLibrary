//
//  BookTeaserView.swift
//  MyLib
//
//  Created by Matej Malesevic on 02.05.22.
//
import CoreData
import SwiftUI
import os.log

struct VolumeTeaserView: View {
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    
    @State private var isPresentingSheet: Bool = false
    
    var volume: VolumeApiModel
    
    var body: some View {
        HStack{
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
            }
            Button {
                isPresentingSheet.toggle()
            } label: {
                Label("Add", systemImage: "plus.circle.fill")
            }

        }.padding()
            .sheet(isPresented: $isPresentingSheet, onDismiss: onDismiss) {
                VStack(alignment: .leading) {
                    Text(volume.volumeInfo?.title ?? "title unknown")
                    Text(volume.volumeInfo?.subtitle ?? "title unknown")
                }.padding()
                Button {
                    let book = Book(context: managedObjectContext)
                    book.title = volume.volumeInfo?.title ?? "title missing"
                    if let subtitle = volume.volumeInfo?.subtitle {
                        book.subtitle = subtitle
                    }
                    book.id = UUID()
                    book.volumeId = volume.id
                    
                    do {
                        try managedObjectContext.save()
                        isPresentingSheet.toggle()
                    } catch {
                        os_log("Error when saving volume as book: %{public}@", log: .data, type: .error, error.localizedDescription)
                    }
                    
                } label: {
                    Label("Save to Library", systemImage: "checkmark.shield")
                        .padding()
                }

            }
    }


    func onDismiss() {
        
    }
}

//struct BookTeaserView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookTeaserView(Vol)
//    }
//}

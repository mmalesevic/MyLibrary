//
//  LibrarySearchBar.swift
//  MyLib
//
//  Created by Matej Malesevic on 24.05.22.
//

import SwiftUI
import CoreData



struct QueryList<T: NSManagedObject, TContent: View>: View {
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> TContent) {
        if filterValue.isEmpty {
            fetchRequest = FetchRequest(entity: T.entity(), sortDescriptors: [])
        } else {
            fetchRequest = FetchRequest(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue), animation: .default)
        }
        self.content = content
    }
    
    var fetchRequest: FetchRequest<T>
    var fetchedResult: FetchedResults<T> { fetchRequest.wrappedValue }
    
    let content: (T) -> TContent
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { entry in
            content(entry)
        }
    }
}

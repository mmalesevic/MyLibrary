//
//  DataController.swift
//  MyLib
//
//  Created by Matej Malesevic on 20.05.22.
//

import Foundation
import CoreData
import os.log

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "MyLib")
    
    init(_ inMemory: Bool = false) {
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                os_log("Core Data failed to load: %{public}@", log: .data, type: .error ,error.localizedDescription)
            }
        }
    }
}

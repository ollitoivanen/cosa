//
//  DataController.swift
//  cosa
//
//  Created by Olli Toivanen on 6.11.2022.
//

///Persistent store is the

import Foundation

import CoreData
class DataController: ObservableObject {

    ///Tells CoreData that we want to use this model
    let container = NSPersistentContainer(name: "AlbumModel")

    ///Initializes the container 
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

}

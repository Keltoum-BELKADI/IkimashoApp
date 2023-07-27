//
//  MyPersistenceController.swift
//  Ikimasho
//
//  Created by Kel_Jellysh on 26/07/2023.
//

import Foundation
import CoreData

class MyPersistenceController {
    static let shared = MyPersistenceController()
    let appName = "Ikimasho"
    let urlPath = "/dev/null"
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: appName)
        if inMemory {
            let stores = container.persistentStoreDescriptions
            if let first = stores.first {
                first.url = URL(fileURLWithPath: urlPath)
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: loadCompletion)
    }

    func loadCompletion(store: NSPersistentStoreDescription, error: Error?) {
        guard let e = error else { return }
        print(e.localizedDescription)
    }
}

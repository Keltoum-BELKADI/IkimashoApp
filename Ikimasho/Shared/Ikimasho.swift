//
//  CD_One_To_Many_RelationshipApp.swift
//  Shared
//
//  Created by Haaris Iqubal on 1/8/22.
//

import SwiftUI

@main
struct Ikimasho: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

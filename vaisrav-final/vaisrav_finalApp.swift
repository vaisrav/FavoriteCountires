//
//  vaisrav_finalApp.swift
//  vaisrav-final
//
//  Created by Graphic on 2023-07-11.
//

import SwiftUI

@main
struct vaisrav_finalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

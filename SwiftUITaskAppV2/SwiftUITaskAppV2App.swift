//
//  SwiftUITaskAppV2App.swift
//  SwiftUITaskAppV2
//
//  Created by Paul Franco on 3/21/21.
//

import SwiftUI

@main
struct SwiftUITaskAppV2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

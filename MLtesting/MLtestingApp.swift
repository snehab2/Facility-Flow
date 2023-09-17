//
//  MLtestingApp.swift
//  MLtesting
//
//  Created by Sneha Bista on 9/16/23.
//

import SwiftUI

@main
struct MLtestingApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            HomePage().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

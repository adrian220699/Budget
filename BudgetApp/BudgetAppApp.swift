//
//  BudgetAppApp.swift
//  BudgetApp
//
//  Created by Adrian Flores Herrera on 7/15/26.
//

import SwiftUI

@main
struct BudgetAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
        }
    }
}

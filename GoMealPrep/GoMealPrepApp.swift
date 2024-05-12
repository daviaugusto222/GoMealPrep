//
//  GoMealPrepApp.swift
//  GoMealPrep
//
//  Created by user on 05/05/24.
//

import SwiftUI
import SwiftData

@main
struct GoMealPrepApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Meal.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
    }()

    var body: some Scene {
        WindowGroup {
            TabbarView()
        }
        .modelContainer(sharedModelContainer)
    }
}

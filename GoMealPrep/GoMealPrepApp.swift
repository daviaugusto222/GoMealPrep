//
//  GoMealPrepApp.swift
//  GoMealPrep
//
//  Created by user on 05/05/24.
//

import SwiftUI
import SwiftData
import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}


@main
struct GoMealPrepApp: App {
    
    // To handle app delegate callbacks in an app that uses the SwiftUI lifecycle,
      // you must create an application delegate and attach it to your `App` struct
      // using `UIApplicationDelegateAdaptor`.
      @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var store = TipStore()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Meal.self
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
                .environmentObject(store)
        }
        .modelContainer(sharedModelContainer)
    }
}

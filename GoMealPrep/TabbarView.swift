//
//  TabbarView.swift
//  GoMealPrep
//
//  Created by user on 11/05/24.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            OrganizeView()
                .tabItem {
                    Label("Organizar", systemImage: "menucard")
                }
            MealView()
                .tabItem {
                    Label("Refeições", systemImage: "circle.hexagonpath")
                }
            TipView()
                .tabItem {
                    Label("Doação", systemImage: "heart")
                }
        }
        .fontDesign(.rounded)
        .tint(.green2)
    }
}

#Preview {
    TabbarView()
        .modelContainer(for: Meal.self, inMemory: true)
}

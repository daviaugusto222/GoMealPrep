//
//  Meal.swift
//  GoMealPrep
//
//  Created by user on 08/05/24.
//

import Foundation
import SwiftUI
struct Food: Identifiable, Hashable {
    var name: String
    var icon: String
    var isFavorite: Bool
    var color: Color
    let id = UUID()

    static func goodExamples() -> [Food] {
        return [Food(name: "Apple", icon: "🍎", isFavorite: true, color: .red),
                Food(name: "Orange", icon: "🍊", isFavorite: false, color: .orange),
                Food(name: "Banana", icon: "🍌", isFavorite: false, color: .yellow)
        ]
    }

    static func unhealthyExamples() -> [Food] {
        [Food(name: "Pizza", icon: "🍕", isFavorite: false, color: .blue),
         Food(name: "Burger", icon: "🍔", isFavorite: false, color: .green)]
    }
}

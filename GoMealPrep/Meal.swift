//
//  Meal.swift
//  GoMealPrep
//
//  Created by user on 08/05/24.
//

import Foundation
import SwiftUI
struct Meal: Identifiable, Hashable {
    var name: String
    var quantity: Int
    var fabricated: Date
    var validity: String
    let id = UUID()

    static func goodExamples() -> [Meal] {
        return [Meal(name: "Frango frito com arroz de brócolis e queijo com melancia", quantity: 3, fabricated: Date.now, validity: "10 de maio (4 dias)"),
                Meal(name: "Macarrão com pé de galinha", quantity: 2, fabricated: Date.now, validity: "1 de maio (5 dias)"),
                Meal(name: "Arroz frito com legumes", quantity: 1, fabricated: Date.now, validity: "25 de maio (9 dias)")
        ]
    }

}

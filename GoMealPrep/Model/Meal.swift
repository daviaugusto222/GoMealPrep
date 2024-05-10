//
//  Meal.swift
//  GoMealPrep
//
//  Created by user on 08/05/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class Meal{
    var name: String
    var quantity: Int
    var fabricated: Date
    var validity: String
//    var photo: Image
    let id = UUID()
    var photo: Data?
    
    init(name: String, quantity: Int, fabricated: Date, validity: String, photo: Data?) {
        self.name = name
        self.quantity = quantity
        self.fabricated = fabricated
        self.validity = validity
        self.photo = photo
    }
    
    static func exemple() -> Meal {
        Meal(name: "Componente Meal", quantity: 3, fabricated: Date.now, validity: "2 dias para vencimento", photo: nil)
    }

}

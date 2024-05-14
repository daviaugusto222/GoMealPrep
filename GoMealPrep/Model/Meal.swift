//
//  Meal.swift
//  GoMealPrep
//
//  Created by user on 08/05/24.
//

import Foundation
import SwiftUI
import SwiftData
import PhotosUI

@Model
final class Meal {
    var name: String
    var quantity: Int
    var fabricated: Date
    var expiration: Date
    var photo: Data?
    let id = UUID()
    var expirationFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d 'de' MMM"
        return formatter.string(from: expiration)
    }
    init(name: String, quantity: Int, fabricated: Date, expiration: Date, photo: Data?) {
        self.name = name
        self.quantity = quantity
        self.fabricated = fabricated
        self.expiration = expiration
        self.photo = photo
    }
    static func exempleWithoutPhoto() -> Meal {
        return Meal(name: "Componente Meal", quantity: 3, fabricated: Date.now, expiration: Date.now, photo: Data() )
    }
    static func emptyMeal() -> Meal {
        Meal(name: "", quantity: 1, fabricated: Date.now, expiration: Date.now, photo: nil)
    }

}

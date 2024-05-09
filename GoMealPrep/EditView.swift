//
//  EditView.swift
//  GoMealPrep
//
//  Created by user on 09/05/24.
//

import SwiftUI

struct EditView: View {
    var meal: Meal
    var body: some View {
        Text("Hello, World! \(meal.name)")
    }
}

#Preview {
    EditView(meal: Meal.exemple())
}

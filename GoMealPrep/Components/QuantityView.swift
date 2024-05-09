//
//  QuantityView.swift
//  GoMealPrep
//
//  Created by user on 08/05/24.
//

import SwiftUI

struct QuantityView: View {
    var quantity: Int = 0
    var body: some View {
        HStack(spacing: 4){
            Image(systemName: "circle.circle")
            Text("\(quantity)")
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 5)
        .background(.green1)
        .foregroundStyle(.green2)
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    QuantityView()
}

//
//  OrganizeCardCellView.swift
//  GoMealPrep
//
//  Created by user on 08/05/24.
//

import SwiftUI

struct OrganizeCardCellView: View {
    var mealRow: Meal
    var body: some View {
        HStack(alignment:.top, spacing:8){
            Image(.meal)
                .resizable()
                .frame(width: 103, height: 103)
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 16))
            VStack(alignment: .leading, spacing: 0){
                
                HStack {
                    Spacer()
                    QuantityView(quantity: mealRow.quantity)
                }
                
                VStack(alignment: .leading){
                    Text("\(mealRow.name)")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    Text("\(mealRow.validity)")
                        .font(.system(size: 13))
                        .fontWeight(.regular)
                        .foregroundStyle(.bege2)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background(.white)
        .clipShape(.rect(cornerRadius: 24))
        .shadow(color:Color(red: 0, green: 0, blue: 0,opacity: 0.05), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    OrganizeCardCellView(mealRow: Meal.goodExamples()[0])
        .previewLayout(.sizeThatFits)
}

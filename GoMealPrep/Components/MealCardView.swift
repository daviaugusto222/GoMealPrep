//
//  MealCardView.swift
//  GoMealPrep
//
//  Created by user on 11/05/24.
//

import SwiftUI

struct MealCardView: View {
    var mealRow: Meal
    var useby: String {
        let calendario = Calendar.current
        let componentes = calendario.dateComponents([.day], from: Date.now, to: mealRow.expiration)
        let days = componentes.day! + 1
        if days > 1 {
            return "\(days) dias para vencimento"
        } else if days == 1 {
            return "\(days) dia para vencimento"
        } else {
            return "🤢 Já ta podre"
        }
    }
    var body: some View {
        VStack(alignment: .trailing) {
            QuantityView(quantity: mealRow.quantity)
            Spacer()
            VStack(alignment: .leading, spacing: 4) {
                Text(mealRow.name)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                Text(useby)
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundStyle(.bege2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(2)
            .fontDesign(.rounded)
            .padding(.bottom, 16)
        }
        .padding(8)
        .background {
            if let photo = mealRow.photo, let uiImage = UIImage(data: photo) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fill)
                    .accessibilityHidden(true)
                    .overlay(
                        LinearGradient(gradient: Gradient(
                            colors: [Color.black, Color.black.opacity(0)]),
                                       startPoint: .bottom, endPoint: .top))
            } else {
                ZStack {
                    Color.red
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .foregroundStyle(.green2)
                        .padding()
                }
            }
        }
        .frame(minWidth: 171, idealWidth: 191, maxWidth: .infinity, minHeight: 241, idealHeight: 261, maxHeight: .infinity)
        .clipShape(.rect(cornerRadius: 24))
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    MealCardView(mealRow: Meal.emptyMeal())
}

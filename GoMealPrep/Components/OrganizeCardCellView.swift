//
//  OrganizeCardCellView.swift
//  GoMealPrep
//
//  Created by user on 08/05/24.
//

import SwiftUI

struct OrganizeCardCellView: View {
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
        HStack(alignment:.top, spacing:8){
            
            if let photo = mealRow.photo,
               let uiImage = UIImage(data: photo) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 103, height: 103)
                    .clipShape(.rect(cornerRadius: 16))
            } else {
                HStack{
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 51)
                        .foregroundStyle(.green2)
                }
                .frame(width: 103, height: 103, alignment: .center)
                .background(.green1)
                .clipShape(RoundedRectangle(cornerRadius: 16.0))
            }
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
                    Text(useby)
                        .font(.system(size: 13))
                        .fontWeight(.regular)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background(.cardBackground)
        .clipShape(.rect(cornerRadius: 24))
        .shadow(color:Color(red: 0, green: 0, blue: 0,opacity: 0.05), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    OrganizeCardCellView(mealRow: Meal.exemple())
        .previewLayout(.sizeThatFits)
}

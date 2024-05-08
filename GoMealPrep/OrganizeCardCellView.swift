//
//  OrganizeCardCellView.swift
//  GoMealPrep
//
//  Created by user on 08/05/24.
//

import SwiftUI

struct OrganizeCardCellView: View {
    var body: some View {
        HStack(alignment:.top, spacing:8){
            Image(.meal)
                .resizable()
                .frame(width: 103, height: 103)
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 16))
            VStack(alignment: .trailing){
                
                QuantityView()
                
                VStack(alignment: .leading){
                    Text("Frango frito com arroz de brócolis com mel e mostarda ")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                    Text("2 dias para vencimento")
                        .font(.system(size: 13))
                        .fontWeight(.regular)
                        .foregroundStyle(.bege2)
                }
            }
        }
        .listRowBackground(Color.clear)
        .listRowInsets(.init())
        .listRowSeparator(.hidden)
        .frame(width: .infinity)
        .padding(8)
        .background(.white)
        .clipShape(.rect(cornerRadius: 24))
//        .border(.red)
        .shadow(color:Color(red: 0, green: 0, blue: 0,opacity: 0.05), radius: 5, x: 0, y: 3)
        
    }
}

#Preview {
    OrganizeCardCellView()
        .previewLayout(.sizeThatFits)
}

//
//  OrganizeView.swift
//  GoMealPrep
//
//  Created by user on 08/05/24.
//

import SwiftUI

struct OrganizeView: View {


    var body: some View {
        NavigationStack{
            List(){
                ForEach(Meal.goodExamples()) { meal in
                    OrganizeCardCellView(mealRow: meal)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive){
                        //ação de deletar
                    } label: {
                        Label("", systemImage: "trash.fill" )
                    }
                    .foregroundStyle(.red, .red)
                    .tint(.bege1)
                }
                
                .listRowBackground(Color.clear)
                .listRowInsets(.init())
                .listRowSeparator(.hidden)

            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .padding(.horizontal,16)
            .scrollContentBackground(.hidden)
            .listRowSpacing(16)
            .background(.bege1)
            .navigationTitle("Organizar")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "plus.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.green2, .green1)
                            .font(.system(size: 20))
                    })
                }
            }
            
        }
    }
}

#Preview {
    OrganizeView()
}

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
            List{
                OrganizeCardCellView()
                OrganizeCardCellView()
                OrganizeCardCellView()
                OrganizeCardCellView()
            }
            .listStyle(.plain)
            .padding(16)
            .scrollContentBackground(.hidden)
            .listRowSpacing(16)
            .background(.bege1)
            .navigationTitle("Organizar")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "ellipsis.circle")
                            .symbolRenderingMode(.monochrome)
                            .foregroundStyle(.green2)
                        
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "plus.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.green2, .green1)
                    })
                }
            }
        }
    }
}

#Preview {
    OrganizeView()
}

//
//  AddMealView.swift
//  GoMealPrep
//
//  Created by user on 09/05/24.
//

import SwiftUI
import PhotosUI

struct AddEditMealView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
//    @State private var photo: Data = Data()
//    @State private var nameText: String = ""
//    @State private var quantity: Int = 1
//    @State private var fabricationDate: Date = Date.now
    @FocusState private var nameIsFocused: Bool
    @State var isEdit: Bool
    
    @Bindable var meal: Meal
    
    var body: some View {
        NavigationStack {
            List{
                
                Section{
                    PhotoPickerView(photo: $meal.photo, isEdit: $isEdit)
                }
                .listRowBackground(Color.clear)
                .listRowInsets(.init())
                .listRowSeparator(.hidden)
                
                Section {
                    TextField("Nome do prato", text: $meal.name)
                        .focused($nameIsFocused)
                }
                
                Section {
                    Stepper(value: $meal.quantity, in: 0...50){
                        HStack(alignment: .center){
                            Label("Quantidade", systemImage: "circle.circle")
                            Spacer()
                            Text("\(meal.quantity)")
                                .padding(.horizontal)
                        }
                    }
                    
                }
                
                Section {
                    HStack {
                        DatePicker(selection: $meal.fabricated, displayedComponents: .date){
                            Label("Fabricação", systemImage: "calendar")
                        }
                        .datePickerStyle(.compact)
                        .tint(.green2)
                        // add this nameIsFocused = false
                    }
                    HStack(alignment: .center) {
                        Label("Validade", systemImage: "calendar.badge.clock")
                        Spacer()
                        Text("10 de Maio (4 dias)")
                    }
                } footer: {
                    Text("Data de validade calculada a partir de parâmetros padrões de congelamento.")
                        .multilineTextAlignment(.center)
                }
            }
            .scrollDisabled(true)
            .tint(.bege2)
            .listSectionSpacing(16)
            .navigationTitle(isEdit ? "Editar refeição" :"Adicionar receição")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(){
                        addMeal()
                    } label: {
                        Text(isEdit ? "OK" : "Salvar")
                            .fontWeight(.semibold)
                    }
                    .disabled(meal.name == "" ? true : false)
                    
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .cancel){
                        dismiss()
                    } label: {
                        Text("Cancelar")
                    }
                }
            }
            .tint(.green2)
        }
    }
    
    private func addMeal() {
        withAnimation {
            if !isEdit {
                context.insert(meal)
            }
            dismiss()
        }
    }
}

#Preview {
    AddEditMealView(isEdit: false, meal: Meal.exemple())
}



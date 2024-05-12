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
    
    @State var isEdit: Bool
    @Bindable var meal: Meal
    
    @State private var animate = 0
    
    var timeUntil: Int = 7
    var expiration: Date {
        let calendario = Calendar.current
        meal.expiration = calendario.date(byAdding: .day, value: timeUntil, to: meal.fabricated)!
        return meal.expiration
        }
    
    func formatarData(_ data: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "d 'de' MMM"
            return formatter.string(from: data)
        }
    
    var body: some View {
        NavigationStack {
            
            Form{
                PhotoPickerView(photo: $meal.photo, isEdit: $isEdit)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                    .buttonStyle(.plain)
                    
                
                Section {
                    TextField("Nome do prato", text: $meal.name)
                        .autocorrectionDisabled(false)
                        .scrollDismissesKeyboard(.immediately)
                        .keyboardType(.default)
                        .submitLabel(.done)
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
                    
                    
                    DatePicker(selection: $meal.fabricated, displayedComponents: .date){
                        Label("Fabricação", systemImage: "calendar")
                    }
                    .datePickerStyle(.compact)
                    
                    HStack(alignment: .center) {
                        Label("Validade", systemImage: "calendar.badge.clock")
                        Spacer()
                        Text("\(formatarData(expiration))")
                    }
                } footer: {
                    VStack(spacing: 16){
                        Text("Data de validade calculada a partir de parâmetros padrões de congelamento.")
                            .multilineTextAlignment(.center)
                        HStack{
                            Spacer()
                            Button(role: .destructive){
                                context.delete(meal)
                                dismiss()
                            } label: {
                                Text("Excluir refeição")
                            }
                            Spacer()
                        }
                        .opacity(isEdit ? 1 : 0)
                    }
                }
                
            }
            .contentMargins(.top, 0, for: .scrollContent)
            .scrollDisabled(false)
            .listSectionSpacing(16)
            .navigationTitle(isEdit ? "Editar refeição" :"Adicionar receição")
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(.bege1)
            .listRowInsets(.init())
            .scrollDismissesKeyboard(.interactively)
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
        }
        .tint(.green2)
        
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



//
//  AddMealView.swift
//  GoMealPrep
//
//  Created by user on 09/05/24.
//

import SwiftUI
import PhotosUI

struct AddMealView: View {
    @State private var photoItem: PhotosPickerItem?
    @State private var photoImage: Image = Image(systemName: "photo")
    @State private var nameText: String = ""
    @State private var quantity: Int = 0
    @State private var fabricationDate: Date = Date.now
    
    var body: some View {
        NavigationStack {
            VStack {
                List{
                    ZStack(alignment: .bottom){
                        ZStack{
                            
                            Rectangle()
                                .foregroundStyle(.green1)
                            
                            photoImage
                                .resizable()
                                .foregroundStyle(.green2)
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                        }
                        .frame(width: 125, height: 125)

                        PhotosPicker(selection: $photoItem, matching: .any(of: [.images, .not(.videos)])) {
                            Label("Add", systemImage: "camera")
                                .labelStyle(.titleAndIcon)
                                .font(.system(size: 15))
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                                .foregroundStyle(.green2)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(.bege1)
                                .clipShape(Capsule())
                        }
                        
                    }
                    .onChange(of: photoItem) {
                        Task {
                            if let loaded = try? await photoItem?.loadTransferable(type: Image.self) {
                                photoImage = loaded
                                
                            } else {
                                print("iiih")
                            }
                        }
                    }
                    
                    Section{
                        TextField("Nome do prato", text: $nameText)
                    }
                    
                    Section{
                        Stepper(value: $quantity, in: 0...50){
                            HStack(alignment: .center){
                                Label("Quantidade", systemImage: "circle.circle")
                                Spacer()
                                Text("\(quantity)")
                                    .padding(.horizontal)
                            }
                        }
                    }
                    
                    Section{
                        HStack{
                            DatePicker(selection: $fabricationDate, displayedComponents: .date){
                                Label("Fabricação", systemImage: "calendar")
                            }
                            .datePickerStyle(.compact)
                            .tint(.green2)
                        }
                        HStack(alignment: .center){
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
                .border(.red)
            }
            .navigationTitle("Adicionar receição" )
            
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button{
                        //Salvar
                    } label: {
                        Text("Salvar")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        //Salvar
                    } label: {
                        Text("Cancelar")
                    }
                }
            }
//            .tint(.green2)
        }
    
        
    }
}

#Preview {
    AddMealView()
}

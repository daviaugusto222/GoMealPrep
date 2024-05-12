//
//  PhotoPickerView.swift
//  GoMealPrep
//
//  Created by user on 10/05/24.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @State private var photoItem: PhotosPickerItem?
    @Binding var photo: Data?
    @Binding var isEdit: Bool
    var body: some View {
        
        HStack {
            Spacer()
            ZStack(alignment: .bottom){
                ZStack{
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 51)
                        .foregroundStyle(.green2)
                    
                    if let photo,
                       let uiImage = UIImage(data: photo) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    
                }
                .frame(width: 125, height: 125, alignment: .center)
                .background(.green1)
                .clipShape(RoundedRectangle(cornerRadius: 24.0))
                
                if photo != nil {
                    Button(role: .destructive) {
                        withAnimation {
                            photoItem = nil
                            photo = nil
                        }
                    } label: {
                        Label("Remover", systemImage: "xmark")
                            .labelStyle(.titleAndIcon)
                            .font(.system(size: 15))
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                            .foregroundStyle(.red)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(.begeButton)
                            .clipShape(Capsule())
                    }
                    .shadow(color: .green2.opacity(0.18), radius: 5, x: 0.0, y: 1.0)
                    .alignmentGuide(.bottom, computeValue: { dimension in
                        dimension[VerticalAlignment.center]
                    })
                } else {
                    PhotosPicker(selection: $photoItem, matching: .images) {
                        
                        Label(isEdit == false ? "Add" : "Edit", systemImage: "camera")
                            .labelStyle(.titleAndIcon)
                            .font(.system(size: 15))
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                            .foregroundStyle(.green2)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(.begeButton)
                            .clipShape(Capsule())
                    }
                    .shadow(color: .green2.opacity(0.18), radius: 5, x: 0.0, y: 1.0)
                    .alignmentGuide(.bottom, computeValue: { dimension in
                        dimension[VerticalAlignment.center]
                    })
                }
                
            }
            .padding(.bottom,8)
            .task(id: photoItem) {
                if let data = try? await photoItem?.loadTransferable(type: Data.self) {
                    photo = data
                } else {
                    //                    print("load falhou")
                }
            }
            Spacer()
        }
    }
    
}


#Preview {
    PhotoPickerView(photo: .constant(Data()), isEdit: .constant(false))
}


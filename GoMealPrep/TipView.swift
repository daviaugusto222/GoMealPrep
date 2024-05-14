//
//  TipView.swift
//  GoMealPrep
//
//  Created by user on 11/05/24.
//

import SwiftUI

struct TipView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.bege1, Color.green1.opacity(0.4)],
                startPoint: .bottom, endPoint: .top)
            VStack {
                Group {
                    Text("Está gostando do app? \nAjude um desenvolver indie!")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Sua ajuda será de grande importância para a melhoria futura do app.")
                        .font(.headline)
                        .fontWeight(.regular)
                }
                .multilineTextAlignment(.center)
                Button {
                    // TODO: Add subscription action to buy a tip 0,99
                } label: {
                    TipCardView(title: "Me compre um 🍵", description: "Vou me acalmar e construir a próxima feature com mais tranquilidade.", price: "R$0,99")
                }
                Button {
                    // TODO: Add subscription action to buy a tip 4,99
                } label: {
                    TipCardView(title: "Me compre um 🍪", description: "Um doce sempre cai bem depois do almoço.", price: "R$4,99")
                }
                Button {
                    // TODO: Add subscription action to buy a tip 10,99
                } label: {
                    TipCardView(title: "Me compre uma 🍕", description: "Já vou adicionar isso ao meu planejamento!", price: "R$10,99")
                }
            }
            .buttonStyle(SelectedButton())
            .padding()
        }
        .ignoresSafeArea()
    }
}

struct TipCardView: View {
    var title = "Me compre um chá 🍵"
    var description = "Vou me acalmar e construir a próxima feature com mais tranquilidade."
    var price = "R$1,99"
    @State private var showAlert = false
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.title)
                Text(description)
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundStyle(.title)
            }
            Spacer()
            Button(price) {
                showAlert = true
            }
            .buttonStyle(.borderedProminent)
            .foregroundStyle(.green2)
            .tint(.green1)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Em breve!"), message: Text("Aguarda mais um pouco ainda to aprendendo essa parte ✨"), dismissButton: .default(Text("OK!")))
            }
        }
        .frame(maxWidth: .infinity)
        .fontDesign(.rounded)
    }
}
struct SelectedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 40)
            .padding(.horizontal, 16)
            .background( Color.bege1.opacity(0.7) )
            .overlay {
                RoundedRectangle(cornerRadius: 24.0)
                    .stroke(Color.green1, lineWidth: 6)
                    .opacity(0.4)
            }
            .foregroundStyle(.black)
            .clipShape(RoundedRectangle(cornerRadius: 24.0))
    }
}

#Preview {
    TipView()
}

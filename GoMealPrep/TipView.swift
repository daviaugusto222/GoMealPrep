//
//  TipView.swift
//  GoMealPrep
//
//  Created by user on 11/05/24.
//

import SwiftUI
import StoreKit

struct TipView: View {
    @EnvironmentObject private var store: TipStore
    @Environment(\.dismiss) var dismiss
    @State private var myProduct: Product?
    var body: some View {
        ScrollView {
            ZStack {
                Spacer().containerRelativeFrame([.horizontal, .vertical])
                VStack(alignment: .center) {
                    Spacer(minLength: 40)
                    Group {
                        Image(.tip)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300)
                            .padding(.vertical)
                            .accessibilityLabel("Memoji do desenvolvedor com varios icones ao redor representando hobbies")
                        Text("Está gostando do app? \nAjude um desenvolver indie!")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Sua ajuda será de grande importância para a melhoria futura do app.")
                            .font(.headline)
                            .fontWeight(.regular)
                    }
                    .multilineTextAlignment(.center)
                    ForEach(store.items) { item in
                        TipCardView(item: item)
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 16)
                    .background( Color.bege1.opacity(0.7) )
                    .overlay {
                        RoundedRectangle(cornerRadius: 24.0)
                            .stroke(Color.green1, lineWidth: 6)
                            .opacity(0.4)
                    }
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 24.0))
                    Spacer(minLength: 40)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .task {
                    myProduct = try? await Product.products(for: ["com.david.GoMealPrep.tinyTip"]).first
                }
            }
        }
        .background {
            LinearGradient(
                colors: [Color.bege1, Color.green1.opacity(0.4)],
                startPoint: .bottom, endPoint: .top)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Label("Fechar", systemImage: "xmark.circle.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.green2, .green1)
                        .font(.system(size: 30))
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct TipCardView: View {
    @EnvironmentObject private var store: TipStore
    let item: Product?
    @State private var showAlert = false
    var body: some View {
        HStack(alignment: .center, spacing: 1) {
            VStack(alignment: .leading) {
                Text(item?.displayName ?? "-")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.title)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Text(item?.description ?? "-")
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundStyle(.title)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            Button(item?.displayPrice ?? "-") {
                if let item = item {
                    Task {
                        await store.purchase(item)
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .foregroundStyle(.green2)
            .tint(.green1)
            .onChange(of: store.action) { _, action in
                if action == .successful {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showAlert = true
                        store.reset()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Muito obrigado!"), message: Text("Fico feliz que esteja gostando do app, em breve mais atualizações ✨"), dismissButton: .default(Text("OK!")))
            }
            .alert(isPresented: $store.hasError, error: store.error) {}
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .fontDesign(.rounded)
    }
}

#Preview {
    TipView()
        .environmentObject(TipStore())
}

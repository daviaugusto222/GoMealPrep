//
//  MealView.swift
//  GoMealPrep
//
//  Created by user on 11/05/24.
//

import SwiftUI
import SwiftData

struct MealView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Meal.expiration) private var meals: [Meal]
    @State private var mealSelected: Meal?
    let columns = [ GridItem(.adaptive(minimum: 171, maximum: .infinity), spacing: 16),
                    GridItem(.adaptive(minimum: 171, maximum: .infinity), spacing: 16)]
    var body: some View {
        NavigationStack {
            VStack {
                BannerContentView(navigationTitle: "Banner")
                    .frame(height: 55)
                    .background(.clear)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        Section {
                            ForEach(meals) { meal in
                                MealCardView(mealRow: meal)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Refeições")
                .background(.bege1)
                .overlay {
                    if meals.isEmpty {
                        ContentUnavailableView {
                            Label("Refeições Finalizadas", systemImage: "circle.hexagonpath")
                                .foregroundStyle(.primary, .bege2)
                                .symbolRenderingMode(.hierarchical)
                        } description: {
                            Text("Adicione novas refeições em Organizar para começar uma novo planejamento.")
                        }
                    }
                }
            }
            .background(.bege1)
        }
    }
}

#Preview {
    MealView()
        .modelContainer(for: Meal.self, inMemory: true)
}

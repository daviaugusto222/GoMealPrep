//
//  OrganizeView.swift
//  GoMealPrep
//
//  Created by user on 08/05/24.
//

import SwiftUI
import SwiftData

struct OrganizeView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Meal.expiration) private var meals: [Meal]
    @State private var mealSelected: Meal?
    @State private var showAddMeal = false
    @State private var animate = 0
    var body: some View {
        NavigationStack {
            List {
                ForEach(meals) { meal in
                    Button {
                        mealSelected = meal
                    } label: {
                        OrganizeCardCellView(mealRow: meal)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            context.delete(meal)
                        } label: {
                            Label("Delete", systemImage: "trash.fill" )
                                .labelStyle(.iconOnly)
                        }
                        .foregroundStyle(.red, .red)
                        .tint(.bege1)
                    }
                }
                .listRowBackground(Color.clear)
                .listRowInsets(.init())
                .listRowSeparator(.hidden)
                .padding(.horizontal, 16)
            }
            .navigationTitle("Organizar")
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .listRowSpacing(16)
            .background(.bege1)
            .overlay {
                if meals.isEmpty {
                    ContentUnavailableView {
                        Label("Organize sua alimentação", systemImage: "circle.circle")
                            .foregroundStyle(.primary, .bege2)
                            .symbolRenderingMode(.hierarchical)
                    } description: {
                        Text("Use o + para adicionar as refeições que você planeja para os próximos dias.")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        animate += 1
                        showAddMeal.toggle()
                    } label: {
                        Label("Adicionar Refeição", systemImage: "plus.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.green2, .green1)
                            .font(.system(size: 20))
                    }
                    .symbolEffect(.bounce.up, value: animate)
                    .sensoryFeedback(.selection, trigger: animate)
                    .sheet(isPresented: $showAddMeal) {
                        AddEditMealView(isEdit: false, meal: Meal.emptyMeal())
                            .presentationDetents([.fraction(0.75), .large])
                    }
                }
            }
            .sheet(item: $mealSelected) { item in
                AddEditMealView(isEdit: true, meal: item)
                    .presentationDetents([.fraction(0.75), .large])
            }
            .fontDesign(.rounded)
        }
    }
}

#Preview {
    OrganizeView()
        .modelContainer(for: Meal.self, inMemory: true)
}

//
//  TabbarView.swift
//  GoMealPrep
//
//  Created by user on 11/05/24.
//

import SwiftUI

enum Page: String, Codable {
    case one
    case two
}

struct TabbarView: View {
    @EnvironmentObject private var store: TipStore
    @State private var selection: Page? = .one
    @State private var showTip = false
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            NavigationSplitView {
                VStack {
                    List(selection: $selection) {
                        NavigationLink(value: Page.one) {
                            Label("Organizar", systemImage: "menucard")
                        }
                        NavigationLink(value: Page.two) {
                            Label("Refeições", systemImage: "circle.hexagonpath")
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .navigationTitle("MealMate")
                    Button {
                        showTip.toggle()
                    } label: {
                        Label("Doação", systemImage: "heart")
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(.green1)
                            .fontWeight(.medium)
                            .foregroundStyle(.green2)
                            .overlay {
                                RoundedRectangle(cornerRadius: 24.0)
                                    .stroke(Color.green2, lineWidth: 3)
                                                            .opacity(0.1)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 24.0))
                    }
                    .sheet(isPresented: $showTip) {
                        NavigationStack {
                            TipView()
                        }
                    }
                    .padding()
                }
                .background(.quinary)
            } detail: {
                if let selection {
                    switch selection {
                    case .one:
                        OrganizeView()
                    case .two:
                        MealView()
                    }
                } else {
                    Text("Detail")
                }
            }
            .tint(.green2)
        } else {
            TabView {
                OrganizeView()
                    .tabItem {
                        Label("Organizar", systemImage: "menucard")
                    }
                MealView()
                    .tabItem {
                        Label("Refeições", systemImage: "circle.hexagonpath")
                    }
                TipView()
                    .tabItem {
                        Label("Doação", systemImage: "heart")
                    }
                    .environmentObject(store)
            }
            .fontDesign(.rounded)
            .tint(.green2)
        }
    }
}

#Preview {
    TabbarView()
        .modelContainer(for: Meal.self, inMemory: true)
        .environmentObject(TipStore())
}

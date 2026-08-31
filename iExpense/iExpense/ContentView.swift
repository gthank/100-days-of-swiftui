//
//  ContentView.swift
//  iExpense
//
//  Created by Hank Gay on 8/19/26.
//

import SwiftUI
import Observation

enum ExpenseType: String, Codable, CaseIterable {
    case personal
    case business

    var label: String {
        switch self {
        case .personal:
            "Personal"
        case .business:
            "Business"
        }
    }
}

struct ExpenseItem: Codable, Identifiable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

@Observable
class Expenses {
    private let containsType: ExpenseType

    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: self.containsType.rawValue)
            }
        }
    }

    init(expenseType: ExpenseType) {
        self.containsType = expenseType

        if let savedItems = UserDefaults.standard.data(forKey: self.containsType.rawValue) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @State private var personalExpenses = Expenses(expenseType: .personal)
    @State private var businessExpenses = Expenses(expenseType: .business)
    @State private var isNewExpenseSheetShowing = false

    private var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }

    func removePersonalExpenses(at offsets: IndexSet) {
        personalExpenses.items.remove(atOffsets: offsets)
    }

    func removeBusinessExpenses(at offsets: IndexSet) {
        businessExpenses.items.remove(atOffsets: offsets)
    }

    func fontColorFor(expense: ExpenseItem) -> Color {
        switch expense.amount {
        case 0...10:
            .green
        case 10...100:
            .yellow
        default:
            .red
        }
    }

    func fontWeightFor(expense: ExpenseItem) -> Font.Weight {
        switch expense.amount {
        case 0...10:
            .light
        case 10...100:
            .medium
        default:
            .heavy
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Personal Expenses").font(.largeTitle)
                }
                Section {
                    ForEach(personalExpenses.items) { item in
                        HStack {
                            Text(item.name).font(.headline)
                            Text(item.type.label)

                            Spacer()
                            Text(item.amount, format: .currency(code: currencyCode))
                        }
                        .fontWeight(fontWeightFor(expense: item))
                        .foregroundStyle(fontColorFor(expense: item))
                    }.onDelete(perform: removePersonalExpenses)
                }
                Section {
                    Text("Business Expenses").font(.largeTitle)
                }
                Section {
                    ForEach(businessExpenses.items) { item in
                        HStack {
                            Text(item.name).font(.headline)
                            Text(item.type.label)

                            Spacer()
                            Text(item.amount, format: .currency(code: currencyCode))
                        }
                        .fontWeight(fontWeightFor(expense: item))
                        .foregroundStyle(fontColorFor(expense: item))
                    }.onDelete(perform: removeBusinessExpenses)
                }
            }.toolbar {
                Button("Add Expense", systemImage: "plus") {
                    isNewExpenseSheetShowing = true
                }
            }
            .padding()
        }.navigationTitle("iExpense")
        .sheet(isPresented: $isNewExpenseSheetShowing) {
            AddView(
                personalExpenses: personalExpenses,
                businessExpenses: businessExpenses,
            )
        }
    }
}

#Preview {
    ContentView()
}

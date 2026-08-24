//
//  ContentView.swift
//  iExpense
//
//  Created by Hank Gay on 8/19/26.
//

import SwiftUI
import Observation

struct ExpenseItem: Codable, Identifiable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var isNewExpenseSheetShowing = false

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }.onDelete(perform: removeItems)
            }.toolbar {
                Button("Add Expense", systemImage: "plus") {
                    isNewExpenseSheetShowing = true
                }
            }
        }.navigationTitle("iExpense")
        .sheet(isPresented: $isNewExpenseSheetShowing) {
            AddView(expenses: expenses)
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  iExpense
//
//  Created by Hank Gay on 8/19/26.
//

import SwiftUI
import Observation

struct ExpenseItem {
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]()
}

struct ContentView: View {
    @State private var expenses = Expenses()

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items, id: \.name) { item in
                    Text(item.name)
                }.onDelete(perform: removeItems)
            }.toolbar {
                Button("Add Expense", systemImage: "plus") {
                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 42.0)
                    expenses.items.append(expense)
                }
            }
        }.navigationTitle("iExpense")
    }
}

#Preview {
    ContentView()
}

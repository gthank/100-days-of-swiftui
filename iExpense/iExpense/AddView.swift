//
//  AddView.swift
//  iExpense
//
//  Created by Hank Gay on 8/24/26.
//

import SwiftUI

struct AddView: View {
    let types = ["Business", "Personal"]

    @State private var name = ""
    @State private var type = ""
    @State private var amount: Double = 0.0

    var expenses: Expenses

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField(
                    "Amount",
                    value: $amount,
                    format: .currency(code: "USD"),
                ).keyboardType(.decimalPad)
            }.navigationTitle("New Expense")
                .toolbar {
                    Button("Save") {
                        let item = ExpenseItem(
                            name: name,
                            type: type,
                            amount: amount,
                        )
                        expenses.items.append(item)
                    }
                }
        }
    }
}

#Preview {
    AddView(expenses:Expenses())
}

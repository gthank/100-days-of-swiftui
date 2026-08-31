//
//  AddView.swift
//  iExpense
//
//  Created by Hank Gay on 8/24/26.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var type = ExpenseType.personal
    @State private var amount: Double = 0.0

    var personalExpenses: Expenses
    var businessExpenses: Expenses

    private var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases, id: \.self) {
                        Text($0.label)
                    }
                }

                TextField(
                    "Amount",
                    value: $amount,
                    format: .currency(code: currencyCode),
                ).keyboardType(.decimalPad)
            }.navigationTitle("New Expense")
                .toolbar {
                    Button("Save") {
                        let item = ExpenseItem(
                            name: name,
                            type: type,
                            amount: amount,
                        )
                        switch type {
                        case .personal:
                            personalExpenses.items.append(item)
                        case .business:
                            businessExpenses.items.append(item)
                        }
                        dismiss()
                    }
                }
        }
    }
}

#Preview {
    AddView(
        personalExpenses:Expenses(expenseType: .personal),
        businessExpenses: Expenses(expenseType: .business),
    )
}

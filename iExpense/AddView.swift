//
//  AddView.swift
//  iExpense
//
//  Created by Paul Hudson on 16/10/2023.
//  Modified by Leandro Morais on 2024.05.28

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var type = "Receitas"
    @State private var amount = 0.0

    var expenses: Expenses

    let types = ["Receitas", "Despesas"]

    var body: some View {
        NavigationStack {
            Form {
                
                Picker("Tipo", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.segmented)
                
                TextField("Nome", text: $name)

                TextField("Total", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .font(.title2)
                    .bold()
                
            }
            .navigationTitle("Adicionar transação")
            .toolbar {
                Button("Salvar") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}

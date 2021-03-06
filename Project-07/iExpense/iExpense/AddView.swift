//
//  AddView.swift
//  iExpense
//
//  Created by Woolly on 12/12/20.
//  Copyright © 2020 The Woolly Co. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    
    @State private var name: String = ""
    @State private var type: ExpenseType = .Personal
    @State private var amount: String = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases, id: \.rawValue) { value in
                        Text(value.rawValue).tag(value)
                    }
                }
                TextField("Amount", text: $amount).keyboardType(.numberPad)
            }
            .navigationBarTitle("Add New Expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(amount), !name.isEmpty {
                    let item = ExpenseItem(name: name, type: type, amount: actualAmount)
                    expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    showingAlert = true
                }
            })
            // Challenge 3: validation and alert.
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Invalid Input"), message: Text("Make sure the expense amount is a whole number and the title isn't empty."), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

//
//  ExpensesView.swift
//  iExpense
//
//  Created by Woolly on 12/11/20.
//  Copyright © 2020 The Woolly Co. All rights reserved.
//

import SwiftUI

struct ExpensesView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type.rawValue)
                                .font(.caption)
                        }
                        Spacer()
                        // Challenge 2: expense styling.
                        Text("$\(item.amount)")
                            .foregroundColor(item.amount < 10 ? Color.gray : item.amount < 100 ? Color.black : Color.red)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            // Challenge 1: Edit/Done button.
            .navigationBarItems(leading: EditButton(), trailing:
                                    Button(action: {
                                        showingAddExpense = true
                                    }) { Image(systemName: "plus")})
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
    }
}

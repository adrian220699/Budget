//
//  BudgetDetailView.swift
//  BudgetApp
//
//  Created by Adrian Flores Herrera on 8/31/26.
//

import SwiftUI
internal import CoreData

struct BudgetDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    let budgetCategory: BudgetCategory
    
    @State private var title : String = ""
    @State private var total : String = ""
    
    var isFormValid : Bool {
        guard let totalAsDouble = Double(total) else {return false}
        return !title.isEmpty && !total.isEmpty && totalAsDouble > 0
    }
    
    private func saveTransaction() {
        
        do {
            let transaction = Transaction(context: viewContext)
            transaction.title = title
            transaction.total = Double(total)!
            
            budgetCategory.addToTransactions(transaction)
            
            try viewContext.save()
        } catch {
            print(error)
        }
        
    }
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                VStack (alignment: .leading){
                    Text(budgetCategory.title ?? "")
                        .font(.largeTitle)
                    
                    HStack {
                        Text("Budget: ")
                        Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                        
                    }.fontWeight(.bold)
                }
            }
            
            Form {
                Section {
                    
                    TextField("Title", text: $title)
                    TextField("Total", text: $total)
                    
                } header: {
                    Text("Add Transaction")
                }
                
                HStack {
                    Spacer()
                    Button("Save Transaction") {
                        // save transaction
                        saveTransaction()
                    }.disabled(!isFormValid)
                    Spacer()
                }
            }
            
            // Display the transaction
            
            TransactionListView(request: BudgetCategory.transactionsByCategoryRequest(budgetCategory))
            
            Spacer()
        }.padding()
    }
}

//#Preview {
//    BudgetDetailView(budgetCategory: BudgetCategory())
//}

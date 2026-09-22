//
//  AddBudgetCategoryView.swift
//  BudgetApp
//
//  Created by Adrian Flores Herrera on 7/15/26.
//

import SwiftUI
internal import CoreData

struct AddBudgetCategoryView: View {
    
    @State private var title : String = ""
    @State private var total : Double = 100
    @State private var messages : [String] = []
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.managedObjectContext) private var viewContext
    
    private var budgetCategory : BudgetCategory?
    
    init(budgetCategory: BudgetCategory? = nil) {
        self.budgetCategory = budgetCategory
    }
    
    var isFormValid : Bool {
        
        messages.removeAll()
        
        if title.isEmpty {
            messages.append("Title is required")
        }
        
        if total <= 0 {
            messages.append("Total should be greather than 1")
        }
        
        return messages.count == 0
    }
    
    private func saveOrUpdate() {
        
        if let budgetCategory {
            // Update the existing budget category
            // Get the budget that you need to update

            let budget = BudgetCategory.byId(budgetCategory.objectID)
            budget.title = title
            budget.total = total
            
        } else {
            // Save a new budget category
            let budgetCategory = BudgetCategory(context : viewContext)
            budgetCategory.title = title
            budgetCategory.total = total
            
        }
        
        // save the context
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            print(error)
        }
    }
    var body: some View {
        NavigationStack {
            
            Form {
                TextField("Title", text: $title)
                Slider(value: $total, in: 0...2000, step: 50) {
                    Text("Total")
                } minimumValueLabel: {
                    Text("$0")
                }  maximumValueLabel: {
                    Text("$2000")
                }
                
                Text(total as NSNumber, formatter:  NumberFormatter.currency)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ForEach(messages, id: \.self)  { message in
                    
                    Text(message)
                    
                }
                
            }
            .onAppear() {
                if let budgetCategory {
                    title = budgetCategory.title ?? ""
                    total = budgetCategory.total
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                    
                        if isFormValid {
                            saveOrUpdate()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddBudgetCategoryView()
}

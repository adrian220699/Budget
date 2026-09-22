//
//  ContentView.swift
//  BudgetApp
//
//  Created by Adrian Flores Herrera on 7/15/26.
//

import SwiftUI
internal import CoreData

enum SheetAction: Identifiable {
    
    case add
    case edit(BudgetCategory)
    
    var id: Int {
        switch self {
            case .add:
                return 1
            case .edit(_):
                return 2
        }
    }
    
}

struct ContentView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults : FetchedResults<BudgetCategory>
    
    @State private var sheetAction: SheetAction?

    var total: Double {
        budgetCategoryResults.reduce(0) { result, budgetCategory in
            return result + budgetCategory.total
        }
    }
    
    private func deleteBudgetCategory(budgetCategory : BudgetCategory) {
        viewContext.delete(budgetCategory)
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    private func editBudgetCategory(budgetCategory : BudgetCategory) {
        sheetAction = .edit(budgetCategory)
        
    }
    
    var body: some View {
        
        NavigationStack {
            VStack {
            
                Text(total as NSNumber, formatter: NumberFormatter.currency).fontWeight(.bold)
                
                BudgetListView(budgetCategoryResults: budgetCategoryResults, onDeleteBudgetCategory: deleteBudgetCategory, onEditBudgetCategory: editBudgetCategory)
                
            }
            
            
            .sheet(item: $sheetAction, content: { sheetAction in
                //Display the sheet
                
                switch sheetAction {
                case .add:
                    AddBudgetCategoryView()
                case .edit(let budgetCategory):
                    AddBudgetCategoryView(budgetCategory : budgetCategory)
                }
            })
                .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Category") {
                        
                        sheetAction = .add
                        
                    }
                }
            } .padding()
        }
       
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
}

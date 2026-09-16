//
//  BudgetCategory+CoreDatClass.swift
//  BudgetApp
//
//  Created by Adrian Flores Herrera on 7/15/26.
//

import Foundation
internal import CoreData


@objc(BudgetCategory)
internal class BudgetCategory : NSManagedObject {
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
        
    }
    
    var overSpent: Bool {
        remainingBudgetTotal < 0
    }
    
    var transactionsTotal : Double {
        transactionsArray.reduce(0) { result, transaction in
            
            result + transaction.total
            
        }
    }
    
    var remainingBudgetTotal: Double {
        self.total - transactionsTotal
    }
    
    private var transactionsArray: [Transaction] {
        guard let transactions = transactions else {return [] }
        let allTransactions = (transactions.allObjects as? [Transaction]) ?? []
        
        return allTransactions.sorted { t1, t2 in
            
            t1.dateCreated! > t2.dateCreated!
        }
    }
    
    static func transactionsByCategoryRequest(_ budgetCategory: BudgetCategory) -> NSFetchRequest<Transaction> {
        
        let request = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        
        request.predicate = NSPredicate(format: "category = %@", budgetCategory)
        
        return request
        
    }
    
}

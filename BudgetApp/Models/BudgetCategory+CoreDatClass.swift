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
    
}

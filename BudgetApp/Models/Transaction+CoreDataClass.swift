//
//  Transaction+CoreDataClass.swift
//  BudgetApp
//
//  Created by Adrian Flores Herrera on 8/31/26.
//

import Foundation
internal import CoreData

@objc(Transaction)
internal class Transaction : NSManagedObject {
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }

}

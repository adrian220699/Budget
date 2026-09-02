//
//  CoreDataManager.swift
//  BudgetApp
//
//  Created by Adrian Flores Herrera on 7/15/26.
//


import Foundation
internal import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private var persistentContainer : NSPersistentContainer
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "BudgetModel")
        persistentContainer.loadPersistentStores { description, error in
            
            if let error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
            
        }
        
    }
    
    var viewContext : NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
}

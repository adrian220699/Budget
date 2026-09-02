//
//  NumberFormated+Extensions.swift
//  BudgetApp
//
//  Created by Adrian Flores Herrera on 7/15/26.
//

import Foundation

extension NumberFormatter {
    
    static var currency : NumberFormatter {
        
        let formater = NumberFormatter()
        
        formater.numberStyle = .currency
        
        return formater

    }    
}

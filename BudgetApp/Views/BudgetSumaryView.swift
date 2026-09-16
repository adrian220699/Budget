//
//  BudgetSumaryView.swift
//  BudgetApp
//
//  Created by Adrian Flores Herrera on 9/10/26.
//

import SwiftUI

struct BudgetSumaryView: View {
    
    @ObservedObject var budgetCategory : BudgetCategory
    
    var body: some View {
        VStack {
            Text("\(budgetCategory.overSpent ? "Overspent": "Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
                .foregroundStyle(budgetCategory.overSpent ? .red: .green)
        }
    }
}

//#Preview {
//    BudgetSumaryView()
//}

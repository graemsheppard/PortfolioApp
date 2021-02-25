//
//  AddViewModel.swift
//  MyPort
//
//  Created by Graem Sheppard on 2021-02-18.
//

import Foundation

extension AddView {
    class ViewModel: ObservableObject {
        @Published var symbol: String?
        @Published var purchasePrice: String?
        @Published var quantity: String?
        @Published var date: Date = Date()
        @Published var error: Bool = false
        
        public func submit(completion: () -> Void) {
            self.error = false
            guard let purchasePrice = Double(self.purchasePrice ?? ""), let quantity = Int64(self.quantity ?? ""),
                  let symbol = self.symbol else {
                self.error = true
                return
            }

            let context = AppDataService.getInstance().persistentContainer.viewContext
            
            let trade = Trade(context: context)
            
            trade.date = date
            trade.quantity = quantity
            trade.symbol = symbol.uppercased()
            trade.sharePrice = purchasePrice
            trade.type = TradeType.Purchase.rawValue
            
            do {
                try context.save()
            } catch {
                self.error = true
                return
            }
            completion()
            
        }
    }
}

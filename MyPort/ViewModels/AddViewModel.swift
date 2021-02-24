//
//  AddViewModel.swift
//  MyPort
//
//  Created by Graem Sheppard on 2021-02-18.
//

import Foundation

extension AddView {
    class ViewModel: ObservableObject {
        @Published var symbol: String = ""
        @Published var purchasePrice: String = ""
        @Published var quantity: String = ""
        @Published var date: Date = Date()
        
        public func isValid() -> Bool {
            let purchasePrice: Double? = Double(self.purchasePrice)
            let quantity: Int64? = Int64(self.quantity)
            if let _ = purchasePrice, let _ = quantity {
                return true
            }
            return false
        }
        
        func assignValues(trade: Trade) -> Trade {
            trade.date = self.date
            trade.quantity = Int64(self.quantity)!
            trade.symbol = self.symbol.uppercased()
            trade.sharePrice = Double(self.purchasePrice)!
            trade.type = TradeType.Purchase.rawValue
            return trade
        }
        
        public func submit(completion: @escaping () -> Void) {
            DispatchQueue.main.async {
                let context = AppDataService.getInstance().persistentContainer.viewContext
                var trade = Trade(context: context)
                trade = self.assignValues(trade: trade)
                try! context.save()
                completion()
            }
            
            
        }
    }
}

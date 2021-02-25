//
//  TradesViewModel.swift
//  MyPort
//
//  Created by Graem Sheppard on 2021-02-18.
//

import Foundation
import CoreData

extension LotsView {
    public class ViewModel: ObservableObject {
        @Published var lots: [Lot] = [Lot]()
        var apiData: [Quote]?
        var dataService = AppDataService.getInstance()
        @Published var error: Bool = false
        
        public init() {
            self.getLots()
        }
        
        public func delete (indexSet: IndexSet) {
            let context = self.dataService.persistentContainer.viewContext
            for index in indexSet {
                let id = self.lots[index].id
                guard let trade: Trade = context.object(with: id) as? Trade else { continue }
                context.delete(trade)
            }
            do {
                try context.save()
            } catch {
                self.error = true
                return
            }
            DispatchQueue.main.async {
                self.lots.remove(atOffsets: indexSet)
            }
        }
        
        public func getLots () {
            self.dataService.getTrades(completion: { trades in
                let lots: [Lot] = trades.map({ trade in
                    let lot = Lot(id: trade.objectID,
                                  symbol: trade.symbol,
                                  date: trade.symbol,
                                  purchasePrice:
                                  trade.sharePrice,
                                  currentPrice: trade.sharePrice)
                    return lot
                })
                DispatchQueue.main.async { self.lots = lots }
                let lookupSymbols: Set<String> = Set(lots.map({ lot in return lot.symbol }))
                for symbol in lookupSymbols {
                    print(symbol)
                }
                self.dataService.getMarketData(symbols: lookupSymbols, completion: { quotes in
                    let newLots: [Lot] = lots.map({ lot in
                        var newLot = lot
                        for quote in quotes {
                            if quote.symbol == lot.symbol {
                                newLot.name = quote.shortName ?? "N/A"
                                newLot.currentPrice = quote.regularMarketPrice ?? newLot.currentPrice
                            }
                        }
                        return newLot
                    })
                    DispatchQueue.main.async { self.lots = newLots }
                })
            })
        }
    }
    
    public struct Lot: Identifiable {
        let id: NSManagedObjectID
        var name: String?
        let symbol: String
        let date: String
        let purchasePrice: Double
        var currentPrice: Double
        var percentageChange: Double {
            100 * ((currentPrice / purchasePrice) - 1)
        }
    }
    
}

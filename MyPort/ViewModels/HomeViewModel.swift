//
//  HomeViewVM.swift
//  MyPort
//
//  Created by Graem Sheppard on 2021-02-11.
//

import SwiftUI


extension HomeView {
    class ViewModel: ObservableObject {
        
        @Published var stockList: [StockProfit] = [StockProfit]()
        let dataService: AppDataService = AppDataService.getInstance()
        
        init() {
            
        }
        

    }
    
    struct StockProfit: Identifiable {
        let id: UUID = UUID()
        let name: String
        let symbol: String
        let currentPrice: Double
        let purchasePrice: Double
        var percentageGain: Double {
            return ((currentPrice / purchasePrice - 1) * 100)
        }
    }
}

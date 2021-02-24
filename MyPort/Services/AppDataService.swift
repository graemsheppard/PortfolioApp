//
//  AppDataService.swift
//  MyPort
//
//  Created by Graem Sheppard on 2021-02-11.
//

import Foundation
import Combine
import SwiftUI
import CoreData

class AppDataService {
    
    private static var shared: AppDataService?
    
    static func getInstance() -> AppDataService {
        if self.shared == nil { self.shared = AppDataService() }
        return self.shared!
    }
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyPort")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved Error: \(error), \(error.userInfo)")
            } 
        })
        return container
    }()
    
    func getTrades(completion: @escaping ([Trade]) -> Void) {
        let context = persistentContainer.viewContext
        let sort = NSSortDescriptor(key: #keyPath(Trade.date), ascending: false)
        let fetch: NSFetchRequest = Trade.fetchRequest()
        fetch.sortDescriptors = [sort]
        guard let trades = try? context.fetch(fetch) as [Trade] else { return }
        completion(trades)
    }
    
    func getMarketData(symbols: Set<String>, completion: @escaping ([Quote]) -> Void) {
        var query = "https://yahoo-finance-low-latency.p.rapidapi.com/v6/finance/quote?symbols="
        for symbol in symbols {
            query.append(symbol + ",")
        }
        let url = URL(string: query)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "x-rapidapi-key": "69de07ad99msha789132bd940917p1237e5jsnfec3479625d5",
            "x-rapidapi-host": "yahoo-finance-low-latency.p.rapidapi.com"
        ]
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil { return }

            guard let data = data else { return }
            var response: QuoteResponse?
            response = try? JSONDecoder().decode(QuoteResponse.self, from: data)

            guard let quotes = response?.quoteResponse?.result else { return }
            completion(quotes)
        })
        task.resume()
    }

}

public struct QuoteResponse: Decodable {
    
    let quoteResponse: QuoteResponseBody?
    
}

public struct QuoteResponseBody: Decodable {
    let error: String?
    let result: [Quote]?
    
    
}

public struct Quote: Decodable {
    let regularMarketPrice: Double?
    let symbol: String?
    let shortName: String?
}

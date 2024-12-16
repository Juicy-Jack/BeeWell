//
//  QuoteService.swift
//  BeeWell
//
//  Created by Furkan Doğan on 13.12.2024.
//

import Foundation
import Combine

class QuoteService: ObservableObject {
    
    private let networkManager = NetworkManager.shared
    private var quoteSubscription: AnyCancellable?
    @Published var randomQuote: Quote?
    @Published var dailyQuote: Quote?
    
    func getRandomQuote() {
        quoteSubscription = networkManager.performRequest(endpoint: "random")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: networkManager.handleCompletion, receiveValue: { [weak self] returnedQuotes in
                self?.randomQuote = returnedQuotes.first
                self?.quoteSubscription?.cancel()
            })
    }
    
    func getDailyQuote() {
        quoteSubscription = networkManager.performRequest(endpoint: "today")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: networkManager.handleCompletion, receiveValue: { [weak self] returnedQuotes in
                self?.randomQuote = returnedQuotes.first
                print(self?.randomQuote ?? "hehe")
                self?.quoteSubscription?.cancel()
            })
    }
}
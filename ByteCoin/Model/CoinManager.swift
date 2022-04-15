//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdateCoin(coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager{
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "6D845E4C-A5D2-4042-B5A2-5458264C906F"
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    
                    return
                }
                if let safeDate = data{
                    if let coin = self.parseJSON(coinData: safeDate){
                        self.delegate?.didUpdateCoin(coin: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(coinData: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            
            let base = decodedData.base
            let quote = decodedData.quote
            let rate = decodedData.rate
            
            let coin = CoinModel(base: base, quote: quote, rate: rate)
            return coin
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
}
